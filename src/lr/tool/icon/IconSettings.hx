package lr.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import lr.tool.Toolbar;
import lr.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class IconSettings extends IconBase
{

	public function new() 
	{
		super(Icon.settings);
	}
	override public function up(e:MouseEvent) {
		Common.gCode.toggleSettings_box();
	}
	
}