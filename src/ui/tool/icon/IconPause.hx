package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import ui.tool.Toolbar;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPause extends IconBase
{
	var paused:Bool = false;
	public function new() 
	{
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/pause.png"));
		this.addChild(this.icon);
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