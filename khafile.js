let project = new Project('vox-viewer');

project.addParameter('-dce full');
project.addDefine('analyzer_optimize');

project.addAssets('assets/**');
project.addAssets(`assets-${platform}/**`);
project.addShaders('shaders/mesh.frag.glsl');
project.addShaders('shaders/mesh.vert.glsl');
project.addShaders('shaders/simple-lighting.frag.glsl');
project.addShaders('shaders/simple-lighting.vert.glsl');
project.addShaders('shaders/simple-unlit.frag.glsl');
project.addShaders('shaders/simple-unlit.vert.glsl');

project.addLibrary('haxe-format-vox');
project.addLibrary('iron');
project.addLibrary('kex-vox-kha');
project.addLibrary('kex-vox-iron');
project.addLibrary('zui');

project.addSources('src');

project.windowOptions.width = 800;
project.windowOptions.height = 480;

resolve(project);
