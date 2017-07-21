package ui.tool.lr;

import lr.lines.LineBase;
import lr.lines.types.LineAccel;
import lr.lines.types.LineFloor;
import lr.lines.types.LineScene;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import global.Common;
import ui.tool.ToolBase;
import lr.line.*;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolLine extends ToolBase
{
	private var x1:Float;
	private var y1:Float;
	private var x2:Float;
	private var y2:Float;
	private var c:Point;
	private var d:Point;
	private var valid:Bool = false;
	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		d = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, line_move);
	}
	
	private function line_move(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		if (this.mod_x || Common.cvar_angle_snap) {
			var _locSnap = this.angle_snap(x1, y1, x2, y2);
			x2 = _locSnap[0];
			y2 = _locSnap[1];
		}
		this.valid = true;
		d = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, this.mod_shift, Common.line_type));
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gTrack.clear_preview();
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, line_move);
		if (!valid) {
			return;
		}
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x2, y2, 2, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x2 = _locSnapCheck[0];
			y2 = _locSnapCheck[1];
		}
		if (Common.get_distance(c, d) >= 1) {
			var _loc1:LineBase;
			if (Common.line_type == 0) {
				_loc1 = new LineFloor(x1, y1, x2, y2, this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (Common.line_type == 1) {
				_loc1 = new LineAccel(x1, y1, x2, y2, this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (Common.line_type == 2) {
				_loc1 = new LineScene(x1, y1, x2, y2, this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			}
			Common.sLineID += 1;
		}
		valid = false;
	}
	override public function rMouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		d = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, line_move_reverse);
	}
	
	private function line_move_reverse(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		if (this.mod_x || Common.cvar_angle_snap) {
			var _locSnap = this.angle_snap(x1, y1, x2, y2);
			x2 = _locSnap[0];
			y2 = _locSnap[1];
		}
		d = new Point(Common.gStage.mouseX, Common.gStage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, this.mod_shift, Common.line_type));
	}
	override public function rMouseUp(e:MouseEvent) {
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x2, y2, 2, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x2 = _locSnapCheck[0];
			y2 = _locSnapCheck[1];
		}
		if (Common.get_distance(c, d) >= 1) {
			var _loc1:LineBase;
			if (Common.line_type == 0) {
				_loc1 = new LineFloor(x2, y2, x1, y1, !this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (Common.line_type == 1) {
				_loc1 = new LineAccel(x2, y2, x1, y1, !this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (Common.line_type == 2) {
				_loc1 = new LineScene(x2, y2, x1, y1, !this.mod_shift);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			}
			Common.sLineID += 1;
		}
		Common.gTrack.clear_preview();
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, line_move_reverse);
	}
}