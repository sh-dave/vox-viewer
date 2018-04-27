
import iron.data.SceneFormat;

class SceneSetup {
	public var raw(default, null): TSceneFormat;

	public function new() {
		raw = {
			name: 'MyScene',
			camera_ref: 'MyCamera',
			shader_datas: [{
				name: 'MyShader',
				contexts: [
					{
						name: 'mesh',
						depth_write: true,
						compare_mode: 'less',
						cull_mode: 'clockwise',
						vertex_structure: [
							{ name: 'pos', size: 3 },
							{ name: 'nor', size: 3 },
							{ name: 'col', size: 3 },
						],
						vertex_shader: 'simple_lighting.vert',
						fragment_shader: 'simple_lighting.frag',
						// vertex_shader: 'simple_unlit.vert',
						// fragment_shader: 'simple_unlit.frag',
						// vertex_shader: 'mesh.vert',
						// fragment_shader: 'mesh.frag',
						constants: [
							{
								'link': '_projectionMatrix',
								'name': 'P',
								'type': 'mat4',
							},
							{
								'link': '_worldMatrix',
								'name': 'W',
								'type': 'mat4',
							},
							{
								'link': '_viewMatrix',
								'name': 'V',
								'type': 'mat4',
							},
							// {
							// 	'link': '_normalMatrix',
							// 	'name': 'N',
							// 	'type': 'mat3',
							// },
							// {
							// 	'link': '_worldViewProjectionMatrix',
							// 	'name': 'WVP',
							// 	'type': 'mat4'
							// },
							// {
							// 	'link': '_lampColor',
							// 	'name': 'lightColor',
							// 	'type': 'vec3',
							// },
							// {
							// 	'link': '_lampDirection',
							// 	'name': 'lightDir',
							// 	'type': 'vec3',
							// },
						],
					},
				],
			}],
			material_datas: [{
				name: 'MyMaterial',
				shader: 'MyShader',
				contexts: [
					{
						name: 'mesh',
						bind_constants: [
							// { name: 'color', vec3: col }
						]
					}
				],
			}],
			camera_datas: [{
				name: 'MyCameraData',
				clear_color: toFloat32Array([0.05087608844041824, 0.05087608844041824, 0.05087608844041824, 1.0]),
				near_plane: 0.1,
				far_plane: 1000.0,
				// near_plane: 0.10000000149011612,
				// far_plane: 100.0,
				fov: 2.236642837524414,
				// @:optional var aspect:Null<FastFloat>;
				// frustum_culling: true,
				// @:optional var render_to_texture:Null<Bool>;
				// @:optional var texture_resolution_x:Null<Int>;
				// @:optional var texture_resolution_y:Null<Int>;
				ortho_scale: 150,
			}],
			// lamp_datas: [{
			// 	name: 'MyLampData',
			// 	type: 'point',
			// 	color: toFloat32Array([1.0, 1.0, 1.0, 1.0]),
			// 	strength: 26,
			// 	cast_shadow: true,
			// 	near_plane: 0.10000000149011612,
			// 	far_plane: 50.0,
			// 	fov: 1.5707999467849731,
			// 	lamp_size: 1,
			// 	shadows_bias: 0.00019999999494757503,
			// 	shadowmap_size: 1024,
			// 	shadowmap_cube: true,
			// }],
			mesh_datas: [],
			objects: [
				{
					name: 'MyWorld',
					type: 'object',
					data_ref: '',
					transform: null,
					children: [],
				},
				{
					name: 'MyCamera',
					type: 'camera_object',
					data_ref: 'MyCameraData',
					transform: {
						values: toFloat32Array([
							0.6859206557273865, -0.32401347160339355, 0.6515582203865051, 7.481131553649902,
							0.7276763319969177, 0.305420845746994, -0.6141703724861145, -6.5076398849487305,
							0.0, 0.8953956365585327, 0.44527140259742737, 5.34366512298584,
							0.0, 0.0, 0.0, 1.0
						]),
					},
				},
				// {
				// 	name: 'MyLamp',
				// 	type: 'lamp_object',
				// 	data_ref: 'MyLampData',
				// 	transform: {
				// 		values: toFloat32Array([
				// 			-0.29086464643478394,-0.7711008191108704,0.5663931965827942,11.0,
				// 			0.9551711678504944,-0.1998833566904068,0.21839119493961334,4.0,
				// 			-0.05518905818462372,0.6045247316360474,0.7946722507476807,16.0,
				// 			0.0,0.0,0.0,1.0
				// 		]),
				// 	},
				// },
			],
		}

		iron.data.Data.cachedSceneRaws.set(raw.name, raw);
	}

	static function toFloat32Array( src: Array<Float> ) : kha.arrays.Float32Array {
		var f = new kha.arrays.Float32Array(src.length);
		for (i in 0...src.length) { f.set(i, src[i]); }
		return f;
	}
}
