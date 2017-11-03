package lr.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;
import lr.tool.IconBase;
import lr.tool.editing.ToolEraser;

import global.Common;
import lr.tool.Toolbar;

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
		Common.gToolBase.disable();
		Toolbar.icon.deselect();
		Toolbar.icon = this;
		this.select();
		Toolbar.tool = new ToolEraser();
		Toolbar.swatch.deselect();
		Common.line_type = -1;
	}
}