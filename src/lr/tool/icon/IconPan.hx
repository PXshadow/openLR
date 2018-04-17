package lr.tool.icon;

import openfl.events.MouseEvent;

import lr.tool.IconBase;
import lr.tool.Toolbar;
import lr.tool.ToolBase;


/**
 * ...
 * @author Kaelan Evans
 */
class IconPan extends IconBase
{

	public function new() 
	{
		super(Icon.pan);
	}
	override public function up(e:MouseEvent) {
		Toolbar.tool.set_tool(ToolType.Pan);
	}
}