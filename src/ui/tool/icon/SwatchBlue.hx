package ui.tool.icon;
import openfl.events.MouseEvent;
import global.Common;

/**
 * ...
 * @author ...
 */
class SwatchBlue  extends IconBase
{

	public function new() 
	{
		super();
		this.graphics.clear();
		this.graphics.beginFill(0x0066FF);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 15);
		this.graphics.lineTo(0, 15);
		this.graphics.lineTo(0, 0);
	}
	override public function down(e:MouseEvent) {
		Common.line_type = 0;
	}
	
}