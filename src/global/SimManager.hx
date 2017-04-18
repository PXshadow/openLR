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
	var rider:RiderBase;
	public var sim_running:Bool = false;
	public var fast_forward:Bool = false;
	public var paused:Bool = false;
	public var flagged:Bool = false;
	public var rewind:Bool = false;
	private var flag_av:Bool = false;
	public function new() 
	{
		Common.gSimManager = this;
		this.rider = new RiderBase();
		Common.gStage.addEventListener(KeyboardEvent.KEY_DOWN, key_toggle_modifiers);
		Common.gStage.addEventListener(KeyboardEvent.KEY_UP, key_toggle_modifiers_up);
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
			Common.sim_pause_frame = -1;
		}
		if (!sim_running) {
			this.iterator = new Timer(1000 * (1 / Common.sim_default_rate));
			this.iterator.run = function():Void {
				this.update_sim();
				Common.gTextInfo.update_sim();
			}
			this.sim_running = true;
		}
		if (Common.cvar_force_zoom) {
			Common.cvar_prev_zoom_ammount = Common.gTrack.scaleX;
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.cvar_force_zoom_ammount;
		}
		Common.gCode.return_to_origin_sim();
	}
	function update_sim()
	{
		if (!this.fast_forward && !this.rewind) {
			this.rider.step_rider();
			++Common.sim_frames;
		} else if (this.fast_forward && !this.rewind) {
			for (a in 0...4) {
				this.rider.step_rider();
				++Common.sim_frames;
			}
		} else if (this.rewind) {
			this.rider.step_back();
		}
		if (Common.sim_frames > Common.sim_max_frames) {
			Common.sim_max_frames = Common.sim_frames;
		}
		Common.gTimeline.update();
	}
	public function scrubberStepBack() {
		if (Common.sim_frames > 0) {
			this.rider.step_back();
		} else if (Common.sim_frames == 0) {
			this.rider.reset();
			this.rider.reset();
		}
	}
	public function scrubberStepForward() {
		this.rider.step_rider();
		++Common.sim_frames;
		if (Common.sim_frames > Common.sim_max_frames) {
			Common.sim_max_frames = Common.sim_frames;
		}
	}
	public function end_sim()
	{
		if (this.sim_running) {
			this.sim_running = false;
			Common.sim_frames = 0;
			this.iterator.stop();
			if (Common.cvar_force_zoom) {
				Common.gTrack.scaleX = Common.gTrack.scaleY = Common.cvar_prev_zoom_ammount;
			}
		}
	}
	public function pause_sim()
	{
		this.sim_running = false;
		this.iterator.stop();
		this.paused = true;
		Common.sim_pause_frame = Common.sim_frames;
	}
	public function resume_sim() {
		this.iterator = new Timer(1000 / Common.sim_default_rate);
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
		this.paused = false;
		this.sim_running = true;
		Common.sim_pause_frame = -1;
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
		if (Common.svar_game_mode != "edit") {
			return;
		}
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
		if (e.keyCode == Keyboard.SPACE) {
			if (Common.svar_sim_running) {
				if (!this.fast_forward) {
					this.fast_forward = true;
				} else {
					this.fast_forward = false;
				}
			}
		}
		if (e.keyCode == Keyboard.CONTROL) {
			if (Common.svar_sim_running) {
				this.rewind = true;
				this.fast_forward = false;
			}
		}
		if (e.keyCode == Keyboard.Y) {
			if (!e.controlKey) {
				Common.gTrack.set_simmode_play();
			}
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
	private function key_toggle_modifiers_up(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.CONTROL) {
			this.rewind = false;
			if (Common.svar_sim_running) {
				Common.sim_frames += 1; //This is necesary as it prevents desync with the sim
			}
		}
	}
	function set_slow_speed() 
	{
		this.iterator.stop();
		Common.sim_default_rate = Common.sim_slow_motion_rate;
		this.iterator = new Timer(1000 * (1 / Common.sim_default_rate));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	
	function set_reg_speed() 
	{
		this.iterator.stop();
		Common.sim_default_rate = 40;
		this.iterator = new Timer(1000 * (1 / Common.sim_default_rate));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	public function injectRiderPosition(_frame:Int) {
		this.rider.inject_frame(_frame);
	}
}