package ui.tool.icon;

import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.display.Bitmap;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Base functions and variables for icons. Default behavior disables mosue tools on rollover and reenables on roll out.
 * 
 */
class IconBase extends MovieClip
{
	var icon:Bitmap;
	public function new() 
	{
		super();
		//functional hit zone
		this.graphics.clear();
		this.graphics.lineStyle(2, 0x000000, 0);
		this.graphics.beginFill(0xFFFFFF, 0);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.addEventListener(MouseEvent.MOUSE_DOWN, down);
		this.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, alt);
		this.addEventListener(MouseEvent.DOUBLE_CLICK, double_click);
	}
	
	private function double_click(e:MouseEvent):Void 
	{
		trace ("Double click action not yet set");
	}
	
	public function alt(e:MouseEvent):Void 
	{
		trace("Alt behavior not yet set or not yet overidden");
	}
	
	public function down(e:MouseEvent):Void 
	{
		trace ("action not yet overidden");
	}
	
	private function enable_tool(e:MouseEvent):Void 
	{
		if (!Common.svar_sim_running || Common.gSimManager.paused) {
			Common.gToolBase.enable();
			this.alpha = 1;
		}
	}
	
	private function disable_tool(e:MouseEvent):Void 
	{
		if (!Common.svar_sim_running) {
			Common.gToolBase.disable();
			this.alpha = 0.75;
		}
	}
	
	public function enable() {
		this.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.alpha = 1;
	}
	
	public function disable() {
		this.removeEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.removeEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.alpha = 0.25;
	}
	public function select() {
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
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