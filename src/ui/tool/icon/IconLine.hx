package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;
import ui.tool.IconBase;
import ui.tool.lr.ToolLine;

import global.Common;
import ui.tool.Toolbar;


/**
 * ...
 * @author Kaelan Evans
 */
class IconLine extends IconBase
{

	public function new() 
	{
		super(Icon.line);
	}
	override public function up(e:MouseEvent) {
		Common.gToolBase.disable();
		Toolbar.icon.deselect();
		Toolbar.icon = this;
		this.select();
		Toolbar.tool = new ToolLine();
		Toolbar.swatch.select();
	}
}