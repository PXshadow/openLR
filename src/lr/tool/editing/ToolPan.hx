package lr.tool.editing;
import openfl.events.MouseEvent;
import lr.tool.ToolBase;

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
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, mMouseMove);
	}
	override public function mouseUp(e:MouseEvent) {
		Common.gTrack.stopDrag();
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, mMouseMove);
	}
}