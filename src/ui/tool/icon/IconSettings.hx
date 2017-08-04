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
		super("swf/ui/IconSettings.bundle");
	}
	override public function down(e:MouseEvent) {
		Common.gCode.toggleSettings_box();
	}
	
}