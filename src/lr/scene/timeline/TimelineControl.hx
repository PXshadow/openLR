package lr.scene.timeline;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import lr.scene.timeline.Ticker;
import lr.tool.Toolbar;
import lr.tool.ToolBase;
import global.Common;
import global.SVar;

/**
 * ...
 * @author Kaelan Evans
 */
class TimelineControl extends Sprite
{
	var ticker:Ticker;
	var ticker_pause:Bool = false;
	public function new() 
	{
		super();
		Common.gTimeline = this;
		
		this.graphics.clear();
		this.graphics.beginFill(0xAAAAAA, 0.75);
		this.graphics.moveTo( -15, -15);
		this.graphics.lineTo(1295, -15);
		this.graphics.lineTo(1295, 35);
		this.graphics.lineTo(-15, 35);
		
		this.ticker = new Ticker();
		this.addChild(this.ticker);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.addEventListener(MouseEvent.MOUSE_OUT, resume);
	}
	
	private function resume(e:MouseEvent):Void 
	{
		if (Common.gToolBase.currentTool.leftMouseIsDown) return;
		if (!Common.gSimManager.paused && !Common.gSimManager.sim_running) {
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	private function preScrubSetup(e:MouseEvent):Void 
	{
		if (Common.gToolBase.currentTool.leftMouseIsDown) return;
		this.preScrub();
	}
	function preScrub() 
	{
		trace("Resetting actions");
		Toolbar.tool.set_tool("None");
		this.addEventListener(MouseEvent.MOUSE_DOWN, downActionScrubber);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseActionOutside);
		this.addEventListener(MouseEvent.MOUSE_UP, releaseActionInside);
	}
	private function releaseActionInside(e:MouseEvent):Void 
	{
		trace("released inside");
		this.release();
		this.preScrub();
	}
	private function releaseActionOutside(e:MouseEvent):Void 
	{
		this.release();
	}
	private function downActionScrubber(e:MouseEvent):Void 
	{
		Toolbar.tool.set_tool("None");
		this.removeEventListener(MouseEvent.MOUSE_OUT, resume);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.hasRolledOut);
		this.addEventListener(MouseEvent.MOUSE_OVER, this.hasRolledIn);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, scrub);
		this.removeEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.prevX = this.mouseX;
		if (Common.gSimManager.sim_running) {
			Common.gSimManager.pause_sim();
			this.ticker_pause = true;
		}
	}
	function hasRolledOut(e:MouseEvent) {
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseActionOutside);
	}
	function hasRolledIn(e:MouseEvent) {
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, releaseActionOutside);
	}
	function release() {
		this.removeEventListener(MouseEvent.MOUSE_OUT, this.hasRolledOut);
		this.removeEventListener(MouseEvent.MOUSE_OVER, this.hasRolledIn);
		this.removeEventListener(MouseEvent.MOUSE_DOWN, downActionScrubber);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_DOWN, downActionScrubber);
		this.removeEventListener(MouseEvent.MOUSE_UP, releaseActionInside);
		this.addEventListener(MouseEvent.MOUSE_OVER, preScrubSetup);
		this.addEventListener(MouseEvent.MOUSE_OUT, resume);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, scrub);
		if (Common.gSimManager.paused && this.ticker_pause) {
			Common.gSimManager.resume_sim();
			this.ticker_pause = false;
		} else {
			SVar.frames_alt = SVar.frames;
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	private var prevX:Float = 0;
	private function scrub(e:MouseEvent):Void 
	{
		var curX:Float = this.mouseX;
		if (curX - prevX < -4) {
			Common.gSimManager.scrubberStepForward();
			this.prevX = this.mouseX;
		} else if (curX - prevX > 4) {
			Common.gSimManager.scrubberStepBack();
			this.prevX = this.mouseX;
		}
		this.update();
		Common.gTextInfo.update_sim();
	}
	public function update() {
		this.ticker.update();
	}
}