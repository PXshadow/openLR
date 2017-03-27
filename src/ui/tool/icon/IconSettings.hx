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
class IconSettings extends IconBase
{

	public function new() 
	{
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/settings.png"));
		this.addChild(this.icon);
	}
	override public function down(e:MouseEvent) {
		Common.gCode.toggleSettings_box();
	}
	
}