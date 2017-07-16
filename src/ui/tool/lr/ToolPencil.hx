package ui.tool.lr;

import lr.line.LineBase;
import lr.line.*;
import lr.line.types.LineAccel;
import lr.line.types.LineFloor;
import lr.line.types.LineScene;
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
	private var stroke:Array<LineBase>;
	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		this.stroke = new Array();
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
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
			var _loc1:LineBase;
			if (Common.line_type == 0) {
				_loc1 = new LineFloor(x1, y1, x2, y2, this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				this.stroke.push(_loc1);
			} else if (Common.line_type == 1) {
				_loc1 = new LineAccel(x1, y1, x2, y2, this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				this.stroke.push(_loc1);
			} else if (Common.line_type == 2) {
				_loc1 = new LineScene(x1, y1, x2, y2, this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				this.stroke.push(_loc1);
			}
			Common.sLineID += 1;
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		}
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
		Common.gTrack.clear_preview();
		Common.gGrid.cache_stroke(this.stroke);
	}
	override public function rMouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		this.stroke = new Array();
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, pencil_move_reverse);
	}
	
	private function pencil_move_reverse(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		d = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gTrack.render_preview_line(new Point(x1, y1), new Point(x2, y2));
		if (Common.get_distance(c, d) >= Common.line_minLength) {
			var _loc1:LineBase;
			if (Common.line_type == 0) {
				_loc1 = new LineFloor(x2, y2, x1, y1, !this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				this.stroke.push(_loc1);
			} else if (Common.line_type == 1) {
				_loc1 = new LineAccel(x2, y2, x1, y1, !this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				this.stroke.push(_loc1);
			} else if (Common.line_type == 2) {
				_loc1 = new LineScene(x2, y2, x1, y1, !this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				this.stroke.push(_loc1);
			}
			Common.sLineID += 1;
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		}
	}
	override public function rMouseUp(e:MouseEvent) {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, pencil_move_reverse);
		Common.gTrack.clear_preview();
	}
}