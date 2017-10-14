package global.engine;

import haxe.Timer;
import openfl.Lib;
import openfl.events.Event;

import global.Common;
import global.SVar;

/**
 * ...
 * @author ...
 */
class FrameRate 
{
	private var tick:Int;
	private var prevTime:Float = 0;
	private var time_mass:Float = 0;
	public function new() 
	{
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, calc_fps);
	}
	private function calc_fps(e:Event):Void 
	{
		var _loc1 = Timer.stamp();
		this.time_mass += (1/(_loc1 - prevTime));
		prevTime = Timer.stamp();
		++tick;
		if (tick >= SVar.framerate_avg_rate) {
			SVar.frame_rate = Math.floor(time_mass / SVar.framerate_avg_rate);
			this.time_mass = 0;
			tick = 0;
			Common.gTextInfo.update_textInfo_E();
		}
	}
}