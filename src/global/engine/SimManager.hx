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
	
	private var playbackRates:Array<Int> = [1, 2, 5, 10, 15, 20, 25, 30, 35, 40, 80, 160, 320];
	private var playbackRateIndex:Int = 9;
	
	public function new() 
	{
		Common.gSimManager = this;
	}
	public function start_sim(_fromStart:Bool) {
		if (CVar.slow_motion_auto) {
			SVar.slow_motion = true;
			this.playback_rate = CVar.slow_motion_rate;
			this.slow_rate = CVar.slow_motion_rate;
		} else {
			SVar.slow_motion = false;
			this.playback_rate = 40;
			this.playbackRateIndex = 9;
			SVar.playbackModifierString = "";
		}
		if (!CVar.flagged || _fromStart) {
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
			this.iterator = new Timer(Std.int(1000 * ( 1 / 60)));
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
	var milliseconds:Float = 0;
	function update_sim()
	{
		this.milliseconds += 1000 / 60;
		if (this.milliseconds <= (1000 / this.playback_rate) && this.playback_rate <= 40 || CVar.paused) return;
		else if (this.milliseconds <= (1000 / 40) && this.playback_rate > 40) return;
		else milliseconds = 0;
		
		if (CVar.hit_test_live) {
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
		CVar.paused = true;
		SVar.pause_frame = SVar.frames;
	}
	public function resume_sim() {
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
	public function decrease_playback_rate() {
		if (this.playbackRateIndex > 0) {
			--this.playbackRateIndex;
			this.playback_rate = this.playbackRates[this.playbackRateIndex];
		} else if (this.playbackRateIndex == 0 && this.playback_rate > 0.0625) {
			this.playback_rate *= 0.5;
		}
		if (this.playback_rate != 40) {
			SVar.playbackModifierString = " @" + this.playback_rate + "FPS";
		} else {
			SVar.playbackModifierString = "";
		}
	}
	public function increase_playback_rate() {
		if (this.playbackRateIndex < this.playbackRates.length - 1 && this.playbackRateIndex != 0 || this.playback_rate == 1) {
			++this.playbackRateIndex;
			this.playback_rate = this.playbackRates[this.playbackRateIndex];
		} else if (this.playbackRateIndex == 0 && this.playback_rate < 1 ) {
			this.playback_rate *= 2;
		}
		if (this.playback_rate != 40) {
			SVar.playbackModifierString = " @" + this.playback_rate + "FPS";
		} else {
			SVar.playbackModifierString = "";
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