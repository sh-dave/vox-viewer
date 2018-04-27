let fs = require('fs');
let path = require('path');
let project = new Project('vox-viewer');
project.targetOptions = {"html5":{},"flash":{},"android":{},"ios":{}};
project.setDebugDir('build/windows');
await project.addProject('build/windows-build');
await project.addProject('E:/projects/vox-viewer/Kha');
if (fs.existsSync(path.join('Libraries/haxe-format-vox', 'korefile.js'))) {
	await project.addProject('Libraries/haxe-format-vox');
}
if (fs.existsSync(path.join('Libraries/iron', 'korefile.js'))) {
	await project.addProject('Libraries/iron');
}
if (fs.existsSync(path.join('Libraries/kex-vox-kha', 'korefile.js'))) {
	await project.addProject('Libraries/kex-vox-kha');
}
if (fs.existsSync(path.join('Libraries/kex-vox-iron', 'korefile.js'))) {
	await project.addProject('Libraries/kex-vox-iron');
}
if (fs.existsSync(path.join('Libraries/zui', 'korefile.js'))) {
	await project.addProject('Libraries/zui');
}
resolve(project);
