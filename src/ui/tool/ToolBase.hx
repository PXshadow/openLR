package ui.tool;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * todo: Add in keyboard manager
 * 
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
		Common.gStage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseScroll);
		
		Common.gToolBase = this;
	}
	
	public function mMouseUp(e:MouseEvent):Void 
	{
		Common.gTrack.stopDrag();
	}
	
	public function mMouseDown(e:MouseEvent):Void 
	{
		Common.gTrack.startDrag();
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
	
	public function disable() {
		Common.gStage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		Common.gStage.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rMouseDown);
		Common.gStage.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, rMouseUp);
		Common.gStage.removeEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, mMouseDown);
		Common.gStage.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, mMouseUp);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseScroll);
	}
	public function enable() {
		Common.gStage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		Common.gStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		Common.gStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rMouseDown);
		Common.gStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, rMouseUp);
		Common.gStage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, mMouseDown);
		Common.gStage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, mMouseUp);
		Common.gStage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseScroll);
	}
	
	private function mouseScroll(e:MouseEvent):Void 
	{
		var _locPrePoint:Point = new Point(Common.gTrack.x, Common.gTrack.y);
		var _locPrevLoc:Point = Common.gStage.localToGlobal(_locPrePoint);
		var _locPrevScale = Common.track_scale;
		if (e.delta == 1) {
			if (Common.track_scale < Common.track_scale_max)
			{
				Common.track_scale += 0.2;
			} else {
				Common.track_scale = Common.track_scale_max;
			}
		} else if (e.delta == -1) {
			if (Common.track_scale > Common.track_scale_min) {
				Common.track_scale -= 0.2;
			} else {
				Common.track_scale == Common.track_scale_min;
			}
		}
		var _locNewScale = Common.track_scale;
		var _locRatio = (Math.min(Math.max(_locNewScale + _locNewScale * 0.004 * (e.delta * 0.2), 0.4), 24 ) / _locPrevScale);
		if (_locNewScale != _locPrevScale)
		{
			Common.gTrack.x = Common.stage_width * 0.5 + (_locPrevLoc.x - Common.stage_width * 0.5) * _locRatio - 0 * (e.delta * 0.2);
			Common.gTrack.y = Common.stage_height * 0.5 + (_locPrevLoc.y - Common.stage_height * 0.5) * _locRatio - 0 * (e.delta * 0.2);
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.track_scale;
		}
	}
}