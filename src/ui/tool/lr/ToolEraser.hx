package ui.tool.lr;

import global.Common;
import lr.lines.LineBase;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.utils.Object;
import ui.tool.ToolBase;
import openfl.events.Event;
import lr.nodes.B2Grid;
import ui.tool.IconBase;

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
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, erase);
	}
	override public function mouseUp(e:MouseEvent) {
		if (this.list == null || Common.svar_game_mode == "running" || Common.svar_game_mode == "livedraw") {
			Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, erase);
			return;
		}
		if (this.list.length > 0) {
			Common.gGrid.add_to_history("sub", this.list);
		}
		super.mouseUp(e);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, erase);
	}
	private function erase(e:MouseEvent):Void 
	{
		var x:Float = Common.gTrack.mouseX;
		var y:Float = Common.gTrack.mouseY;
		var _loc20:Object = Common.gridPos(x, y);
		var _loc9:Float = 1 / (Common.gTrack.scaleX);
		for (_loc19 in -1...2)
		{
			var _loc7 = (_loc20.x + _loc19);
			if (B2Grid.grid[_loc7] == null)
			{
				continue;
			} // end if
			for (_loc8 in -1...2)
			{
				var _loc5 = (_loc20.y + _loc8);
				if (B2Grid.grid[_loc7][_loc5] == null)
				{
					continue;
				} // end if
				for (_loc21 in 0...B2Grid.grid[_loc7][_loc5].storage.length)
				{
					var _loc1:LineBase = B2Grid.grid[_loc7][_loc5].storage[_loc21];
					if (_loc1 == null) {
						continue;
					}
					var _loc3:Float = x - _loc1.x1;
					var _loc2:Float = y - _loc1.y1;
					var _loc12:Float = Math.sqrt(Math.pow(_loc3, 2) + Math.pow(_loc2, 2));
					var _loc13:Float = Math.sqrt(Math.pow(x - _loc1.x2, 2) + Math.pow(y - _loc1.y2, 2));
					var _loc11:Float = Math.abs(_loc1.nx * _loc3 + _loc1.ny * _loc2);
					var _loc4:Float = (_loc3 * _loc1.dx + _loc2 * _loc1.dy) * _loc1.invSqrDis;
					if (_loc12 < Common.svar_eraser_size * _loc9 || _loc13 < Common.svar_eraser_size * _loc9 || _loc11 < Common.svar_eraser_size * _loc9 && _loc4 >= 0 && _loc4 <= 1)
					{
						if (Common.line_type == -1) {
							Common.gGrid.remove_line(_loc1, _loc7, _loc5);
						} else {
							if (_loc1.type == Common.line_type) {
								Common.gGrid.remove_line(_loc1, _loc7, _loc5);
							}
						}
						try {
							this.list.push(_loc1);
						} catch (e:String) {
							
						}
						return;
                    }
                } // end if
            } // end of for...in
        } // end of for
    } // end of for
}