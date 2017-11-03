package lr.tool.icon;

import lr.tool.IconBase;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import lr.tool.Toolbar;
import lr.tool.editing.ToolPan;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPan extends IconBase
{

	public function new() 
	{
		super("swf/ui/IconPan.bundle");
	}
	override public function up(e:MouseEvent) {
		Common.gToolBase.disable();
		Toolbar.icon.deselect();
		Toolbar.icon = this;
		this.select();
		Toolbar.tool = new ToolPan();
		Toolbar.swatch.deselect();
	}
	override private function double_click(e:MouseEvent) {
		Common.gCode.return_to_origin();
	}
}