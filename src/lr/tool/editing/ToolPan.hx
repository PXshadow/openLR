package lr.tool.editing;

import openfl.events.MouseEvent;

import global.Common;

/**
 * ...
 * @author ...
 */
class ToolPan extends ToolAction
{

	public function new() 
	{
		super();
	}
	override function leftMouseDown(e:MouseEvent):Void 
	{
		Common.gTrack.startDrag();
	}
	override function leftMouseUp(event:MouseEvent):Void 
	{
		Common.gTrack.stopDrag();
	}
}