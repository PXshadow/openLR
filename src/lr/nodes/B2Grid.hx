package lr.nodes;

import lr.lines.LineBase;
import openfl.utils.Object;
import openfl.events.KeyboardEvent;

import global.Common;
import global.KeyBindings;

/**
 * ...
 * @author Kaelan Evans
 *
 * This class is the more nitty gritty of line handling. Primarily this class helps break down drawn lines into aproximate groups and helps reduce the size of the loop needed for checking
 * physics collision. This class is also needed to allow the eraser tool to work.
 * 
 * This class also handles undo and redo of lines. Few lines of code are called from outside the class, such as ToolEraser calling an add to history when mouse is released.
 *
 * 
 */
class B2Grid
{
	public var lines:Array<LineBase>;
	public static var grid:Map<Int, Map<Int, Object>>;
	public static var undo_single:Array<LineBase>;
	public static var redo_single:Array<LineBase>;
	public static var history:Array<Array<Dynamic>>;
	public static var history_index:Int = -1;
	public function new()
	{
		this.lines = new Array();
		Common.gGrid = this;
		B2Grid.grid = new Map();
		B2Grid.undo_single = new Array();
		B2Grid.redo_single = new Array();
		B2Grid.history = new Array();
		Common.gStage.addEventListener(KeyboardEvent.KEY_UP, undo_redo);
	}

	private function undo_redo(e:KeyboardEvent):Void
	{
		if (!Common.svar_sim_running) {
			if (e.controlKey)
			{
				if (e.keyCode == KeyBindings.undo_stroke) {
					this.undo_action();
				} else if (e.keyCode == KeyBindings.redo_stroke) {
					this.redo_action();
				}
			}
			if (e.keyCode == KeyBindings.undo_line)
			{
				if (e.shiftKey)
				{
					this.redo_line();
				}
				else if (!e.shiftKey)
				{
					this.undo_line();
				}
			}
		}
	}
	public function add_to_history(_act:String, _list:Array<LineBase>) {
		if (B2Grid.history.length == 0) {
			B2Grid.history.push([_act, _list]);
		} else if (B2Grid.history_index + 1 == B2Grid.history.length) {
			B2Grid.history.push([_act, _list]);
		} else if (B2Grid.history_index == -1 && B2Grid.history.length > 0) {
			B2Grid.history.insert(0, [_act, _list]);
		} else {
			B2Grid.history.insert(B2Grid.history_index, [_act, _list]);
		}
		B2Grid.history_index += 1;
	}
	function undo_action() {
		if (B2Grid.history_index > -1) {
			if (B2Grid.history[B2Grid.history_index][0] == "add") {
				this.remove_stroke(B2Grid.history[B2Grid.history_index][1]);
			} else if (B2Grid.history[B2Grid.history_index][0] == "sub") {
				this.redo_stroke(B2Grid.history[B2Grid.history_index][1]);
			}
			B2Grid.history_index -= 1;
		}
	}
	function redo_action() {
		if (B2Grid.history_index < B2Grid.history.length - 1) {
			B2Grid.history_index += 1;
			if (B2Grid.history[B2Grid.history_index][0] == "add") {
				this.redo_stroke(B2Grid.history[B2Grid.history_index][1]);
			} else if (B2Grid.history[B2Grid.history_index][0] == "sub") {
				this.remove_stroke(B2Grid.history[B2Grid.history_index][1]);
			}
		}
	}
	function redo_stroke(_list:Array<LineBase>) 
	{
		for (i in 0..._list.length) {
			Common.gTrack.add_vis_line(_list[i]);
		}
	}
	function remove_stroke(_list:Array<LineBase>) 
	{
		for (i in 0..._list.length) {
			this.remove_line(_list[i], 0, 0);
		}
	}
	
