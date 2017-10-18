package ui.tool.icon;

import openfl.utils.AssetLibrary;

#if (!flash)
	import openfl.display.Sprite;
	import openfl.events.MouseEvent;
#else
	import flash.display.Sprite;
	import flash.events.MouseEvent;
#end

import global.Common;
import ui.tool.IconBase;
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
	override public function up(e:MouseEvent) {
		Common.gToolBase.disable();
		Toolbar.icon.deselect();
		Toolbar.icon = this;
		this.select();
		Toolbar.tool = new ToolPencil();
		Toolbar.swatch.select();
	}
}