package ui.tool.lr;

import global.Common;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.utils.Object;
import ui.tool.ToolBase;
import openfl.events.Event;
import lr.line.Grid;

/**
 * ...
 * @author ...
 */
class ToolEraser extends ToolBase
{
	var debug_visualizer:MovieClip;
	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent)
	{
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, erase);
		this.debug_visualizer = new MovieClip();
		Common.gTrack.addChild(this.debug_visualizer);
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, erase);
		Common.gTrack.removeChild(this.debug_visualizer);
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
					var _loc1:Dynamic = Grid.grid[_loc7][_loc5].storage[_loc21];
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
						Common.gGrid.remove_line(_loc1, _loc7, _loc5);
						return;
                    }
                } // end if
            } // end of for...in
        } // end of for
    } // end of for
}