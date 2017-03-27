package global;

import haxe.Timer;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;

import lr.rider.RiderBase;
/**
 * ...
 * @author ...
 */
class SimManager 
{
	var iterator:Timer;
	var desired_rate:Int = 40;
	var rider:RiderBase;
	var sim_running:Bool = false;
	public var paused:Bool = false;
	public var flagged:Bool = false;
	private var flag_av:Bool = false;
	public function new() 
	{
		Common.gSimManager = this;
		this.rider = new RiderBase();
		Common.gStage.addEventListener(KeyboardEvent.KEY_DOWN, key_toggle_modifiers);
	}
	public function start_sim() {
		if (!flagged) {
			Common.sim_frames = 0;
			if (flag_av) {
				this.rider.reset();
			} else {
				this.rider.init_rider();
			}
		} else if (flagged) {
			this.rider.return_to_flag();
		}
		if (paused) {
			paused = false;
		}
		if (!sim_running) {
			this.iterator = new Timer(1000 * (1 / this.desired_rate));
			this.iterator.run = function():Void {
				this.update_sim();
				Common.gTextInfo.update_sim();
			}
			this.sim_running = true;
		}
		Common.gCode.return_to_origin_sim();
	}
	function update_sim()
	{
		this.rider.step_rider();
		++Common.sim_frames;
	}
	public function end_sim()
	{
		this.sim_running = false;
		Common.sim_frames = 0;
		this.iterator.stop();
	}
	public function pause_sim()
	{
		this.sim_running = false;
		this.iterator.stop();
		this.paused = true;
	}
	public function resume_sim() {
		this.iterator = new Timer(1000 / this.desired_rate);
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
		this.paused = false;
		this.sim_running = true;
	}
	public function set_rider_start(_x:Float, _y:Float)
	{
		this.rider.moveToStart(_x, _y);
	}
	public function mark_rider_position() {
		this.rider.flag_location();
		this.flagged = true;
		this.flag_av = true;
	}
	public function hide_flag() {
		try {
			this.rider.flag.alpha = 0.2;
		} catch (e:String) {}
	}
	public function show_flag() {
		try {
			this.rider.flag.alpha = 1;
		} catch (e:String) {}
	}
	public function reset() {
		this.rider.destroy_flag();
		this.flagged = false;
		this.flag_av = false;
	}
	private function key_toggle_modifiers(e:KeyboardEvent):Void 
	{
		
		if (e.keyCode == Keyboard.M) {
			if (Common.svar_sim_running) {
				if (Common.sim_slow_motion)
				{
					Common.sim_slow_motion = false;
					this.set_reg_speed();
				} else if (!Common.sim_slow_motion) {
					Common.sim_slow_motion = true;
					this.set_slow_speed();
				}
			}
		}
		if (e.keyCode == Keyboard.Y) {
			Common.gTrack.set_simmode_play();
		}
		if (e.keyCode == Keyboard.U) {
			Common.gTrack.set_simmode_stop();
		}
		if (e.keyCode == Keyboard.I) {
			if (Common.svar_sim_running) {
				Common.gSimManager.mark_rider_position();
				Common.gSimManager.show_flag();
			} else if (!Common.svar_sim_running) {
				if (Common.gSimManager.flagged == false) {
					Common.gSimManager.show_flag();
					Common.gSimManager.flagged = true;
				} else if (Common.gSimManager.flagged == true) {
					Common.gSimManager.hide_flag();
					Common.gSimManager.flagged = false;
				}
			}
		}
	}
	
	function set_slow_speed() 
	{
		this.iterator.stop();
		this.desired_rate = Common.sim_slow_motion_rate;
		this.iterator = new Timer(1000 * (1 / this.desired_rate));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	
	function set_reg_speed() 
	{
		this.iterator.stop();
		this.desired_rate = 40;
		this.iterator = new Timer(1000 * (1 / this.desired_rate));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
}