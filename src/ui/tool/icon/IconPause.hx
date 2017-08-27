package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import ui.tool.Toolbar;
import ui.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPause extends IconBase
{
	var paused:Bool = false;
	public function new() 
	{
		super(Icon.pause);
	}
	override public function up(e:MouseEvent) {
		if (Common.gSimManager.paused) {
			Common.gSimManager.resume_sim();
			//Common.gToolbar.set_play_mode();
			Common.gToolBase.destroy();
		} else if (!Common.gSimManager.paused) {
			Common.gSimManager.pause_sim();
			Common.gToolBase.destroy();
			//Common.gToolbar.set_live_draw_mode();
			Toolbar.icon.select();
		}
	}
	
}