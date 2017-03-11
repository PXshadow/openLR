package lr.line;

import global.Common;
import openfl.utils.Object;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Grid Quadrat locations
 * 
 * 	  |
 *   0|1
 * ---+---
 *   3|2
 * 	  |
 * 
 * 
 * 	Flash supported the abillity to index arrays in the negatives (array[-1] = object), however Haxe does not (afaik). Until a solution is found, openLR
 * 	will use a 4 quadrant grid system
 * 
 */
class Grid
{
	public var lines:Array<Dynamic>;
	public var grid0:Array<Array<Object>>;
	public var grid1:Array<Array<Object>>;
	public var grid2:Array<Array<Object>>;
	public var grid3:Array<Array<Object>>;
	public function new() 
	{
		this.lines = new Array();
		Common.gGrid = this;
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
	}
	public function new_grid()
	{
		this.lines = new Array();
		Common.sLineCount = 0;
		Common.sLineID = 0;
	}
}