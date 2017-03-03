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
		Common.gStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rMouseDown);
		Common.gStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, rMouseUp);
		Common.gStage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, mMouseDown);
		Common.gStage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, mMouseUp);
	}
	
	public function mMouseUp(e:MouseEvent):Void 
	{
		trace(Common.gStage.mouseX, Common.gStage.mouseY);
	}
	
	public function mMouseDown(e:MouseEvent):Void 
	{
		trace(Common.gStage.mouseX, Common.gStage.mouseY);
	}
	
	public function rMouseUp(e:MouseEvent):Void 
	{
		trace(Common.gStage.mouseX, Common.gStage.mouseY);
	}
	
	public function rMouseDown(e:MouseEvent):Void 
	{
		trace(Common.gStage.mouseX, Common.gStage.mouseY);
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