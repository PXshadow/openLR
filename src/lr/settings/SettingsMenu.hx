package lr.settings;

import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import ui.inter.SingleButton;

import ui.inter.CheckBox;
import global.Common;
/**
 * ...
 * @author Kaelan Evans
 */
class SettingsMenu extends MovieClip
{
	var color_playback:CheckBox;
	var preview_mode:CheckBox;
	var hit_test:CheckBox;
	var angle_snap:CheckBox;
	var sHeight:Float;
	var sWidth:Float;
	private var exit:SingleButton;
	public function new() 
	{
		super();
		
		this.color_playback = new CheckBox("Color Play", Common.cvar_color_play);
		this.addChild(this.color_playback);
		this.color_playback.box.addEventListener(MouseEvent.CLICK, toggle_color_play);
		
		this.preview_mode = new CheckBox("Preview Mode", Common.cvar_preview_mode);
		this.addChild(this.preview_mode);
		this.preview_mode.y = 16;
		this.preview_mode.box.addEventListener(MouseEvent.CLICK, toggle_preview_mode);
		
		this.hit_test = new CheckBox("Hit Test", Common.cvar_hit_test);
		this.addChild(this.hit_test);
		this.hit_test.y = 32;
		this.hit_test.box.addEventListener(MouseEvent.CLICK, toggle_hit_test);
		
		this.angle_snap = new CheckBox("Angle Snap", Common.cvar_angle_snap);
		this.addChild(this.angle_snap);
		this.angle_snap.y = 64;
		this.angle_snap.box.addEventListener(MouseEvent.CLICK, toggle_angle_snap);
		
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
		
		this.exit = new SingleButton("Close", Common.gCode.toggleSettings_box);
		this.addChild(exit);
		this.exit.x = this.width + 5;
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
}