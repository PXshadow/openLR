package lr.tool.editing;

import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.utils.Object;

import lr.lines.LineBase;
import lr.nodes.GridManager;
import global.Common;
import global.SVar;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolAction 
{
	public var leftMouseIsDown:Bool = false;
	public var rightMouseIsDown:Bool = false;
	
	public function new() 
	{
		
	}
	public function leftMouseDown(event:MouseEvent) {
		
	}
	public function leftMouseUp(event:MouseEvent) {
		
	}
	public function rightMouseDown(event:MouseEvent) {
		
	}
	public function rightMouseUp(event:MouseEvent) {
		
	}
	public function leftMouseMove(event:MouseEvent) {
		
	}
	public function rightMouseMove(event:MouseEvent) {
		
	}
	public function angle_snap(_x1:Float, _y1:Float, _x2:Float, _y2:Float):Array<Float> {
		var angle = Common.get_angle_degrees(new Point(_x1, _y1), new Point(_x2, _y2));
		var angles:Array<Int> = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210, 225, 240, 255, 270, 285, 300, 315, 330, 345, 360];
		var angleToSnap:Int = 0;
		var x:Float = _x2;
		var y:Float = _y2;
		if (angle < 0) {
			angle += 360;
		}
		for (i in 0...angles.length) {
			if (angle > angles[i] && angle < angles[i + 1]) {
				if (angle < angles[i] + 7.5) {
					angleToSnap = angles[i];
					break;
				} else if (angle > angles[i] + 7.5) {
					angleToSnap = angles[i + 1];
					break;
				}
			} else {
				continue;
			}
		}
		var _locDis = Common.get_distance(new Point(_x1, _y1), new Point(_x2, _y2));
		x = _x1 + (_locDis * Math.cos(angleToSnap * 0.0174533));
		y = _y1 + (_locDis * Math.sin(angleToSnap * 0.0174533));
		var _locReturn:Array<Float> = new Array();
		_locReturn = [x, y];
		return(_locReturn);
	}
	public function locateLine(e:MouseEvent, _size:Int = 5):LineBase {
		var x:Float = Common.gTrack.mouseX;
		var y:Float = Common.gTrack.mouseY;
		var _loc20:Object = Common.gridPos(x, y);
		var _loc9:Float = 1 / (Common.gTrack.scaleX);
		for (_loc19 in -1...2)
		{
			var _loc7:Int = (_loc20.x + _loc19);
			if (GridCollision.grid[_loc7] == null)
			{
				continue;
			} // end if
			for (_loc8 in -1...2)
			{
				var _loc5:Int = (_loc20.y + _loc8);
				if (GridCollision.grid[_loc7][_loc5] == null)
				{
					continue;
				} // end if
				for (_loc21 in 0...GridCollision.grid[_loc7][_loc5].primary.length)
				{
					var _loc1:LineBase = GridCollision.grid[_loc7][_loc5].primary[_loc21];
					if (_loc1 == null) {
						continue;
					}
					var _loc3:Float = x - _loc1.x1;
					var _loc2:Float = y - _loc1.y1;
					var _loc12:Float = Math.sqrt(Math.pow(_loc3, 2) + Math.pow(_loc2, 2));
					var _loc13:Float = Math.sqrt(Math.pow(x - _loc1.x2, 2) + Math.pow(y - _loc1.y2, 2));
					var _loc11:Float = Math.abs(_loc1.nx * _loc3 + _loc1.ny * _loc2);
					var _loc4:Float = (_loc3 * _loc1.dx + _loc2 * _loc1.dy) * _loc1.invSqrDis;
					if (_loc12 < (SVar.eraser_size + _size) * _loc9 || _loc13 < (SVar.eraser_size + _size) * _loc9 || _loc11 < SVar.eraser_size * _loc9 && _loc4 >= 0 && _loc4 <= 1)
					{
						return (_loc1);
					}
				}
			}
		}
		return null;
	}
}