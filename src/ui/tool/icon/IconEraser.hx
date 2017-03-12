package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;
import ui.tool.lr.ToolEraser;

import global.Common;
import lr.Toolbar;

/**
 * ...
 * @author ...
 */
class IconEraser extends IconBase
{

	public function new() 
	{
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/eraser.png"));
		this.addChild(this.icon);
	}
	override public function down(e:MouseEvent) {
		Common.gToolBase.disable();
		Toolbar.tool = new ToolEraser();
	}
}