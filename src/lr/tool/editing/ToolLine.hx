package lr.tool.editing;

import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import global.Common;
import global.CVar;
import global.SVar;
import lr.tool.ToolBase;
import lr.tool.IconBase;
import lr.lines.LineBase;

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
		super(Icon.line);
	}
	override public function mouseDown(e:MouseEvent) {
		super.mouseDown(e);
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, line_move);
	}
	
	private function line_move(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		if (this.mod_x || CVar.angle_snap) {
			var _locSnap = this.angle_snap(x1, y1, x2, y2);
			x2 = _locSnap[0];
			y2 = _locSnap[1];
		}
		this.valid = true;
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, this.mod_shift, Common.line_type));
	}
	override public function mouseUp(e:MouseEvent) {
		super.mouseUp(e);
		Common.gTrack.clear_preview();
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, line_move);
		if (!valid) {
			return;
		}
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x2, y2, 2, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x2 = _locSnapCheck[0];
			y2 = _locSnapCheck[1];
		}
		if (Common.get_distance(c, d) >= 1) {
			var _loc1:LineBase = new LineBase(Common.line_type, x1, y1, x2, y2, this.mod_shift);
			_loc1.ID = SVar.lineID;
			Common.gGrid.cacheLine(_loc1);
			Common.gGrid.cache_stroke([_loc1]);
			SVar.lineID += 1;
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
		c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, line_move_reverse);
	}
	
	private function line_move_reverse(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		if (this.mod_x || CVar.angle_snap) {
			var _locSnap = this.angle_snap(x1, y1, x2, y2);
			x2 = _locSnap[0];
			y2 = _locSnap[1];
		}
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, this.mod_shift, Common.line_type));
	}
	override public function rMouseUp(e:MouseEvent) {
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x2, y2, 2, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x2 = _locSnapCheck[0];
			y2 = _locSnapCheck[1];
		}
		if (Common.get_distance(c, d) >= 1) {
			var _loc1:LineBase = new LineBase(Common.line_type, x2, y2, x1, y1, !this.mod_shift);
			_loc1.ID = SVar.lineID;
			Common.gGrid.cacheLine(_loc1);
			Common.gGrid.cache_stroke([_loc1]);
			SVar.lineID += 1;
		}
		Common.gTrack.clear_preview();
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, line_move_reverse);
	}
}