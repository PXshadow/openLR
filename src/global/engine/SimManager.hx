package global.engine;

import haxe.Timer;
import openfl.display.Sprite;

import lr.nodes.SubPanel;
import global.Common;
import global.CVar;

/**
 * ...
 * @author ...
 */
class SimManager 
{
	var iterator:Timer;
	
	private var flag_av:Bool = false;
	public function new() 
	{
		Common.gSimManager = this;
	}
	public function start_sim() {
		if (CVar.slow_motion_auto) {
			SVar.slow_motion = true;
			SVar.default_rate = CVar.slow_motion_rate;
		} else {
			SVar.slow_motion = false;
			SVar.default_rate = 40;
		}
		if (!CVar.flagged) {
			SVar.frames = 0;
			Common.gRiderManager.restore_start();
		} else if (CVar.flagged) {
			Common.gRiderManager.restore_flag();
		}
		if (CVar.paused) {
			CVar.paused = false;
			SVar.pause_frame = -1;
		}
		Common.gRiderManager.set_rider_visual_start();
		if (!SVar.sim_running) {
			Common.gCode.return_to_origin_sim();
			this.iterator = new Timer(Std.int(1000 * (1 / SVar.default_rate)));
			this.iterator.run = function():Void {
				this.update_sim();
				Common.gTextInfo.update_sim();
			}
			SVar.sim_running = true;
		}
		if (CVar.force_zoom) {
			CVar.prev_zoom_ammount = Common.gTrack.scaleX;
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = CVar.force_zoom_ammount * (CVar.force_zoom_inverse ? ( -1) : (1));
		} else if (CVar.force_zoom_inverse) {
			CVar.prev_zoom_ammount = Common.gTrack.scaleX;
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = (Common.gTrack.scaleX * (CVar.force_zoom_inverse ? ( -1) : (1)));
		}
	}
	function update_sim()
	{
		if (CVar.hit_test_live) {
			for (a in SubPanel.lit_lines) {
				a.visible = false;
			}
			SubPanel.lit_lines = new Array<Sprite>();
		}
		if (!CVar.fast_forward && !CVar.rewind) {
			Common.gRiderManager.advance_riders();
			++SVar.frames;
		} else if (CVar.fast_forward && !CVar.rewind) {
			for (a in 0...CVar.fast_forward_rate) {
				Common.gRiderManager.advance_riders();
				++SVar.frames;
			}
		} else if (CVar.rewind) {
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
		if (SVar.sim_running) {
			SVar.sim_running = false;
			SVar.frames_alt = SVar.frames;
			SVar.frames = 0;
			this.iterator.stop();
			if (CVar.force_zoom || CVar.force_zoom_inverse) {
				Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = CVar.prev_zoom_ammount;
			}
			if (CVar.flagged) {
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
		SVar.sim_running = false;
		this.iterator.stop();
		CVar.paused = true;
		SVar.pause_frame = SVar.frames;
	}
	public function resume_sim() {
		this.iterator = new Timer(Std.int(1000 * (1 / SVar.default_rate)));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
		CVar.paused = false;
		SVar.sim_running = true;
		SVar.pause_frame = -1;
	}
	public function set_rider_start(_x:Float, _y:Float)
	{
		Common.gRiderManager.set_start(_x, _y);
	}
	public function mark_rider_position() {
		Common.gRiderManager.set_flag();
		CVar.flagged = true;
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
		CVar.flagged = false;
		this.flag_av = false;
	}
	public function slow_motion_toggle() {
		if (SVar.slow_motion)
		{
			SVar.slow_motion = false;
			this.set_reg_speed();
		} else if (!SVar.slow_motion) {
			SVar.slow_motion = true;
			this.set_slow_speed();
		}
	}
	public function fast_forward_toggle() {
		if (!CVar.fast_forward) {
			CVar.fast_forward = true;
		} else {
			CVar.fast_forward = false;
		}
	}
	public function rewind_toggle() {
		if (CVar.rewind == false) {
			CVar.rewind = true;
			CVar.fast_forward = false;
		} else if (CVar.rewind != false){
			CVar.rewind = false;
			CVar.fast_forward = false;
		}
	}
	public function pause_play_toggle() {
		if (!SVar.sim_running && !CVar.paused) {
			Common.globalPlay();
		} else if (SVar.sim_running && !CVar.paused) {
			this.pause_sim();
		} else if (SVar.sim_running && CVar.paused) {
			this.resume_sim();
		}
	}
	public function step_forward() {
		if (!CVar.rewind) {
			this.update_sim();
		} else {
			CVar.rewind = false;
			this.update_sim();
			CVar.rewind = true;
		}
	}
	public function step_backward() {
		if (CVar.rewind) {
			this.update_sim();
		} else {
			CVar.rewind = true;
			this.update_sim();
			CVar.rewind = false;
		}
	}
	public function sub_step_forward() {
		
	}
	public function sub_step_backward() {
		
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