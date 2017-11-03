package lr.scene.timeline;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import global.Common;
import global.SVar;

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
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, thisSlide);
		this.playHead.removeEventListener(MouseEvent.MOUSE_UP, endSlider);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, endSlider);
		if (Common.gSimManager.paused && SVar.game_mode == GameState.playback) {
			Common.gSimManager.resume_sim();
		} else {
			Common.gToolBase.enable();
		}
		SVar.pause_frame = -1;
	}
	
	private function preInitSlider(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, thisSlide);
		this.playHead.addEventListener(MouseEvent.MOUSE_UP, endSlider);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, endSlider);
		if (SVar.sim_running) {
			Common.gSimManager.pause_sim();
		}
		SVar.pause_frame = SVar.frames;
		SVar.frames_alt = SVar.frames;
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
			frameToInject = SVar.max_frames - 1;
		}
		Common.gSimManager.injectRiderPosition(frameToInject);
		Common.gTimeline.update();
	}
	public function update() {
		if (SVar.frames > this.frame_length) {
			this.frame_length = SVar.frames;
		}
		if (this.frame_length > 1000) {
			this.frame_length = 1000;
			this.max_length = true;
		}
		if (SVar.max_frames > 1000) {
			this.frameRatio = SVar.max_frames / 1000;
		}
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(this.frame_length, 0);
		if (max_length == true) {
			if (SVar.frames / this.frameRatio > 1000) {
				this.playHead.x = 1000;
			} else {
				this.playHead.x = SVar.frames / this.frameRatio;
			}
		} else {
			this.playHead.x = SVar.frames;
		}
	}
	
}