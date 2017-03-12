package lr.line;

import global.Common;
import openfl.utils.Object;

/**
 * ...
 * @author Kaelan Evans
 * 
 * This class is the more nitty gritty of line handling. Primarily this class helps break down drawn lines into aproximate groups and helps reduce the size of the loop needed for checking
 * physics collision. This class is also needed to allow the eraser tool to work.
 * 
 * Also truth be told I barely understand how this class works. Only recently I learned that it indexes these lines into the negatives, so Map has to be used instead of Array.
 */
class Grid
{
	public var lines:Array<Dynamic>;
	public static var grid:Map<Int, Map<Int, Object>>;
	public function new() 
	{
		this.lines = new Array();
		Common.gGrid = this;
		Grid.grid = new Map();
	}
	public function massLineIndex(line:Dynamic)
	{
		this.lines.push(line);
		if (line.type == 0) {
			Common.sBLueLineCount += 1;
		} else if (line.type == 1) {
			Common.sRedLineCount += 1;
		} else if (line.type == 2) {
			Common.sGreenLineCount += 1;
		}
		line.ID = Common.sLineID;
		Common.sLineCount += 1;
		Common.sLineID += 1;
		Common.gTextInfo.update();
		this.registerInGrid(line);
	}
	public function new_grid()
	{
		this.lines = new Array();
		Common.sLineCount = 0;
		Common.sLineID = 0;
		Common.gTextInfo.update();
		Grid.grid = new Map();
	}
	public function registerInGrid(line:Dynamic) //This function is where the "boundaries" are produced
	{
		var _loc1:Object = Common.gridPos(line.a.x, line.a.y);
		var _loc10:Object = Common.gridPos(line.b.x, line.b.y);
		var _loc13:Int = line.d.x > 0 ? (_loc10.x) : (_loc1.x);
		var _loc11:Int = line.d.x > 0 ? (_loc1.x) : (_loc10.x);
		var _loc7:Int = line.d.y > 0 ? (_loc10.y) : (_loc1.y);
		var _loc12:Int = line.d.y > 0 ? (_loc1.y) : (_loc10.y);
		if (line.d.x == 0 && line.d.y == 0 || _loc1.x == _loc10.x && _loc1.y == _loc10.y)
		{
			register(line, _loc1.x, _loc1.y);
			return;
		} else {
			register(line, _loc1.x, _loc1.y);
		}
		var _loc4 = line.a.x;
		var _loc3 = line.a.y;
		var _loc8 = 1 / line.d.x;
		var _loc9 = 1 / line.d.y;
		while (true)
		{
			var _loc5:Dynamic;
			var difX:Dynamic;
			if (_loc1.x < 0)
			{
				difX = line.d.x > 0 ? (Common.svar_gridsize + _loc1.gx) : (-Common.svar_gridsize - _loc1.gx);
			}
			else
			{
				difX = line.d.x > 0 ? (Common.svar_gridsize - _loc1.gx) : (-(_loc1.gx + 1));
			} // end else if
			if (_loc1.y < 0)
			{
				_loc5 = line.d.y > 0 ? (Common.svar_gridsize + _loc1.gy) : (-Common.svar_gridsize - _loc1.gy);
			}
			else
			{
				_loc5 = line.d.y > 0 ? (Common.svar_gridsize - _loc1.gy) : (-(_loc1.gy + 1));
			} // end else if
			if (line.d.x == 0)
			{
				_loc3 = _loc3 + _loc5;
			}
			else if (line.d.y == 0)
			{
				_loc4 = _loc4 + difX;
			}
			else
			{
				var _loc6 = _loc3 + line.d.y * difX * _loc8;
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
					_loc4 = _loc4 + line.d.x * _loc5 * _loc9;
					_loc3 = _loc3 + _loc5;
				} //end else if
			} // end else if
			_loc1 = Common.gridPos(_loc4, _loc3);
			if (_loc1.x >= _loc11 && _loc1.x <= _loc13 && _loc1.y >= _loc12 && _loc1.y <= _loc7)
			{
				register(line, _loc1.x, _loc1.y);
				continue;
			} // end if
        return;
		}
	}
	public function register(line:Dynamic, _x:Int, _y:Int) //This is where the line gets indexed in a 2D array
	{
		if (grid[_x] == null)
		{
			grid[_x] = new Map();
		}
		if (grid[_x][_y] == null)
		{
			var _loc4 = new Object();
			_loc4.storage = new Array<Dynamic>();
			_loc4.storage2 = new Array<Dynamic>();
			grid[_x][_y] = _loc4;
		}
		if (line.type != 2)
		{
			grid[_x][_y].storage2[line.ID] = line;
		}
		grid[_x][_y].storage[line.ID] = line;
	}
}