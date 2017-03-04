package ui.tool.lr;

import lr.line.LineBase;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import global.Common;
import ui.tool.ToolBase;

/**
 * ...
 * @author Kaelan Evans
 */
class Pencil extends ToolBase
{
	private var a:Point;
	private var b:Point;
	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent) {
		a = new Point(Common.gTrack.mouseX, Common.gTrack.mouseY);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
	}
	
	private function pencil_move(e:MouseEvent):Void 
	{
		b = new Point(Common.gTrack.mouseX, Common.gTrack.mouseY);
		Common.gTrack.render_preview_line(a, b);
		if (Common.get_distance(a, b) >= Common.line_minLength) {
			var _loc1 = new LineBase(a, b);
			Common.gTrack.add_vis_line(_loc1);
			a = new Point(Common.gTrack.mouseX, Common.gTrack.mouseY);
		}
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
		Common.gTrack.clear_preview();
	}
}