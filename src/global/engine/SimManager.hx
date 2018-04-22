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
	
	private var playback_rate:Float = 40;
	private var slow_rate:Float = 5;
	private var rateBelowOneFPS:Bool = false;
	private var rewind:Bool = false;
	private var ff_loop:Float = 1;
	
	private var playbackRates:Array<Int> = [1, 2, 5, 10, 15, 20, 25, 30, 35, 40, 80, 160, 320];
	private var playbackRateIndex:Int = 9;
	
	public function new() 
	{
		Common.gSimManager = this;
	}
	public function start_sim(_fromStart:Bool) {
		if (CVar.volatile.slow_motion_auto) {
			SVar.slow_motion = true;
			this.playback_rate = CVar.volatile.slow_motion_rate;
			this.slow_rate = CVar.volatile.slow_motion_rate;
		} else {
			SVar.slow_motion = false;
			this.playback_rate = 40;
			this.playbackRateIndex = 9;
			SVar.playbackModifierString = "";
		}
		if (!CVar.volatile.flagged || _fromStart) {
			SVar.frames = 0;
			Common.gRiderManager.restore_start();
		} else if (CVar.volatile.flagged) {
			Common.gRiderManager.restore_flag();
		}
		if (CVar.paused) {
			CVar.volatile.paused = false;
			SVar.pause_frame = -1;
		}
		Common.gRiderManager.set_rider_visual_start();
		if (!SVar.sim_running) {
			Common.gCode.return_to_origin_sim();
			if (CVar.volatile.slow_motion_auto) {
				SVar.sim_rate = 5;
			} else {
				SVar.sim_rate = 40;
			}
			this.set_timer();
			SVar.sim_running = true;
		}
		if (CVar.track.force_zoom) {
			SVar.prev_zoom_ammount = Common.gTrack.scaleX;
			Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = CVar.track.force_zoom_ammount;
		}
	}
	function update_sim()
	{
		if (CVar.paused) return;
		if (CVar.volatile.hit_test_live) {
			for (a in SubPanel.lit_lines) {
				a.visible = false;
			}
			SubPanel.lit_lines = new Array<Sprite>();
		}
		if (!this.rewind) {
			if (this.playback_rate > 40) {
				for (i in 0...Std.int(this.playback_rate / 40)) {
					Common.gRiderManager.advance_riders();
					++SVar.frames;
				}
			} else {
				Common.gRiderManager.advance_riders();
				++SVar.frames;
			}
		} else {
			if (this.playback_rate > 40) {
				for (i in 0...Std.int(this.playback_rate / 40)) {
					Common.gRiderManager.rewind_riders();
				}
			} else {
				Common.gRiderManager.rewind_riders();
			}
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
		if (SVar.sim_running || CVar.paused == true) {
			if (CVar.paused == true) CVar.paused = false;
			SVar.sim_running = false;
			SVar.frames_alt = SVar.frames;
			SVar.frames = 0;
			this.ff_loop = 1;
			this.iterator.stop();
			if (CVar.track.force_zoom) {
				Common.gTrack.scaleX = Common.gTrack.scaleY = Common.gRiderManager.scaleX = Common.gRiderManager.scaleY = SVar.prev_zoom_ammount;
			}
			if (CVar.volatile.flagged) {
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
		CVar.paused = true;
		SVar.pause_frame = SVar.frames;
	}
	public function resume_sim() {
		CVar.paused = false;
		SVar.pause_frame = -1;
	}
	public function set_rider_start(_x:Float, _y:Float)
	{
		Common.gRiderManager.set_start(_x, _y);
	}
	public function mark_rider_position() {
		Common.gRiderManager.set_flag();
		CVar.volatile.flagged = true;
		this.flag_av = true;
	}
	public function hide_flag() {
		Common.gRiderManager.disable_flag();
	}
	public function show_flag() {
		Common.gRiderManager.enable_flag();
	}
	public function reset() {
		Common.gRiderManager.destroy_flag();
		Common.gRiderManager.restore_start();
		Common.gRiderManager.update_render();
		CVar.volatile.flagged = false;
		this.flag_av = false;
	}
	public function decrease_playback_rate() {
		if (SVar.sim_rate == 1.25) return;
		this.iterator.stop();
		if (SVar.sim_rate <= 40 && this.ff_loop == 1) {
			SVar.sim_rate /= 2;
		} else {
			this.ff_loop /= 2;
		}
		this.set_timer();
	}
	public function increase_playback_rate() {
		if (this.ff_loop == 16) return;
		this.iterator.stop();
		if (SVar.sim_rate < 40) {
			SVar.sim_rate *= 2;
		} else {
			this.ff_loop *= 2;
		}
		this.set_timer();
	}
	public function set_timer() {
		this.iterator = new Timer(Std.int(1000 * ( 1 / SVar.sim_rate)));
		this.iterator.run = function():Void {
			for (a in 0...Std.int(this.ff_loop)) {
				this.update_sim();
				Common.gTextInfo.update_sim();
			}
		}
	}
	public function rewind_toggle() {
		if (this.rewind == false) {
			this.rewind = true;
		} else if (this.rewind != false){
			this.rewind = false;
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
		if (!this.rewind) {
			this.update_sim();
		} else {
			this.rewind = false;
			this.update_sim();
			this.rewind = true;
		}
	}
	public function step_backward() {
		if (this.rewind) {
			this.update_sim();
		} else {
			this.rewind = true;
			this.update_sim();
			this.rewind = false;
		}
	}
	public function sub_step_forward() {
		
	}
	public function sub_step_backward() {
		
	}
	public function injectRiderPosition(_frame:Int) {
		Common.gRiderManager.inject_frame(_frame);
	}
}