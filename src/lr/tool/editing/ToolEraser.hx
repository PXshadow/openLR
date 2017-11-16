package lr.tool.editing;

import openfl.Lib;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.utils.Object;
import openfl.events.Event;

import global.Common;
import global.SVar;
import lr.lines.LineBase;
import lr.nodes.Grid;
import lr.tool.IconBase;
import lr.tool.ToolBase;

/**
 * ...
 * @author ...
 */
class ToolEraser extends ToolAction
{
	private var list:Array<LineBase>;
	public function new() 
	{
		super();
	}
	override public function leftMouseDown(e:MouseEvent)
	{
		this.list = new Array();
		this.erase(e);
		this.leftMouseIsDown = true;
	}
	override public function leftMouseUp(e:MouseEvent) {
		if (this.list == null) {
			return;
		}
		if (this.list.length > 0) {
			Common.gGrid.add_to_history("sub", this.list);
		}
		this.leftMouseIsDown = false;
	}
	override public function rightMouseDown(e:MouseEvent):Void 
	{
		this.swapLine(e);
	}
	
	private function swapLine(e:MouseEvent) 
	{
		var _line = this.locateLine(e);
		if (_line == null) return;
		if (mod_z) {
			_line.changeBehavior(SwapType.DirectionToggle);
			return;
		} else if (mod_shift) {
			_line.changeBehavior(SwapType.InverseToggle);
			return;
		} else if (mod_ctrl) {
			_line.changeBehavior(SwapType.SceneryToggle);
			return;
		} else {
			_line.changeBehavior(SwapType.CollisionCycle);
			return;
		}
	}
	override public function leftMouseMove(e:MouseEvent) 
	{
		if (!this.leftMouseIsDown) return;
		this.erase(e);
    }
	
	function erase(e:MouseEvent) 
	{
		var _line = this.locateLine(e);
		if (_line == null) return;
		if (Common.line_type == -1) {
			Common.gGrid.remove_line(_line);
		} else {
			if (_line.type == Common.line_type) {
				Common.gGrid.remove_line(_line);
			}
		}
		try {
			this.list.push(_line);
		} catch (e:String) {
			return;
		}
	}
}