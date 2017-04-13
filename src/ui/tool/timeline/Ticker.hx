package ui.tool.timeline;

import haxe.ds.Vector;
import openfl.display.MovieClip;
import openfl.text.TextField;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * permits frame by frame scrubbing on the fly
 */
class Ticker extends MovieClip
{
	var tickArray:Vector<Tick>;
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
			this.tickArray[i].update(Common.sim_frames + i);
		}
	}
}