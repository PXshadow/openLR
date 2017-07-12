package lr.settings;

import openfl.display.Sprite;
import openfl.events.MouseEvent;

import ui.inter.SingleButton;
import ui.inter.StepCounter;
import ui.inter.CheckBox;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * 
 */
class TrackSettings extends Sprite
{
	var color_playback:CheckBox;
	var preview_mode:CheckBox;
	var hit_test:CheckBox;
	var angle_snap:CheckBox;
	var line_snap:CheckBox;
	var slow_motion:CheckBox;
	var contact_points:CheckBox;
	var bosh_alpha:StepCounter;
	var slow_rate:StepCounter;
	var force_zoom:CheckBox;
	var force_zoom_step:StepCounter;
	var frustrumCulling_toggle:CheckBox;
	
	var sWidth:Float = 0;
	var sHeight:Float = 0;
	
	public function new() 
	{
		super();
		
		this.color_playback = new CheckBox("Color Play", Common.cvar_color_play);
		this.addChild(this.color_playback);
		this.color_playback.hitBox.addEventListener(MouseEvent.CLICK, toggle_color_play);
		
		this.preview_mode = new CheckBox("Preview Mode", Common.cvar_preview_mode);
		this.addChild(this.preview_mode);
		this.preview_mode.y = 16;
		this.preview_mode.hitBox.addEventListener(MouseEvent.CLICK, toggle_preview_mode);
		
		this.hit_test = new CheckBox("Hit Test", Common.cvar_hit_test);
		this.addChild(this.hit_test);
		this.hit_test.y = 0;
		this.hit_test.x = 128;
		this.hit_test.hitBox.addEventListener(MouseEvent.CLICK, toggle_hit_test);
		
		this.contact_points = new CheckBox("Contact Points", Common.cvar_contact_points);
		this.addChild(this.contact_points);
		this.contact_points.y = 16;
		this.contact_points.x = 128;
		this.contact_points.hitBox.addEventListener(MouseEvent.CLICK, toggle_contact_points);
		this.bosh_alpha = new StepCounter();
		this.bosh_alpha.set_numeric_mode(0.1, 1, 0.1, 1, " Alpha");
		this.addChild(this.bosh_alpha);
		this.bosh_alpha.x = 128;
		this.bosh_alpha.y = this.contact_points.y + this.contact_points.height;
		this.bosh_alpha.stepDown.addEventListener(MouseEvent.CLICK, decBoshAlpha);
		this.bosh_alpha.stepUp.addEventListener(MouseEvent.CLICK, incBoshAlpha);
		
		this.angle_snap = new CheckBox("Angle Snap", Common.cvar_angle_snap);
		this.addChild(this.angle_snap);
		this.angle_snap.y = 64;
		this.angle_snap.hitBox.addEventListener(MouseEvent.CLICK, toggle_angle_snap);
		
		this.line_snap = new CheckBox("Line Snap", Common.cvar_line_snap);
		this.addChild(this.line_snap);
		this.line_snap.y = 80;
		this.line_snap.hitBox.addEventListener(MouseEvent.CLICK, toggle_line_snap);
		
		this.slow_motion = new CheckBox("Auto Slow", Common.sim_slow_motion);
		this.addChild(this.slow_motion);
		this.slow_motion.y = 112;
		this.slow_motion.hitBox.addEventListener(MouseEvent.CLICK, toggle_slow_motion);
		this.slow_rate = new StepCounter();
		this.addChild(this.slow_rate);
		this.slow_rate.y = 128;
		this.slow_rate.set_numeric_mode(1, 39, 1, 5, " FPS");
		this.slow_rate.stepUp.addEventListener(MouseEvent.CLICK, increase_slow_rate);
		this.slow_rate.stepDown.addEventListener(MouseEvent.CLICK, decrease_slow_rate);
		
		this.force_zoom = new CheckBox("Force Zoom", Common.cvar_force_zoom);
		this.addChild(this.force_zoom);
		this.force_zoom.x = 128;
		this.force_zoom.y = 112;
		this.force_zoom.hitBox.addEventListener(MouseEvent.CLICK, toggle_force_zoom);
		this.force_zoom_step = new StepCounter();
		this.addChild(this.force_zoom_step);
		this.force_zoom_step.x = 128;
		this.force_zoom_step.y = 128;
		this.force_zoom_step.set_numeric_mode(1, 24, 0.5, 2, "");
		this.force_zoom_step.stepUp.addEventListener(MouseEvent.CLICK, inc_force_zoom);
		this.force_zoom_step.stepDown.addEventListener(MouseEvent.CLICK, dec_force_zoom);
		
		this.frustrumCulling_toggle = new CheckBox("Line Culling", true);
		this.addChild(this.frustrumCulling_toggle);
		this.frustrumCulling_toggle.y = 162;
		this.frustrumCulling_toggle.hitBox.addEventListener(MouseEvent.CLICK, this.toggle_frustrumCulling);
		
		this.sWidth = this.width;
		this.sHeight = this.height;
	
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo( -5, -5);
		this.graphics.lineTo(this.sWidth + 5, -5);
		this.graphics.lineTo(this.sWidth + 5, this.sHeight + 5);
		this.graphics.lineTo(-5, this.sHeight + 5);
		this.graphics.lineTo( -5, -5);
	}
	
