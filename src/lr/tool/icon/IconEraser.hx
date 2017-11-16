package lr.tool.icon;

import openfl.events.MouseEvent;

import lr.tool.IconBase;
import lr.tool.Toolbar;
import lr.tool.ToolBase;

/**
 * ...
 * @author ...
 */
class IconEraser extends IconBase
{

	public function new() 
	{
		super(Icon.eraser);
	}
	override public function up(e:MouseEvent) {
		Toolbar.tool.set_tool(ToolType.Eraser);
	}
}