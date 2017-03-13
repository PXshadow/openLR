package ui.tool.lr;

import lr.line.LineBase;
import lr.line.*;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import global.Common;
import ui.tool.ToolBase;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolPencil extends ToolBase
{
	private var x1:Float;
	private var y1:Float;
	private var x2:Float;
	private var y2:Float;
	private var c:Point;
	private var d:Point;
	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
	}
	
	private function pencil_move(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		d = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gTrack.render_preview_line(new Point(x1, y1), new Point(x2, y2));
		if (Common.get_distance(c, d) >= Common.line_minLength) {
			var _loc1:Dynamic;
			if (Common.line_type == 0) {
				_loc1 = new LineFloor(x1, y1, x2, y2, this.mod_shift);
				Common.gTrack.add_vis_line(_loc1);
			} else if (Common.line_type == 1) {
				_loc1 = new LineAccel(x1, y1, x2, y2, this.mod_shift);
				Common.gTrack.add_vis_line(_loc1);
			} else if (Common.line_type == 2) {
				_loc1 = new LineScene(x1, y1, x2, y2, this.mod_shift);
				Common.gTrack.add_vis_line(_loc1);
			}
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		}
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
		Common.gTrack.clear_preview();
	}
}