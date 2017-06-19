package lr.line;

import openfl.utils.Object;

import lr.rider.phys.CPoint;
import lr.line.LineBase;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class VisGrid 
{
	public static var gridSize:Int = 1000;
	public static var grid:Map<Int, Map<Int, Object>>;
	public static var currentVisualIndex:Array<LineBase>;
	public static var tempVisualIndex:Array<LineBase>;
	public function new() 
	{
		VisGrid.grid = new Map();
		VisGrid.currentVisualIndex = new Array();
		VisGrid.tempVisualIndex = new Array();
		Common.gVisGrid = this;
	}
	public function registerInGrid(line:LineBase) //This function is where the "boundaries" are produced
	{
		var _loc1:Object = VisGrid.gridPosVis(line.x1, line.y1);
		var _loc10:Object = VisGrid.gridPosVis(line.x2, line.y2);
		var _loc13:Int = line.dx > 0 ? (_loc10.x) : (_loc1.x);
		var _loc11:Int = line.dx > 0 ? (_loc1.x) : (_loc10.x);
		var _loc7:Int = line.dy > 0 ? (_loc10.y) : (_loc1.y);
		var _loc12:Int = line.dy > 0 ? (_loc1.y) : (_loc10.y);
		if (line.dx == 0 && line.dy == 0 || _loc1.x == _loc10.x && _loc1.y == _loc10.y)
		{
			register(line, _loc1.x, _loc1.y);
			return;
		}
		else
		{
			register(line, _loc1.x, _loc1.y);
		}
		var _loc4:Float = line.x1;
		var _loc3:Float = line.y1;
		var _loc8:Float = 1 / line.dx;
		var _loc9:Float = 1 / line.dy;
		var difX;
		while (true)
		{
			var _loc5;
			if (_loc1.x < 0)
			{
				difX = line.dx > 0 ? (VisGrid.gridSize + _loc1.gx) : (-VisGrid.gridSize - _loc1.gx);
			}
			else
			{
				difX = line.dx > 0 ? (VisGrid.gridSize - _loc1.gx) : (-(_loc1.gx + 1));
			}
			if (_loc1.y < 0)
			{
				_loc5 = line.dy > 0 ? (VisGrid.gridSize + _loc1.gy) : (-VisGrid.gridSize - _loc1.gy);
			}
			else
			{
				_loc5 = line.dy > 0 ? (VisGrid.gridSize - _loc1.gy) : (-(_loc1.gy + 1));
			}
			if (line.dx == 0)
			{
				_loc3 = _loc3 + _loc5;
			}
			else if (line.dy == 0)
			{
				_loc4 = _loc4 + difX;
			}
			else
			{
				var _loc6 = _loc3 + line.dy * difX * _loc8;
				if (Math.abs(_loc6 - _loc3) < Math.abs(_loc5))
				{
					_loc4 = _loc4 + difX;
					_loc3 = _loc6;
				}
				else if (Math.abs(_loc6 - _loc3) == Math.abs(_loc5))
				{
					_loc4 = _loc4 + difX;
					_loc3 = _loc3 + _loc5;
				}
				else
				{
					_loc4 = _loc4 + line.dx * _loc5 * _loc9;
					_loc3 = _loc3 + _loc5;
				} // end else if
			} // end else if
			_loc1 = VisGrid.gridPosVis(_loc4, _loc3);
			if (_loc1.x >= _loc11 && _loc1.x <= _loc13 && _loc1.y >= _loc12 && _loc1.y <= _loc7)
			{
				register(line, _loc1.x, _loc1.y);
				continue;
			} // end if
			return;
		}
	}
	public function register(line:LineBase, _x:Int, _y:Int) //This is where the line gets indexed in a 2D array
	{
		var _loc4 = new Object();
		if (VisGrid.grid[_x] == null)
		{
			VisGrid.grid[_x] = new Map();
		}
		if (VisGrid.grid[_x][_y] == null)
		{
			_loc4.storage = new Array<LineBase>();
			VisGrid.grid[_x][_y] = _loc4;
		}
		var a = new Array<Int>();
		a = [_x, _y];
		line.inject_grid_vis_loc(a);
		VisGrid.grid[_x][_y].storage.push(line);
	}
	public static function gridPosVis(x:Float, y:Float):Object
	{
		var posObject:Object = new Object();
		posObject.x = Math.floor(x / VisGrid.gridSize);
		posObject.y = Math.floor(y / VisGrid.gridSize);
		return(posObject);
	}
	var last_x_pos:Float = -5000; //these numbers are on purpose so when the track resumes, it's absolutely impossible (in theory) to have the starting grid be invisible
	var last_y_pos:Float = -5000;
	public function frustrumCulling(_x:Float, _y:Float, _override:Bool = false) 
	{
		var _visPos = VisGrid.gridPosVis(_x, _y);
		if (_visPos.x == this.last_x_pos && _visPos.y == this.last_y_pos && _override == false) {
			return;
		} else {
			this.last_x_pos = _visPos.x;
			this.last_y_pos = _visPos.y;
			VisGrid.tempVisualIndex = new Array();
			for (_loc4 in -1...1)
			{
				var _loc1 = (_visPos.x + _loc4);
				if (VisGrid.grid[_loc1] == null)
				{
					continue;
				}
				for (_loc3 in -1...1)
				{
					var _loc2 = (_visPos.y + _loc3);
					if (VisGrid.grid[_loc1][_loc2] == null)
					{
						continue;
					}
					var tempList:Array<LineBase> = VisGrid.grid[_loc1][_loc2].storage;
					for (a in tempList) {
						VisGrid.tempVisualIndex.push(a);
					}
				}
			}
			this.setTrackVisuals(VisGrid.tempVisualIndex);
		}
	}
	
	function setTrackVisuals(_list:Array<LineBase>) 
	{
		Common.gTrack.removeLinesFromStage(VisGrid.currentVisualIndex);
		VisGrid.currentVisualIndex = new Array();
		VisGrid.currentVisualIndex = _list;
		Common.gTrack.addLinesToStage(_list);
	}
}