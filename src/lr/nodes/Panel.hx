package lr.nodes;

import lr.lines.LineVis;
import openfl.display.Sprite;

import global.Common;
import global.CVar;
import global.SVar;
import lr.lines.LineBase;

/**
 * ...
 * @author Kaelan Evans
 */
class Panel
{
	public static var _width:Int = 140;
	public static var _height:Int = 140;
	
	public var primary:Array<LineBase>;
	public var lowFrame = -1;
	
	private var offset_x:Int = 0;
	private var offset_y:Int = 0;
	
	public var panelPosX:Int;
	public var panelPosY:Int;
	public var panelIDName:String;
	
	public var onStage:Bool = false;
	
	public var frame:Sprite;
	
	public function new(_x:Int, _y:Int) 
	{
		this.panelPosX = _x;
		this.panelPosY = _y;
		this.offset_y = _y * Panel._height;
		this.offset_x = _x * Panel._width;
		this.panelIDName = "x" + _x + "y" + _y;
		
		this.frame = new Sprite();
		
		this.frame.x = this.offset_x;
		this.frame.y = this.offset_y;
		
		#if (cpp)
			this.frame.cacheAsBitmap = true;
		#end
		
		this.primary = new Array();
	}
	public function addToStage() {
		Common.gTrack.canvas.addChild(this.frame);
		this.onStage = true;
	}
	public function inject_line(_line:LineBase) {
		
		var _locVis:LineVis = new LineVis(_line.type, _line.x1, _line.y1, _line.x2, _line.y2, _line.inv, _line.invDst, _line.nx, _line.ny, _line.dx, _line.dy, _line.grind);
		_line.visList[this.panelIDName] = _locVis;
		
		this.frame.addChild(_line.visList[this.panelIDName]);
		
		_locVis.x = _locVis.x - this.offset_x;
		_locVis.y = _locVis.y - this.offset_y;
		
		if (!SVar.sim_running) {
			if (!CVar.preview_mode) {
				Common.gGrid.lines[_line.ID].render("edit");
			} else {
				Common.gGrid.lines[_line.ID].render("play");
			}
		} else {
			if (!CVar.color_play) {
				Common.gGrid.lines[_line.ID].render("play");
			} else {
				Common.gGrid.lines[_line.ID].render("edit");
			}
		}
	}
	public function remove_line(_line:LineBase) {
		#if (cpp)
			this.frame.cacheAsBitmap = false;
		#end
		try {
			this.frame.removeChild(_line.visList[this.panelIDName]);
			this.primary.remove(_line);
		} catch (e:String) {
			
		}
	}
}