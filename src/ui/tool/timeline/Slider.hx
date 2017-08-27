package ui.tool.timeline;

import openfl.display.Sprite;
import openfl.events.MouseEvent;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * permits scrubbing entire track
 */
class Slider extends Sprite
{
	var frameRatio:Float = 1;
	var playHead:Sprite;
	public var frame_length = 0;
	var max_length:Bool = false;
	public function new() 
	{
		super();
	
		this.playHead = new Sprite();
		this.addChild(this.playHead);
		this.playHead.graphics.clear();
		this.playHead.graphics.beginFill(0, 1);
		this.playHead.graphics.moveTo(5, -10);
		this.playHead.graphics.lineTo(5, 10);
		this.playHead.graphics.lineTo(-5, 10);
		this.playHead.graphics.lineTo( -5, -10);
		
		this.playHead.addEventListener(MouseEvent.MOUSE_DOWN, preInitSlider);
	}
	
	private function endSlider(e:MouseEvent):Void 
	{
		Common.gStage.removeEventListener(MouseEvent.MOUSE_MOVE, thisSlide);
		this.playHead.removeEventListener(MouseEvent.MOUSE_UP, endSlider);
		Common.gStage.removeEventListener(MouseEvent.MOUSE_UP, endSlider);
		if (Common.gSimManager.paused && Common.svar_game_mode == "running") {
			Common.gSimManager.resume_sim();
		} else {
			Common.gToolBase.enable();
		}
		Common.sim_pause_frame = -1;
	}
	
	private function preInitSlider(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		Common.gStage.addEventListener(MouseEvent.MOUSE_MOVE, thisSlide);
		this.playHead.addEventListener(MouseEvent.MOUSE_UP, endSlider);
		Common.gStage.addEventListener(MouseEvent.MOUSE_UP, endSlider);
		if (Common.svar_sim_running) {
			Common.gSimManager.pause_sim();
		}
		Common.sim_pause_frame = Common.sim_frames;
		Common.sim_frames_alt = Common.sim_frames;
	}
	private function thisSlide(e:MouseEvent):Void 
	{
		if (frame_length == 0) {
			return;
		}
		this.playHead.x = this.mouseX;
		var frameToInject = Std.int(Math.floor(playHead.x * frameRatio));
		if (this.mouseX <= 0) {
			this.playHead.x = 0;
			frameToInject = 0;
		} else if (this.mouseX >= this.frame_length) {
			this.playHead.x = this.frame_length;
			frameToInject = Common.sim_max_frames - 1;
		}
		Common.gSimManager.injectRiderPosition(frameToInject);
		Common.gTimeline.update();
	}
	public function update() {
		if (Common.sim_frames > this.frame_length) {
			this.frame_length = Common.sim_frames;
		}
		if (this.frame_length > 1000) {
			this.frame_length = 1000;
			this.max_length = true;
		}
		if (Common.sim_max_frames > 1000) {
			this.frameRatio = Common.sim_max_frames / 1000;
		}
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(this.frame_length, 0);
		if (max_length == true) {
			if (Common.sim_frames / this.frameRatio > 1000) {
				this.playHead.x = 1000;
			} else {
				this.playHead.x = Common.sim_frames / this.frameRatio;
			}
		} else {
			this.playHead.x = Common.sim_frames;
		}
	}
	
}