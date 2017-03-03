package ui.tool.lr;

import openfl.events.MouseEvent;
import openfl.geom.Point;

import global.Common;
import ui.tool.ToolBase;

/**
 * ...
 * @author Kaelan Evans
 */
class Pencil extends ToolBase
{
	private var a:Point;
	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent) {
		a = new Point(Common.gTrack.mouseX, Common.gTrack.mouseY);
		trace(a);
	}
}