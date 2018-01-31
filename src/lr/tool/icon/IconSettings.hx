package lr.tool.icon;

import openfl.events.MouseEvent;

import global.Common;
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