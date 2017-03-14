package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import lr.Toolbar;
import ui.tool.lr.ToolPan;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPan extends IconBase
{

	public function new() 
	{
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/pan.png"));
		this.addChild(this.icon);
	}
	override public function down(e:MouseEvent) {
		Common.gToolBase.disable();
		Toolbar.tool = new ToolPan();
	}
	override private function double_click(e:MouseEvent) {
		Common.gCode.return_to_origin();
	}
}