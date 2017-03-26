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
class IconStop extends IconBase
{

	public function new() 
	{
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/stop.png"));
		this.addChild(this.icon);
	}
	override public function down(e:MouseEvent) {
		Common.gTrack.set_rendermode_edit();
		Common.gToolbar.set_edit_mode();
		Common.gToolbar.pan.visible = true;
		Common.gToolbar.pause.visible = false;
		Common.gTrack.set_simmode_stop();
	}
	
}