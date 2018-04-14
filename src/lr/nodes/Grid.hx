package lr.nodes;

import openfl.utils.Object;

import global.Common;
import global.CVar;
import global.SVar;
import lr.lines.LineBase;

@:enum abstract Action(Int) from Int to Int {
	public var undo_line:Int = 0;
	public var undo_action:Int = 1;
	public var redo_line:Int = 2;
	public var redo_action:Int = 3;
}

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
class Grid
{
	public var lines:Array<LineBase>;
	public var redo_lines:Array<LineBase>;
	
	public static var grid:Map<Int, Map<Int, Storage>>;
	public static var tile:Map<Int, Map<Int, Panel>>;
	public static var panelList:Array<SubPanel>;
	public static var lowFrame:Int = -1;
	
	public function new()
	{
		this.lines = new Array();
		this.redo_lines = new Array();
		Common.gGrid = this;
		Grid.grid = new Map();
		Grid.tile = new Map();
		Grid.panelList = new Array();
	}
	public function add_remove_action(_type:Int) {
		switch (_type) {
			case Action.undo_line :
				while (true) {
					if (this.lines.length == 0) return;
					var _loc1 = this.lines.pop();
					if (_loc1 == null) {
						continue;
					} else {
						this.remove_line(_loc1);
						break;
					}
				}
			case Action.redo_line :
				this.cacheLine(this.redo_lines.pop());
			case Action.undo_action :
			case Action.redo_action :
		}
	}
	public function new_grid()
	{
		this.lines = new Array();
		this.redo_lines = new Array();
		SVar.lineCount = 0;
		SVar.lineCount_blue = 0;
		SVar.lineCount_red = 0;
		SVar.lineCount_green = 0;
		SVar.lineID = 0;
		Common.gTextInfo.update();
		Grid.grid = new Map();
	}
	public function updateRegistry(_line:LineBase) {
		this.remove_line(_line);
		this.cacheLine(_line);
	}
	public function cacheLine(_line:LineBase) {
		if (_line == null) return;
		if (_line.type == LineType.Floor)
		{
			SVar.lineCount_blue += 1;
		}
		else if (_line.type == LineType.Accel)
		{
			SVar.lineCount_red += 1;
		}
		else if (_line.type == LineType.Scene)
		{
			SVar.lineCount_green += 1;
		}
		if (_line.ID == -1) {
			_line.ID = SVar.lineID;
			SVar.lineID += 1;
		} else {
			if (_line.ID > SVar.lineID) SVar.lineID = _line.ID + 1;
		}
		SVar.lineCount += 1;
		this.lines[_line.ID] = _line;
		this.registerInCollisionGrid(_line);
		this.registerInTileGrid(_line);
		Common.gTextInfo.update();
	}
	private function registerInCollisionGrid(line:LineBase) //This function is where the "boundaries" are produced
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
				difX = line.dx > 0 ? (SVar.node_gridsize + _loc1.gx) : (-SVar.node_gridsize - _loc1.gx);
			}
			else
			{
				difX = line.dx > 0 ? (SVar.node_gridsize - _loc1.gx) : (-(_loc1.gx + 1));
			}
			if (_loc1.y < 0)
			{
				_loc5 = line.dy > 0 ? (SVar.node_gridsize + _loc1.gy) : (-SVar.node_gridsize - _loc1.gy);
			}
			else
			{
				_loc5 = line.dy > 0 ? (SVar.node_gridsize - _loc1.gy) : (-(_loc1.gy + 1));
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
			if (Grid.lowFrame != -1) {
				Common.gRiderManager.update_riders(Grid.lowFrame);
				Grid.lowFrame = -1;
			}
			return;
		}
	}
	private function register(line:LineBase, _x:Int, _y:Int) 
	{
		if (grid[_x] == null)
		{
			grid[_x] = new Map();
		}
		if (grid[_x][_y] == null)
		{

			grid[_x][_y] = new Storage();
		}
		var a = new Array<Int>();
		a = [_x, _y];
		line.inject_grid_loc(a);
		if (grid[_x][_y].lowFrame != -1) {
			if (Grid.lowFrame == -1) {
				Grid.lowFrame = grid[_x][_y].lowFrame;
			} else if (grid[_x][_y].lowFrame < Grid.lowFrame ) {
				Grid.lowFrame = grid[_x][_y].lowFrame;
			}
		}
		grid[_x][_y].inject_line(line);
	}
	private function registerInTileGrid(line:LineBase) //This function is where the "boundaries" are produced
	{
		var _loc1:Object = Common.tilePos(line.x1, line.y1);
		var _loc10:Object = Common.tilePos(line.x2, line.y2);
		var _loc13:Int = line.dx > 0 ? (_loc10.x) : (_loc1.x);
		var _loc11:Int = line.dx > 0 ? (_loc1.x) : (_loc10.x);
		var _loc7:Int = line.dy > 0 ? (_loc10.y) : (_loc1.y);
		var _loc12:Int = line.dy > 0 ? (_loc1.y) : (_loc10.y);
		if (line.dx == 0 && line.dy == 0 || _loc1.x == _loc10.x && _loc1.y == _loc10.y)
		{
			this.register_visual(line, _loc1.x, _loc1.y);
			return;
		}
		else
		{
			this.register_visual(line, _loc1.x, _loc1.y);
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
				difX = line.dx > 0 ? (SVar.node_tilesize + _loc1.gx) : (-SVar.node_tilesize - _loc1.gx);
			}
			else
			{
				difX = line.dx > 0 ? (SVar.node_tilesize - _loc1.gx) : (-(_loc1.gx + 1));
			}
			if (_loc1.y < 0)
			{
				_loc5 = line.dy > 0 ? (SVar.node_tilesize + _loc1.gy) : (-SVar.node_tilesize - _loc1.gy);
			}
			else
			{
				_loc5 = line.dy > 0 ? (SVar.node_tilesize - _loc1.gy) : (-(_loc1.gy + 1));
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
			_loc1 = Common.tilePos(_loc4, _loc3);
			if (_loc1.x >= _loc11 && _loc1.x <= _loc13 && _loc1.y >= _loc12 && _loc1.y <= _loc7)
			{
				this.register_visual(line, _loc1.x, _loc1.y);
				continue;
			} // end if
			return;
		}
	}
	private function register_visual(line:LineBase, _x:Int, _y:Int) //This is where the line gets indexed in a 2D array
	{
		if (tile[_x] == null)
		{
			tile[_x] = new Map();
		}
		if (tile[_x][_y] == null)
		{
			tile[_x][_y] = new Panel(_x, _y);
			if (_x >= Common.gTrack.tile_tl.x - 1 || _x <= Common.gTrack.tile_br.y + 1) {
				if (_y >= Common.gTrack.tile_tl.y - 1 || _y <= Common.gTrack.tile_br.y + 1) {
					Common.gTrack.renderList.push(tile[_x][_y]);
					tile[_x][_y].addToStage();
				}
			}
		}
		var a = new Array<Int>();
		a = [_x, _y];
		line.inject_grid_vis_loc(a);
		tile[_x][_y].inject_line(line);
	}
	public function remove_line(line:LineBase)
	{
		if (line == null) {
			return;
		}
		this.remove_from_grid(line);
		this.lines[line.ID] = null;
		if (line.type == 0)
		{
			--SVar.lineCount_blue;
		}
		else if (line.type == 1)
		{
			--SVar.lineCount_red;
		}
		else if (line.type == 2)
		{
			--SVar.lineCount_green;
		}
		--SVar.lineCount;
		Common.gTextInfo.update();
		Common.gSimManager.rider_update();
		this.redo_lines.push(line);
	}
	function remove_from_grid(line:LineBase)
	{
		for (i in 0...line.gridList.length)
		{
			Grid.grid[line.gridList[i][0]][line.gridList[i][1]].remove_line(line);
		}
		for (j in 0...line.gridVisList.length) {
			Grid.tile[line.gridVisList[j][0]][line.gridVisList[j][1]].remove_line(line);
		}
	}
	public function snap(x:Float, y:Float, vert:Int, invert:Bool):Array<Dynamic> //if mouse is close enough to line end when mouse down, line will snap to line
	{
		var _loc2:Float = Math.pow(SVar.snap_distance / Common.gTrack.scaleX, 2);
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
				for (_loc16 in 0...grid[_loc4][_loc3].secondary.length)
				{
					if (grid[_loc4][_loc3].secondary[_loc16] == null) {continue;}
					var _loc1:LineBase = grid[_loc4][_loc3].secondary[_loc16];
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
		if (!CVar.line_snap)
		{
			_loc9 = false;
		}
		var _locArray:Array<Dynamic> = new Array();
		_locArray = [_loc10, _loc11, _loc9];
		return (_locArray);
	} // End of the function
	public function updateRender(_con:String) {
		switch (_con) {
			case ("Play") :
				for (a in Grid.panelList) {
					a.set_rendermode_playback();
				}
			case ("Edit") :
				for (a in Grid.panelList) {
					a.set_rendermode_edit();
				}
		}
	}
}