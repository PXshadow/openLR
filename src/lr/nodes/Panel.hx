package lr.nodes;

import openfl.display.Sprite;

import global.Common;
import lr.lines.LineBase;
import lr.nodes.Grid;

/**
 * ...
 * @author Kaelan Evans
 */
class Panel extends Sprite
{
	public static var _width:Int = 100;
	public static var _height:Int = 100;
	
	public var primary:Array<LineBase>;
	public var lowFrame = -1;
	
	private var offset_x:Int;
	private var offset_y:Int;
	
	public function new(_x:Int, _y:Int) 
	{
		super();
		
		this.offset_x = _x;
		this.offset_y = _y;
		
		this.primary = new Array();
		
		Common.gTrack.canvas.addChild(this);
		
		this.cacheAsBitmap = true;
	}
	public function inject_line(_line:LineBase) {
		var _loc1:LineBase = _line;
		this.addChild(_loc1);
		
		
		if (!Common.svar_sim_running) {
			if (!Common.cvar_preview_mode) {
				Common.gGrid.lines[_line.ID].render("edit");
			} else {
				Common.gGrid.lines[_line.ID].render("play");
			}
		} else {
			if (!Common.cvar_color_play) {
				Common.gGrid.lines[_line.ID].render("play");
			} else {
				Common.gGrid.lines[_line.ID].render("edit");
			}
		}
	}
	public function remove_line(_line:LineBase) {
		this.removeChild(_line);
		this.primary.remove(_line);
	}
}