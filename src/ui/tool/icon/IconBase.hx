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
	var debug_alpha = 0;
	var icon:Bitmap;
	public function new() 
	{
		super();
		
		if (Common.cvar_icon_hit_display) //enable to see boundaries
		{
			this.debug_alpha = 1;
		}
		
		//functional hit zone
		this.graphics.clear();
		this.graphics.lineStyle(2, 0x000000, debug_alpha);
		this.graphics.beginFill(0xFFFFFF, debug_alpha);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.addEventListener(MouseEvent.MOUSE_DOWN, down);
		this.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, alt);
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
		Common.gToolBase.enable();
		this.alpha = 1;
	}
	
	private function disable_tool(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		this.alpha = 0.75;
	}
	
	public function enable() {
		this.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
	}
}