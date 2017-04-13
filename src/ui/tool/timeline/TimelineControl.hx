package ui.tool.timeline;

import cpp.Pointer;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import ui.tool.timeline.Ticker;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class TimelineControl extends MovieClip
{
	var ticker:Ticker;
	public function new() 
	{
		super();
		Common.gTimeline = this;
		
		this.ticker = new Ticker();
		this.addChild(this.ticker);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.addEventListener(MouseEvent.MOUSE_OUT, resume);
	}
	
	private function resume(e:MouseEvent):Void 
	{
		Common.gToolBase.enable();
	}
	
	private function preScrubSetup(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		this.addEventListener(MouseEvent.MOUSE_DOWN, downAction);
		Common.gStage.addEventListener(MouseEvent.MOUSE_UP, releaseAction);
		this.addEventListener(MouseEvent.MOUSE_UP, releaseAction);
	}
	
	private function releaseAction(e:MouseEvent):Void 
	{
		this.removeEventListener(MouseEvent.MOUSE_DOWN, downAction);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_DOWN, downAction);
		this.removeEventListener(MouseEvent.MOUSE_UP, releaseAction);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_UP, releaseAction);
		this.addEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.addEventListener(MouseEvent.MOUSE_OUT, resume);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, scrub);
		Common.gToolBase.enable();
	}
	
	private function downAction(e:MouseEvent):Void 
	{
		this.removeEventListener(MouseEvent.MOUSE_OUT, resume);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, scrub);
		this.removeEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.prevX = this.mouseX;
	}
	private var prevX:Float = 0;
	private function scrub(e:MouseEvent):Void 
	{
		var curX:Float = this.mouseX;
		if (curX - prevX < -4) {
			Common.gSimManager.scrubberStepForward();
			this.prevX = this.mouseX;
			this.update();
		} else if (curX - prevX > 4) {
			Common.gSimManager.scrubberStepBack();
			this.prevX = this.mouseX;
			this.update();
		}
		Common.gTextInfo.update_sim();
	}
	public function update() {
		this.ticker.update();
	}
}