package lr.tool.icon;

import openfl.events.MouseEvent;

import lr.tool.IconBase;
import lr.tool.Toolbar;
import lr.tool.ToolBase;


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
		Toolbar.tool.set_tool(ToolType.Line);
	}
}