	private function toggle_frustrumCulling(e:MouseEvent):Void 
	{
		Common.cvar_frustrumCulling_enabled = this.frustrumCulling_toggle.toggle();
	}
	
	private function incBoshAlpha(e:MouseEvent):Void 
	{
		Common.cvar_rider_alpha = this.bosh_alpha.inc();
	}
	
	private function decBoshAlpha(e:MouseEvent):Void 
	{
		Common.cvar_rider_alpha = this.bosh_alpha.dec();
	}
	private function dec_force_zoom(e:MouseEvent):Void 
	{
		Common.cvar_force_zoom_ammount = this.force_zoom_step.dec();
	}
	
	private function inc_force_zoom(e:MouseEvent):Void 
	{
		Common.cvar_force_zoom_ammount = this.force_zoom_step.inc();
	}
	
	private function toggle_force_zoom(e:MouseEvent):Void 
	{
		Common.cvar_force_zoom = this.force_zoom.toggle();
	}
	
	private function decrease_slow_rate(e:MouseEvent):Void 
	{
		Common.sim_slow_motion_rate = this.slow_rate.dec();
	}
	
	private function increase_slow_rate(e:MouseEvent):Void 
	{
		Common.sim_slow_motion_rate = this.slow_rate.inc();
	}
	
	private function toggle_contact_points(e:MouseEvent):Void 
	{
		Common.cvar_contact_points = this.contact_points.toggle();
	}
	private function toggle_slow_motion(e:MouseEvent):Void 
	{
		Common.sim_auto_slow_motion = this.slow_motion.toggle();
		if (Common.sim_slow_motion) {
			Common.sim_default_rate = Common.sim_slow_motion_rate;
		} else {
			Common.sim_default_rate = 40;
		}
	}
	
	private function toggle_line_snap(e:MouseEvent):Void 
	{
		Common.cvar_line_snap = this.line_snap.toggle();
	}
	
	private function toggle_angle_snap(e:MouseEvent):Void 
	{
		Common.cvar_angle_snap = this.angle_snap.toggle();
	}
	
	private function toggle_hit_test(e:MouseEvent):Void 
	{
		Common.cvar_hit_test = this.hit_test.toggle();
	}
	
	private function toggle_preview_mode(e:MouseEvent):Void 
	{
		Common.cvar_preview_mode = this.preview_mode.toggle();
		Common.gTrack.set_rendermode_edit();
	}
	
	private function toggle_color_play(e:MouseEvent):Void 
	{
		Common.cvar_color_play = this.color_playback.toggle();
	}
	public function update()
	{
		this.color_playback.update(Common.cvar_color_play);
		this.preview_mode.update(Common.cvar_preview_mode);
		this.hit_test.update(Common.cvar_hit_test);
		this.angle_snap.update(Common.cvar_angle_snap);
		this.line_snap.update(Common.cvar_line_snap);
		this.slow_motion.update(Common.sim_auto_slow_motion);
		this.contact_points.update(Common.cvar_contact_points);
	}
}