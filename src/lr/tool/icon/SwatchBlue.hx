package lr.tool.icon;

import openfl.events.MouseEvent;

import global.Common;
import lr.tool.IconBase;
import lr.tool.Toolbar;

/**
 * ...
 * @author ...
 */
class SwatchBlue  extends IconBase
{

	public function new() 
	{
		super(Icon.swBlue);
	}
	override public function up(e:MouseEvent) {
		Common.line_type = 0;
		Toolbar.swatch.deselect();
		Toolbar.swatch = this;
		this.select();
	}
	override public function select() 
	{
		Common.line_type = 0;
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 15);
		this.graphics.lineTo(0, 15);
		this.graphics.lineTo(0, 0);
	}
	override public function deselect() 
	{
		this.graphics.clear();
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 15);
		this.graphics.lineTo(0, 15);
		this.graphics.lineTo(0, 0);
	}
}