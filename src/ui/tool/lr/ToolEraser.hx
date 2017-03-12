package ui.tool.lr;

import global.Common;
import openfl.events.MouseEvent;
import ui.tool.ToolBase;
import openfl.events.Event;
import lr.line.Grid;

/**
 * ...
 * @author ...
 */
class ToolEraser extends ToolBase
{

	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent)
	{
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, erase);
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, erase);
	}
	private function erase(e:MouseEvent):Void 
	{
		var x = Common.gTrack.mouseX;
		var y = Common.gTrack.mouseY;
		var _loc20 = Common.gridPos(x, y);
		var _loc9 = 1 / (Common.gTrack.scaleX * 0.010000);
		for (_loc19 in -1...2)
		{
			var _loc7 = (_loc20.x + _loc19);
			if (Grid.grid[_loc7] == null)
			{
				continue;
			} // end if
			for (_loc8 in -1...2)
			{
				var _loc5 = (_loc20.y + _loc8);
				if (Grid.grid[_loc7][_loc5] == null)
				{
					continue;
				} // end if
				for (_loc21 in 0...Grid.grid[_loc7][_loc5].storage.length)
				{
					var _loc1 = Grid.grid[_loc7][_loc5].storage[_loc21];
					if (_loc1 == null) {
						continue;
					}
					var _loc3 = x - _loc1.a.x;
					var _loc2 = y - _loc1.a.y;
					var _loc12 = Math.sqrt(Math.pow(_loc3, 2) + Math.pow(_loc2, 2));
					var _loc13 = Math.sqrt(Math.pow(x - _loc1.b.x, 2) + Math.pow(y - _loc1.b.y, 2));
					var _loc11 = Math.abs(_loc1.n.x * _loc3 + _loc1.n.y * _loc2);
					var _loc4 = (_loc3 * _loc1.d.x + _loc2 * _loc1.d.y) * _loc1.invSqrDis;
					if (_loc12 < Common.svar_eraser_size || _loc13 < Common.svar_eraser_size || _loc11 < Common.svar_eraser_size && _loc4 >= 0 && _loc4 <= 1)
					{
						Common.gGrid.remove_line(_loc1, _loc7, _loc5);
						return;
                    } else {
						continue;
					}
                } // end if
            } // end of for...in
        } // end of for
    } // end of for
}