	function redo_line() 
	{
		if (B2Grid.redo_single.length > 0) {
			var _loc1:LineBase = B2Grid.redo_single.pop();
			Common.gTrack.add_vis_line(_loc1);
			this.cache_stroke([_loc1]);
			Common.gGrid.add_to_history("add", [_loc1]);
		}
	}
	function undo_line()
	{
		if (lines.length > 0) {
			Common.gGrid.add_to_history("sub", [B2Grid.undo_single[B2Grid.undo_single.length - 1]]);
			this.remove_line(B2Grid.undo_single[B2Grid.undo_single.length - 1], 0, 0);
		}
	}
	public function cache_stroke(_list:Array<LineBase>)
	{
		try {
			if (_list.length > 0) {
				for (i in 0..._list.length) {
					B2Grid.undo_single.push(_list[i]);
				}
				this.add_to_history("add", _list);
			}
		} catch (e:String) {
			trace ("failed line cache");
		}
	}
	public function massLineIndex(line:LineBase)
	{
		this.lines[line.ID] = line;
		if (line.type == 0)
		{
			Common.sBLueLineCount += 1;
		}
		else if (line.type == 1)
		{
			Common.sRedLineCount += 1;
		}
		else if (line.type == 2)
		{
			Common.sGreenLineCount += 1;
		}
		Common.sLineCount += 1;
		Common.gTextInfo.update();
		this.registerInGrid(line);
	}
	public function new_grid()
	{
		this.lines = new Array();
		Common.sLineCount = 0;
		Common.sBLueLineCount = 0;
		Common.sRedLineCount = 0;
		Common.sGreenLineCount = 0;
		Common.sLineID = 0;
		Common.gTextInfo.update();
		B2Grid.grid = new Map();
	}
	public function registerInGrid(line:LineBase) //This function is where the "boundaries" are produced
	{
		var _loc1:Object = Common.gridPos(line.x1, line.y1);
		var _loc10:Object = Common.gridPos(line.x2, line.y2);
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
				difX = line.dx > 0 ? (Common.svar_gridsize + _loc1.gx) : (-Common.svar_gridsize - _loc1.gx);
			}
			else
			{
				difX = line.dx > 0 ? (Common.svar_gridsize - _loc1.gx) : (-(_loc1.gx + 1));
			}
			if (_loc1.y < 0)
			{
				_loc5 = line.dy > 0 ? (Common.svar_gridsize + _loc1.gy) : (-Common.svar_gridsize - _loc1.gy);
			}
			else
			{
				_loc5 = line.dy > 0 ? (Common.svar_gridsize - _loc1.gy) : (-(_loc1.gy + 1));
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
			_loc1 = Common.gridPos(_loc4, _loc3);
			if (_loc1.x >= _loc11 && _loc1.x <= _loc13 && _loc1.y >= _loc12 && _loc1.y <= _loc7)
			{
				register(line, _loc1.x, _loc1.y);
				continue;
			} // end if
			if (GridBase.lowFrame != -1) {
				Common.gRiderManager.update_riders(GridBase.lowFrame);
				GridBase.lowFrame = -1;
			}
			return;
		}
	}
	public function register(line:LineBase, _x:Int, _y:Int) //This is where the line gets indexed in a 2D array
	{
		var _loc4 = new Object();
		if (grid[_x] == null)
		{
			grid[_x] = new Map();
		}
		if (grid[_x][_y] == null)
		{
			_loc4.storage = new Array<LineBase>();
			_loc4.storage2 = new Array<LineBase>();
			_loc4.lowFrame = -1;
			grid[_x][_y] = _loc4;
		}
		var a = new Array<Int>();
		a = [_x, _y];
		line.inject_grid_loc(a);
		if (line.type != 2)
		{
			grid[_x][_y].storage2.push(line);
		}
		if (_loc4.lowFrame != -1) {
			if (GridBase.lowFrame == -1) {
				GridBase.lowFrame = _loc4.lowFrame;
			} else if (_loc4.lowFrame < GridBase.lowFrame ) {
				GridBase.lowFrame = _loc4.lowFrame;
			}
		}
		grid[_x][_y].storage.push(line);
	}
	public function remove_line(line:LineBase, _x:Int, _y:Int)
	{
		if (this.lines[line.ID] == null) {
			return;
		}
		this.remove_from_grid(line);
		Common.gTrack.remove_line(line);
		B2Grid.undo_single.remove(line);
		B2Grid.redo_single.push(line);
		this.lines[line.ID] = null;
		if (line.type == 0)
		{
			--Common.sBLueLineCount;
		}
		else if (line.type == 1)
		{
			--Common.sRedLineCount;
		}
		else if (line.type == 2)
		{
			--Common.sGreenLineCount;
		}
		--Common.sLineCount;

		Common.gTextInfo.update();
		Common.gSimManager.rider_update();
	}
	function remove_from_grid(line:LineBase)
	{
		for (i in 0...line.gridList.length)
		{
			B2Grid.grid[line.gridList[i][0]][line.gridList[i][1]].storage.remove(line);
			B2Grid.grid[line.gridList[i][0]][line.gridList[i][1]].storage2.remove(line);
			if (B2Grid.grid[line.gridList[i][0]][line.gridList[i][1]].storage.length == 0) {
				B2Grid.grid[line.gridList[i][0]][line.gridList[i][1]].lowFrame = -1;
			}
		}
	}
	public function snap(x:Float, y:Float, vert:Int, invert:Bool):Array<Dynamic> //if mouse is close enough to line end when mouse down, line will snap to line
	{
		var _loc2:Float = Math.pow(Common.svar_snap_distance / Common.gTrack.scaleX, 2);
		var _loc10:Float = x;
		var _loc11:Float = y;
		var _loc17:Bool;
		var _loc18:Bool;
		var _loc6:Float;
		var _loc7:Float;
		var _loc9:Dynamic = null;
		var _loc15 = Common.gridPos(x, y);
		var _loc8:LineBase = null;
		for (_loc14 in -1...2)
		{
			var _loc4 = (_loc15.x + _loc14);
			if (grid[_loc4] == null)
			{
				continue;
			} // end if
			for (_loc5 in -1...2)
			{
				var _loc3 = (_loc15.y + _loc5);
				if (grid[_loc4][_loc3] == null)
				{
					continue;
				} // end if
				for (_loc16 in 0...grid[_loc4][_loc3].storage2.length)
				{
					if (grid[_loc4][_loc3].storage2[_loc16] == null) {continue;}
					var _loc1:LineBase = grid[_loc4][_loc3].storage2[_loc16];
					_loc6 = Math.pow(x - _loc1.x1, 2) + Math.pow(y - _loc1.y1, 2);
					_loc7 = Math.pow(x - _loc1.x2, 2) + Math.pow(y - _loc1.y2, 2);
					if (_loc6 < _loc2)
					{
						_loc2 = _loc6;
						_loc10 = _loc1.x1;
						_loc11 = _loc1.y1;
						_loc9 = 1;
						_loc8 = _loc1;
					} // end if
					if (_loc7 < _loc2)
					{
						_loc2 = _loc7;
						_loc10 = _loc1.x2;
						_loc11 = _loc1.y2;
						_loc9 = 2;
						_loc8 = _loc1;
					} //end if
				} // end of for...in
			} // end of for
		} // end of for
		if (_loc9 != null && _loc8 != null)
		{
			_loc17 = vert == _loc9;
			_loc18 = invert == _loc8.inv;
		}
		else {
			_loc17 = true;
			_loc18 = false;
		}
		if (!(_loc17 && !_loc18 || !_loc17 && _loc18))
		{
			_loc9 = false;
			_loc10 = x;
			_loc11 = y;
		}
		else {
			_loc9 = true;
		}
		if (!Common.cvar_line_snap)
		{
			_loc9 = false;
		}
		var _locArray:Array<Dynamic> = new Array();
		_locArray = [_loc10, _loc11, _loc9];
		return (_locArray);
	} // End of the function
}