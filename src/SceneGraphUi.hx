package;

import zui.Id;
import zui.Zui;

class SceneGraphUi {
	public static function renderSceneGraph( z: Zui, scene: iron.object.Object ) {
		var handle = Id.handle();
		
		if (z.panel(handle, 'SCENE GRAPH', 0, true)) {
			z.indent();
				renderObject(z, handle.nest(0), scene);
				// renderChildren(z, handle.nest(1), scene);
			z.unindent();
		}
	}

	static function renderObject( z: Zui, handle: Handle, o: iron.object.Object ) {
		if (z.panel(handle, o.name, 0, true)) {
			z.indent();
				editableIronVec4(z, handle.nest(0), 'LOCATION', o.transform.loc);
				editableIronQuat(z, handle.nest(1), 'ROTATION', o.transform.rot);
				editableIronVec4(z, handle.nest(2), 'SCALE', o.transform.scale);

				for (i in 0...o.children.length) {
					var o = o.children[i];
					var nested = handle.nest(3 + i);
					renderObject(z, nested, o);
				}				
			z.unindent();
		}
	}

	static function editableIronVec4( z: Zui, handle: Handle, tag: String, v: iron.math.Vec4 ) {
		if (z.panel(handle.nest(0), tag)) {
			z.indent();
			v.x = z.slider(handle.nest(1, { value: v.x }), 'X', v.x - 1, v.x + 1, false, 10, true);
			v.y = z.slider(handle.nest(2, { value: v.y }), 'Y', v.y - 1, v.y + 1, false, 10, true);
			v.z = z.slider(handle.nest(3, { value: v.z }), 'Z', v.z - 1, v.z + 1, false, 10, true);
			v.w = z.slider(handle.nest(4, { value: v.w }), 'W', v.w - 1, v.w + 1, false, 10, true);
			z.unindent();
		}
	}

	static function editableIronQuat( z: Zui, handle: Handle, tag: String, v: iron.math.Quat ) {
		if (z.panel(handle.nest(0), tag)) {
			z.indent();
			var euler = v.getEuler();
			// pitch, roll, yaw
			euler.x = z.slider(handle.nest(1, { value: euler.x }), 'PITCH', v.x - 1, v.x + 1, false, 10, true);
			euler.y = z.slider(handle.nest(2, { value: euler.y }), 'ROLL', v.y - 1, v.y + 1, false, 10, true);
			euler.z = z.slider(handle.nest(3, { value: euler.z }), 'YAW', v.z - 1, v.z + 1, false, 10, true);
			v.fromEuler(euler.x, euler.y, euler.z);
			// v.w = z.slider(handle.nest(4, { value: v.w }), 'W', v.w - 1, v.w + 1, false, 10, true);
			z.unindent();
		}
	}
}
