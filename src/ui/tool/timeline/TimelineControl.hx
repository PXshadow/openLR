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
	var ticker_pause:Bool = false;
	var slider:Slider;
	public function new() 
	{
		super();
		Common.gTimeline = this;
		
		this.ticker = new Ticker();
		this.addChild(this.ticker);
		
		this.slider = new Slider();
		this.addChild(this.slider);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.addEventListener(MouseEvent.MOUSE_OUT, resume);
	}
	
	private function resume(e:MouseEvent):Void 
	{
		if (!Common.gSimManager.paused && !Common.gSimManager.sim_running) {
			Common.gToolBase.enable();
		}
	}
	
	private function preScrubSetup(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		this.ticker.addEventListener(MouseEvent.MOUSE_DOWN, downActionScrubber);
		Common.gStage.addEventListener(MouseEvent.MOUSE_UP, releaseActionScrubber);
		this.ticker.addEventListener(MouseEvent.MOUSE_UP, releaseActionScrubber);
	}
	
	private function releaseActionScrubber(e:MouseEvent):Void 
	{
		this.ticker.removeEventListener(MouseEvent.MOUSE_DOWN, downActionScrubber);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_DOWN, downActionScrubber);
		this.ticker.removeEventListener(MouseEvent.MOUSE_UP, releaseActionScrubber);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_UP, releaseActionScrubber);
		this.ticker.addEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.ticker.addEventListener(MouseEvent.MOUSE_OUT, resume);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, scrub);
		if (Common.gSimManager.paused && this.ticker_pause) {
			Common.gSimManager.resume_sim();
			this.ticker_pause = false;
		} else {
			Common.gToolBase.enable();
		}
	}
	
	private function downActionScrubber(e:MouseEvent):Void 
	{
		this.ticker.removeEventListener(MouseEvent.MOUSE_OUT, resume);
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, scrub);
		this.ticker.removeEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.prevX = this.mouseX;
		if (Common.gSimManager.sim_running) {
			Common.gSimManager.pause_sim();
			this.ticker_pause = true;
		}
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
		this.slider.update();
		this.slider.x = (this.width * 0.5) - (this.slider.width * 0.5);
		this.slider.y = - 20;
	}
}