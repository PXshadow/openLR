package lr.tool.editing;

import openfl.events.MouseEvent;

import lr.lines.LineBase;
import global.Common;
import global.CVar;
import global.SVar;

/**
 * ...
 * @author ...
 */
class ToolEraser extends ToolAction
{
	public function new() 
	{
		super();
	}
	override public function leftMouseDown(e:MouseEvent)
	{
		if (SVar.game_mode == GameState.inmenu) return;
		this.erase(e);
		this.leftMouseIsDown = true;
	}
	override public function leftMouseUp(e:MouseEvent) {
		Common.gToolbar.visible = true;
		this.leftMouseIsDown = false;
	}
	override public function rightMouseDown(e:MouseEvent):Void 
	{
		this.swapLine(e);
	}
	
	private function swapLine(e:MouseEvent) 
	{
		if (SVar.game_mode == GameState.inmenu) return;
		var _line = this.locateLine(e);
		if (_line == null) return;
		if (CVar.mod_z) {
			_line.changeBehavior(SwapType.DirectionToggle);
			return;
		} else if (CVar.mod_shift) {
			_line.changeBehavior(SwapType.InverseToggle);
			return;
		} else if (CVar.mod_ctrl) {
			_line.changeBehavior(SwapType.SceneryToggle);
			return;
		} else {
			_line.changeBehavior(SwapType.CollisionCycle);
			return;
		}
	}
	override public function leftMouseMove(e:MouseEvent) 
	{
		if (!this.leftMouseIsDown || SVar.game_mode == GameState.inmenu) return;
		Common.gToolbar.visible = false;
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
	}
}