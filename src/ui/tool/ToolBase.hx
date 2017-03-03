package ui.tool;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolBase
{
	public var type:String = "Null";

	public function new() 
	{
		Common.gStage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		Common.gStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
	}
	
	public function mouseUp(e:MouseEvent):Void 
	{
		trace(Common.gStage.mouseX, Common.gStage.mouseY);
	}
	
	public function mouseDown(e:MouseEvent):Void 
	{
		trace(Common.gStage.mouseX, Common.gStage.mouseY);
	}
	
}