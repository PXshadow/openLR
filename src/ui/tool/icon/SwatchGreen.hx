package ui.tool.icon;

import openfl.events.MouseEvent;
import global.Common;
import ui.tool.IconBase;

/**
 * ...
 * @author ...
 */
class SwatchGreen extends IconBase
{

	public function new() 
	{
		super();
		this.graphics.clear();
		this.graphics.beginFill(0x00CC00);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 15);
		this.graphics.lineTo(0, 15);
		this.graphics.lineTo(0, 0);
	}
	override public function down(e:MouseEvent) {
		Common.line_type = 2;
		Toolbar.swatch.deselect();
		Toolbar.swatch = this;
		this.select();
	}
	override public function select() 
	{
		Common.line_type = 2;
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0x00CC00);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 15);
		this.graphics.lineTo(0, 15);
		this.graphics.lineTo(0, 0);
	}
	override public function deselect() 
	{
		this.graphics.clear();
		this.graphics.beginFill(0x00CC00);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 15);
		this.graphics.lineTo(0, 15);
		this.graphics.lineTo(0, 0);
	}
}