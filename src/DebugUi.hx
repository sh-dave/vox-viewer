import zui.Id;
import zui.Zui;

typedef DebugUiOpts = {
	font: kha.Font,
}

class DebugUi {
	public var cmds(default, default): Array<Zui -> Void>;

	public function new( opts: DebugUiOpts ) {
		zui.Themes.dark.FILL_WINDOW_BG = true;
		z = new Zui({ font: opts.font });
	}

	var z: Zui;

	public function render( canvas: kha.Canvas ) {
		if (cmds == null) {
			return;
		}

		var g2 = canvas.g2;
		g2.begin(false);
			z.begin(g2);
				if (z.window(Id.handle(), 0, 0, 256, kha.System.windowHeight())) {
					for (cmd in cmds) {
						cmd(z);
					}
				}
			z.end();
		g2.end();
	}
}
