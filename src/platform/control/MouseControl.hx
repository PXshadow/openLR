package platform.control;

import platform.ControlBase;
import openfl.Lib;
import openfl.events.MouseEvent;

import openfl.geom.Point;

import global.Common;
import global.SVar;
import global.CVar;

/**
 * ...
 * @author Kaelan Evans
 */
class MouseControl extends ControlBase
{

	public function new() 
	{
		super();
		
		Lib.current.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, this.globalMiddleMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, this.globalMiddleMouseUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseScroll);
	}
	//Keyboard
	
	//Mouse
	private function globalMiddleMouseDown(e:MouseEvent):Void 
	{
		if (!SVar.sim_running) {
			this.mMouseDownPan(e);
			this.panning = true;
		}
	}
	private function globalMiddleMouseUp(e:MouseEvent):Void 
	{
		if (!SVar.sim_running && this.panning) {
			this.mMousePanUp(e);
			this.panning = false;
		}
	}
	public function mMouseDownPan(e:MouseEvent):Void 
	{
		Common.gTrack.startDrag();
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mMouseMovePan);
	}
	public function mMousePanUp(e:MouseEvent):Void 
	{
		Common.gTrack.stopDrag();
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mMouseMovePan);
	}
	public function mMouseMovePan(e:MouseEvent) {
		Common.gRiderManager.x = Common.gTrack.x;
		Common.gRiderManager.y = Common.gTrack.y;
		Common.gTrack.check_visibility();
	}
	private function mouseScroll(e:MouseEvent):Void 
	{
		if (SVar.game_mode == GameState.edit || SVar.game_mode == GameState.livedraw) {
			var platDelta:Float;
			#if (cpp || flash)
				platDelta = e.delta;
			#elseif (js)
				platDelta = e.delta / 100;
			#else
				trace("Unsupported platform, accomodate: ", e.delta);
				return;
			#end
			var trkLoc:Point = new Point(Common.gTrack.x, Common.gTrack.y);
			var localPoint:Point;
			if (CVar.local.scroll_cursor) {
				localPoint = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
			} else {
				localPoint = new Point(Lib.current.stage.stageWidth / 2, Lib.current.stage.stageHeight / 2);
			}
			var trkScale:Float = Common.gTrack.scaleX;
			var scaleToSet = Math.min(Math.max(trkScale + (trkScale * 0.1 * platDelta), Common.track_scale_min), Common.track_scale_max);
			Common.gTrack.x = (localPoint.x) + ((trkLoc.x - localPoint.x) * (scaleToSet / trkScale));
			Common.gTrack.y = (localPoint.y) + ((trkLoc.y - localPoint.y) * (scaleToSet / trkScale));
			Common.gTrack.scaleX = Common.gTrack.scaleY = scaleToSet;
			Common.gTrack.check_visibility();
		}
	}
}