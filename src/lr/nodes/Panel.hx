package lr.nodes;

import global.Common;
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
	
	public var frame:SubPanel;
	
	public function new(_x:Int, _y:Int) 
	{
		this.panelPosX = _x;
		this.panelPosY = _y;
		this.offset_y = _y * Panel._height;
		this.offset_x = _x * Panel._width;
		this.panelIDName = "x" + _x + "y" + _y;
		
		this.frame = new SubPanel(this.offset_x, this.offset_y);
		
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
		this.primary.push(_line);
		this.frame.drawLines(this.primary);
	}
	public function remove_line(_line:LineBase) {
		#if (cpp)
			this.frame.cacheAsBitmap = false;
		#end
	}
}