package ui.tool;

import openfl.events.MouseEvent;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * testing class for mouse actions
 *
 */
class ToolMouseNull extends ToolBase
{

	public function new() 
	{
		super();
	}
	
	override public function mMouseDown(e:MouseEvent) {
		Common.gTrack.startDrag();
	}
	override public function mMouseUp(e:MouseEvent) {
		Common.gTrack.stopDrag();
	}
}