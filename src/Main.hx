package;

import kex.vox.*;

class Main {
	public static function main() {
        iron.object.LampObject.cascadeCount = 4;
        iron.object.LampObject.cascadeSplitFactor = 0.800000011920929;

		initKha();
	}

	static function initKha() {
		var opts = {
			title: 'vox-viewer',
			samplesPerPixel: 8,
		}

		kha.System.init(opts, kha.Assets.loadEverything.bind(iron.App.init.bind(bootstrap)));
	}

	static function bootstrap() {
		kha.math.Random.init(42);

		var path = new iron.RenderPath();
		path.commands = function() {
			path.setTarget("");
			path.clearTarget(0xff004040, 1.0);
			path.drawMeshes("mesh");
		};

		iron.RenderPath.setActive(path);

		// (DK) delay a frame, so registered iron rendering handlers come first
		kha.Scheduler.addTimeTask(setup, 0);
		// setup();
	}

	// TODO (DK) propose for zui.Ext.initPath()?
	static function initPath() {
#if kha_debug_html5
		var path = untyped __js__('require ("path");');
		var root = path.resolve(untyped __js__('__dirname', './'));
		return root;
#elseif flash
		return '';
#else
		// return kha.System.systemId == "Windows" ? "C:\\Users" : "/";
		return Sys.getCwd();
#end		
	}

	static var debugUi: DebugUi = null;
	static var fileBrowserHandle = zui.Id.handle({ text: initPath() });

	static function setup() {
		debugUi = new DebugUi({ font: kha.Assets.fonts.Inconsolata_Bold });

		debugUi.cmds = [
			function( z ) {
				if (z.panel(zui.Id.handle(), 'BROWSE')) {
					var file = zui.Ext.fileBrowser(z, fileBrowserHandle, false);

					if (StringTools.endsWith(file, '.vox')) {
						previewVox(fileBrowserHandle.text);
					}
				}
			},
			function( z ) {
				if (iron.Scene.active != null) {
					SceneGraphUi.renderSceneGraph(z, iron.Scene.active.root);
				}
			}
		];

		kha.System.notifyOnRender(debugUi.render);
	}

	static var _lastPreviewed = '';

	static function previewVox( file: String ) {
		if (_lastPreviewed == file) {
			return;
		}

		_lastPreviewed = file;

		var ss = new SceneSetup();
		
		kex.vox.IronVoxLoader.loadVoxFromPath(
			file,
			voxLoaded.bind(
				_,
				{ url: file, spawn: true },
				ss,
				function( obj: iron.object.Object ) {
					// var dim = obj.transform.dim;
					// obj.transform.loc.set(dim.x / 2, dim.y / 2, dim.z / 2);
					// obj.transform.buildMatrix();
				}
			),
			voxFailed
		);
	}

	static var _toLoad: Int = 0;

	static function voxLoaded( data: kex.vox.IronVoxLoader.IronVox, asset: { url: String, spawn: Bool }, ss: SceneSetup, then: iron.object.Object -> Void ) {
		for (md in data.mesh_datas) {
			ss.raw.mesh_datas.push(md);
		}

		for (obj in data.objects) {
			obj.spawn = asset.spawn;
			// obj.
			ss.raw.objects[0].children.push(obj); // objects[0] is MyWorld
		}

		if (--_toLoad <= 0) {
			iron.Scene.create(ss.raw, function( sceneObject: iron.object.Object ) {
				trace('scene created');

				// TODO (DK) this is only dummy
				sceneObject.getChild('MyWorld').addTrait(new ArcBall());

				// sceneObject.getChild('MyWorld').addTrait(new SimpleUpdateTrait([
				// 	function() {
				// 		sceneObject.transform.rotate(iron.math.Vec4.zAxis(), 0.01);
				// 		sceneObject.transform.buildMatrix();
				// 	}
				// ]));

				then(sceneObject);
			});
		}
	}

	static function voxFailed( err )
		trace(Std.string(err));
}
