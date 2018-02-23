package lr.tool;

#if (!flash)
	import openfl.display.Sprite;
	import openfl.events.MouseEvent;
#else
	import flash.display.Sprite;
	import flash.events.MouseEvent;
#end

import global.Common;
import global.SVar;
import lr.tool.IconButton;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Base functions and variables for icons. Default behavior disables mosue tools on rollover and reenables on roll out.
 * 
 */
@:enum abstract Icon(String) from String to String {
	public var undefined:String = "undefined";
	public var pencil:String = "pencil";
	public var line:String = "line";
	public var eraser:String = "eraser";
	public var pan:String = "pan";
	public var play:String = "play";
	public var pause:String = "pause";
	public var stop:String = "stop";
	public var flag:String = "flag";
	public var file:String = "file";
	public var settings:String = "settings";
	public var swBlue:String = "blue";
	public var swRed:String = "red";
	public var swGreen:String = "green";
	public var no:String = "no";
	public var yes:String = "yes";
	public var generic:String = "generic";
}
class IconBase extends Sprite
{
	private var enabled:Bool = true;
	private var iconButton:IconButton;
	private var icon:Sprite;
	public function new(_path:String = Icon.undefined) 
	{
		super();
		
		this.iconButton = new IconButton(_path);
		this.addChild(this.iconButton);
		
		this.attach_listeners();
	}
	private function attach_listeners() {
		this.iconButton.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.iconButton.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.iconButton.addEventListener(MouseEvent.MOUSE_UP, up);
		this.iconButton.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, alt);
		this.iconButton.addEventListener(MouseEvent.DOUBLE_CLICK, double_click);
	}
	private function double_click(e:MouseEvent):Void 
	{
		trace ("Double click action not yet set");
	}
	
	public function alt(e:MouseEvent):Void 
	{
		trace("Alt behavior not yet set or not yet overidden");
	}
	
	public function up(e:MouseEvent):Void 
	{
		trace ("action not yet overidden");
	}
	
	private function enable_tool(e:MouseEvent):Void 
	{
		if (!SVar.sim_running || Common.gSimManager.paused) {
		Common.gToolBase.set_tool(ToolBase.lastTool);
		}
	}
	
	private function disable_tool(e:MouseEvent):Void 
	{
		if (!SVar.sim_running) {
			Common.gToolBase.set_tool("None");
		}
	}
	
	public function enable() {
		this.mouseChildren = true;
		this.alpha = 1;
		this.enabled = true;
	}
	
	public function disable() {
		this.mouseChildren = false;
		this.alpha = 0.25;
		this.enabled = false;
	}
	public function select() {
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
	}
	public function deselect() {
		this.graphics.clear();
	}
}