package lr.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;
import lr.tool.IconBase;
import lr.tool.editing.ToolLine;

import global.Common;
import lr.tool.Toolbar;


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