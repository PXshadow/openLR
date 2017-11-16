package lr.tool.icon;

import openfl.utils.AssetLibrary;

#if (!flash)
	import openfl.display.Sprite;
	import openfl.events.MouseEvent;
#else
	import flash.display.Sprite;
	import flash.events.MouseEvent;
#end

import lr.tool.IconBase;
import lr.tool.Toolbar;
import lr.tool.ToolBase;

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
		Toolbar.tool.set_tool(ToolType.Pencil);
	}
}