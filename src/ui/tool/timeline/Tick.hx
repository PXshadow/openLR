package ui.tool.timeline;

import openfl.display.Sprite;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class Tick extends Sprite
{
	public var frame:Int = 0;
	public function new(_id:Int) 
	{
		super();
		
		this.frame = _id;
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(0, 20);
	}
	public function update(_id) {
		this.graphics.clear();
		this.frame = _id - 160;
		this.graphics.moveTo(0, 0);
		if (this.frame < 0) {
			this.graphics.lineStyle(4, 0, 0.1);
			this.graphics.lineTo(0, 10);
		} else if (this.frame > Common.sim_max_frames) {
			this.graphics.lineStyle(4, 0, 0.5);
			this.graphics.lineTo(0, 20);
		} else if (this.frame == Common.sim_frames) {
			this.graphics.lineStyle(4, 0x0066FF, 1);
			this.graphics.lineTo(0, 20);
		} else {
			this.graphics.lineStyle(4, 0, 0.8);
			this.graphics.lineTo(0, 20);
		}
	}
}