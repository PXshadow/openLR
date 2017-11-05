package global.engine;

import haxe.Timer;
import openfl.Lib;
import openfl.events.KeyboardEvent;

import global.Common;
import global.KeyBindings;
/**
 * ...
 * @author ...
 */
class SimManager 
{
	var iterator:Timer;
	public var sim_running:Bool = false;
	public var fast_forward:Bool = false;
	public var paused:Bool = false;
	public var flagged:Bool = false;
	public var rewind:Bool = false;
	private var flag_av:Bool = false;
	public function new() 
	{
		Common.gSimManager = this;
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, key_toggle_modifiers);
	}
	public function start_sim() {
		if (CVar.slow_motion_auto) {
			SVar.slow_motion = true;
			SVar.default_rate = CVar.slow_motion_rate;
		} else {
			SVar.slow_motion = false;
			SVar.default_rate = 40;
		}
		if (!flagged) {
			SVar.frames = 0;
			if (flag_av) {
				Common.gRiderManager.restore_start();
			}
		} else if (flagged) {
			Common.gRiderManager.restore_flag();
		}
		if (paused) {
			paused = false;
			SVar.pause_frame = -1;
		}
		Common.gRiderManager.set_rider_visual_start();
		if (!sim_running) {
			this.iterator = new Timer(Std.int(1000 * (1 / SVar.default_rate)));
			this.iterator.run = function():Void {
				this.update_sim();
				Common.gTextInfo.update_sim();
			}
			this.sim_running = true;
		}
		if (CVar.force_zoom) {
			CVar.prev_zoom_ammount = Common.gTrack.scaleX;
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = CVar.force_zoom_ammount * (CVar.force_zoom_inverse ? ( -1) : (1));
		} else if (CVar.force_zoom_inverse) {
			CVar.prev_zoom_ammount = Common.gTrack.scaleX;
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = (Common.gTrack.scaleX * (CVar.force_zoom_inverse ? ( -1) : (1)));
		}
		Common.gCode.return_to_origin_sim();
	}
	function update_sim()
	{
		if (CVar.hit_test) {
			for (a in Common.gGrid.lit_lines) {
				a.unrender_collide();
			}
			Common.gGrid.lit_lines = new Array();
		}
		if (!this.fast_forward && !this.rewind) {
			Common.gRiderManager.advance_riders();
			++SVar.frames;
		} else if (this.fast_forward && !this.rewind) {
			for (a in 0...4) {
				Common.gRiderManager.advance_riders();
				++SVar.frames;
			}
		} else if (this.rewind) {
			Common.gRiderManager.rewind_riders();
		}
		if (SVar.frames > SVar.max_frames) {
			SVar.max_frames = SVar.frames;
		}
		Common.gTimeline.update();
	}
	function sup_frame_update() {
		Common.gRiderManager.sub_step_riders();
	}
	public function scrubberStepBack() {
		if (SVar.frames > 0) {
			Common.gRiderManager.rewind_riders();
		} else if (SVar.frames == 0) {
			Common.gRiderManager.restore_start();
		}
	}
	public function scrubberStepForward() {
		Common.gRiderManager.advance_riders();
		++SVar.frames;
		if (SVar.frames > SVar.max_frames) {
			SVar.max_frames = SVar.frames;
		}
	}
	public function end_sim()
	{
		if (this.sim_running) {
			this.sim_running = false;
			SVar.frames_alt = SVar.frames;
			SVar.frames = 0;
			this.iterator.stop();
			if (CVar.force_zoom || CVar.force_zoom_inverse) {
				Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = CVar.prev_zoom_ammount;
			}
			if (this.flagged) {
				Common.gRiderManager.restore_flag();
			} else {
				Common.gRiderManager.restore_start();
			}
			Common.gRiderManager.update_render();
			Common.gRiderManager.set_rider_visual_stop();
		}
	}
	public function pause_sim()
	{
		SVar.frames_alt = SVar.frames;
		this.sim_running = false;
		this.iterator.stop();
		this.paused = true;
		SVar.pause_frame = SVar.frames;
	}
	public function resume_sim() {
		this.iterator = new Timer(Std.int(1000 * (1 / SVar.default_rate)));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
		this.paused = false;
		this.sim_running = true;
		SVar.pause_frame = -1;
	}
	public function set_rider_start(_x:Float, _y:Float)
	{
		Common.gRiderManager.set_start(_x, _y);
	}
	public function mark_rider_position() {
		Common.gRiderManager.set_flag();
		this.flagged = true;
		this.flag_av = true;
	}
	public function hide_flag() {
		Common.gRiderManager.disable_flag();
	}
	public function show_flag() {
		Common.gRiderManager.enable_flag();
	}
	public function rider_update() {
		return; //this will stay here until it learns to fucking behave
		var _loc1 = SVar.frames_alt - CVar.track_stepback_update;
		if (_loc1 <= 0) {
			//this.rider.inject_frame_and_iterate(0, SVar.frames_alt);
		} else {
			//this.rider.inject_frame_and_iterate(_loc1, CVar.track_stepback_update - 1);
		}
	}
	public function reset() {
		Common.gRiderManager.destroy_flag();
		Common.gRiderManager.restore_start();
		Common.gRiderManager.update_render();
		this.flagged = false;
		this.flag_av = false;
	}
	private function key_toggle_modifiers(e:KeyboardEvent):Void 
	{
		if (SVar.game_mode == GameState.edit) {
			return;
		}
		if (e.keyCode == KeyBindings.sm_toggle) {
			if (SVar.sim_running) {
				if (SVar.slow_motion)
				{
					SVar.slow_motion = false;
					this.set_reg_speed();
				} else if (!SVar.slow_motion) {
					SVar.slow_motion = true;
					this.set_slow_speed();
				}
			}
		}
		if (e.keyCode == KeyBindings.ff_toggle) {
			if (SVar.sim_running) {
				if (!this.fast_forward) {
					this.fast_forward = true;
				} else {
					this.fast_forward = false;
				}
			}
		}
		if (e.keyCode == KeyBindings.rw_toggle) {
			if (SVar.sim_running && this.rewind == false) {
				this.rewind = true;
				this.fast_forward = false;
			} else if (SVar.sim_running && this.rewind != false){
				this.rewind = false;
				this.fast_forward = false;
			}
		}
		if (e.keyCode == KeyBindings.pp_toggle) {
			if (!SVar.sim_running && !this.paused) {
				this.start_sim();
			} else if (SVar.sim_running && !this.paused) {
				this.pause_sim();
			} else if (SVar.sim_running && this.paused) {
				this.resume_sim();
			}
		}
		if (e.keyCode == KeyBindings.icon_play) {
			if (!e.controlKey) {
				Common.gTrack.set_simmode_play();
			}
		}
		if (e.keyCode == KeyBindings.icon_stop) {
			Common.gTrack.set_simmode_stop();
		}
		if (e.keyCode == KeyBindings.icon_flag) {
			if (SVar.sim_running) {
				Common.gSimManager.mark_rider_position();
				Common.gSimManager.show_flag();
			} else if (!SVar.sim_running) {
				if (Common.gSimManager.flagged == false) {
					Common.gSimManager.show_flag();
					Common.gSimManager.flagged = true;
				} else if (Common.gSimManager.flagged == true) {
					Common.gSimManager.hide_flag();
					Common.gSimManager.flagged = false;
				}
			}
		}
		if (e.keyCode == KeyBindings.step_forward) {
			if (!e.shiftKey) {
				this.update_sim();
				Common.gTimeline.update();
			} else if (e.shiftKey) {
				this.sup_frame_update();
			}
		}
		if (e.keyCode == KeyBindings.step_backward) {
			Common.gRiderManager.rewind_riders();
			Common.gTimeline.update();
		}
	}
	function set_slow_speed() 
	{
		this.iterator.stop();
		SVar.default_rate = CVar.slow_motion_rate;
		this.iterator = new Timer(Std.int(1000 * (1 / SVar.default_rate)));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	
	function set_reg_speed() 
	{
		this.iterator.stop();
		SVar.default_rate = 40;
		this.iterator = new Timer(Std.int(1000 * (1 / SVar.default_rate)));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	public function injectRiderPosition(_frame:Int) {
		Common.gRiderManager.inject_frame(_frame);
	}
}