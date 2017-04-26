package global;

import haxe.Timer;
import openfl.events.Event;

import global.Common;

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
		Common.gStage.addEventListener(Event.ENTER_FRAME, calc_fps);
	}
	private function calc_fps(e:Event):Void 
	{
		var _loc1 = Timer.stamp();
		this.time_mass += (1/(_loc1 - prevTime));
		prevTime = Timer.stamp();
		++tick;
		if (tick >= Common.svar_framerate_avg_rate) {
			Common.svar_frame_rate = Math.floor(time_mass / Common.svar_framerate_avg_rate);
			this.time_mass = 0;
			tick = 0;
			Common.gTextInfo.update_textInfo_E();
		}
	}
}