package ui.tool.timeline;

import openfl.display.MovieClip;
import openfl.display.Sprite;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * permits scrubbing entire track
 */
class Slider extends MovieClip
{
	var frameRatio:Float = 1;
	var frameRatio_rounded:Int = 1;
	var playHead:Sprite;
	var frame_length = 0;
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
		this.playHead.graphics.lineTo(-5, -10);
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
			this.frameRatio_rounded = Math.floor(Common.sim_max_frames / 1000);
		}
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(this.frame_length, 0);
		trace(this.frameRatio, this.frameRatio_rounded, Common.sim_frames / this.frameRatio, this.playHead.x * this.frameRatio);
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