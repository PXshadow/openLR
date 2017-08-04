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
	override public function down(e:MouseEvent) {
		if (Common.gSimManager.paused) {
			Common.gSimManager.resume_sim();
			Common.gToolbar.set_play_mode();
		} else if (!Common.gSimManager.paused) {
			Common.gSimManager.pause_sim();
			Common.gToolbar.set_edit_mode();
			Toolbar.icon.select();
		}
	}
	
}