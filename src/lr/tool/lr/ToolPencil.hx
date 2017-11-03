package lr.tool.lr;

import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import lr.lines.LineBase;

import global.Common;
import global.SVar;
import lr.tool.IconBase;
import lr.tool.ToolBase;

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
		super(Icon.pencil);
	}
	override public function mouseDown(e:MouseEvent) {
		super.mouseDown(e);
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		this.stroke = new Array();
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, this.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
	}
	
	private function pencil_move(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, this.mod_shift, Common.line_type));
		if (Common.get_distance(c, d) >= Common.line_minLength) {
			var _loc1:LineBase = new LineBase(Common.line_type, x1, y1, x2, y2, this.mod_shift);
			_loc1.ID = SVar.lineID;
			Common.gGrid.cacheLine(_loc1);
			this.stroke.push(_loc1);
			SVar.lineID += 1;
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		}
	}
	override public function mouseUp(e:MouseEvent) {
		super.mouseUp(e);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, pencil_move);
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
		c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, pencil_move_reverse);
	}
	
	private function pencil_move_reverse(e:MouseEvent):Void 
	{
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, this.mod_shift, Common.line_type));
		if (Common.get_distance(c, d) >= Common.line_minLength) {
			var _loc1:LineBase = new LineBase(Common.line_type, x2, y2, x1, y1, !this.mod_shift);
			_loc1.ID = SVar.lineID;
			Common.gGrid.cacheLine(_loc1);
			this.stroke.push(_loc1);
			SVar.lineID += 1;
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		}
	}
	override public function rMouseUp(e:MouseEvent) {
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, pencil_move_reverse);
		Common.gTrack.clear_preview();
	}
}