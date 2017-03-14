package ui.tool.lr;
import openfl.events.MouseEvent;
import ui.tool.ToolBase;

import global.Common;

/**
 * ...
 * @author ...
 */
class ToolPan extends ToolBase
{

	public function new() 
	{
		super();
	}
	override public function mouseDown(e:MouseEvent) {
		Common.gTrack.startDrag();
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gTrack.stopDrag();
	}
}