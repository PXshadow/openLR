package ui.tool.lr;

import openfl.Lib;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.utils.Object;
import openfl.events.Event;

import global.Common;
import global.SVar;
import lr.lines.LineBase;
import lr.nodes.Grid;
import ui.tool.IconBase;
import ui.tool.ToolBase;

/**
 * ...
 * @author ...
 */
class ToolEraser extends ToolBase
{
	private var list:Array<LineBase>;
	public function new() 
	{
		super(Icon.eraser);
	}
	override public function mouseDown(e:MouseEvent)
	{
		super.mouseDown(e);
		this.list = new Array();
		this.erase(e);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, erase);
	}
	override public function mouseUp(e:MouseEvent) {
		if (this.list == null) {
			return;
		}
		if (this.list.length > 0) {
			Common.gGrid.add_to_history("sub", this.list);
		}
		super.mouseUp(e);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, erase);
	}
	override public function rMouseDown(e:MouseEvent):Void 
	{
		super.rMouseDown(e);
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
	private function erase(e:MouseEvent):Void 
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
    } // end of for
}