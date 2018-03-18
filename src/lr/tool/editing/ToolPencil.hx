package lr.tool.editing;

import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import lr.lines.LineBase;
import global.Common;
import global.SVar;
import global.CVar;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolPencil extends ToolAction
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
	override public function leftMouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, CVar.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		this.leftMouseIsDown = true;
	}
	override public function leftMouseMove(e:MouseEvent) 
	{
		if (!this.leftMouseIsDown) return;
		Common.gToolbar.visible = false;
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x1, y1, x2, y2, CVar.mod_shift, Common.line_type));
		if (Common.get_distance(c, d) >= Common.line_minLength) {
			var _loc1:LineBase = new LineBase(Common.line_type, x1, y1, x2, y2, CVar.mod_shift);
			Common.gGrid.cacheLine(_loc1);
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		}
	}
	override public function leftMouseUp(e:MouseEvent) {
		Common.gToolbar.visible = true;
		this.leftMouseIsDown = false;
		Common.gTrack.clear_preview();
	}
	override public function rightMouseDown(e:MouseEvent) {
		x1 = Common.gTrack.mouseX;
		y1 = Common.gTrack.mouseY;
		var _locSnapCheck:Array<Dynamic> = Common.gGrid.snap(x1, y1, 1, CVar.mod_shift);
		if (_locSnapCheck[2] == true && Common.line_type != 2) {
			x1 = _locSnapCheck[0];
			y1 = _locSnapCheck[1];
		}
		c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		this.rightMouseIsDown = true;
	}
	
	override public function rightMouseMove(e:MouseEvent) 
	{
		if (!this.rightMouseIsDown) return;
		Common.gToolbar.visible = false;
		x2 = Common.gTrack.mouseX;
		y2 = Common.gTrack.mouseY;
		d = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		Common.gTrack.renderPreview(new LinePreview(x2, y2, x1, y1, !CVar.mod_shift, Common.line_type));
		if (Common.get_distance(c, d) >= Common.line_minLength) {
			var _loc1:LineBase = new LineBase(Common.line_type, x2, y2, x1, y1, !CVar.mod_shift);
			Common.gGrid.cacheLine(_loc1);
			x1 = Common.gTrack.mouseX;
			y1 = Common.gTrack.mouseY;
			c = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		}
	}
	override public function rightMouseUp(e:MouseEvent) {
		Common.gToolbar.visible = true;
		Common.gTimeline.visible = true;
		this.rightMouseIsDown = false;
		Common.gTrack.clear_preview();
	}
}