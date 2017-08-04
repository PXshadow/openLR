package ui.tool.icon;

import openfl.display.Sprite;
import openfl.utils.AssetLibrary;
import openfl.events.MouseEvent;
import ui.tool.IconBase;

import global.Common;
import ui.tool.Toolbar;
import ui.tool.lr.ToolPencil;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPencil extends IconBase
{
	public function new() 
	{
		super(Icon.pencil);
	}
	override public function down(e:MouseEvent) {
		Common.gToolBase.disable();
		Toolbar.icon.deselect();
		Toolbar.icon = this;
		this.select();
		Toolbar.tool = new ToolPencil();
		Toolbar.swatch.select();
	}
}