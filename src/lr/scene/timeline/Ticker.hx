package lr.scene.timeline;

import haxe.ds.Vector;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.text.TextField;

import global.SVar;

/**
 * ...
 * @author Kaelan Evans
 * 
 * permits frame by frame scrubbing on the fly
 */
class Ticker extends Sprite
{
	public var tickArray:Vector<Tick>;
	var timeStamp:TextField;
	public function new() 
	{
		super();
		
		this.tickArray = new Vector(320);
		for (i in 0...320) {
			this.tickArray[i] = new Tick(i);
			this.addChild(this.tickArray[i]);
			this.tickArray[i].x = i * 4;
		}
	}
	public function update() {
		for (i in 0...320) {
			this.tickArray[i].update(SVar.frames + i);
		}
	}
}
class Tick extends Shape
{
	public var frame:Int = 0;
	var color = 0xFFFFFF;
	public function new(_id:Int) 
	{
		super();
		
		this.frame = _id;
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(0, 25);
	}
	public function update(_id) {
		this.graphics.clear();
		this.frame = _id - 160;
		this.graphics.moveTo(0, 0);
		if (this.frame < 0) {
			this.graphics.lineStyle(4, 0, 0.1);
			this.graphics.lineTo(0, 25);
		} else if (this.frame > SVar.max_frames) {
			this.graphics.lineStyle(4, 0, 0.5);
			this.graphics.lineTo(0, 25);
		} else if (this.frame == SVar.frames) {
			this.graphics.lineStyle(4, 0x0066FF, 1);
			this.graphics.lineTo(0, 25);
		} else if (this.frame == SVar.pause_frame && SVar.pause_frame != -1) {
			this.graphics.lineStyle(4, 0x00CC00, 1);
			this.graphics.lineTo(0, 25);
		} else if (this.frame == SVar.flagged_frame && SVar.flagged_frame != -1) {
			this.graphics.lineStyle(4, 0xCC0000, 1);
			this.graphics.lineTo(0, 25);
		}
		else {
			if (this.frame % 10 == 1) {
				this.graphics.lineStyle(4, 0, 0.8);
			} else { 
				this.graphics.lineStyle(4, 0, 0.4);
			}
			this.graphics.lineTo(0, 25);
		}
	}
}