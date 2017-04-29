package lr.settings;

import openfl.display.MovieClip;
import openfl.events.MouseEvent;

import file.AutosaveManager;
import ui.inter.SingleButton;
import ui.inter.StepCounter;
import ui.inter.CheckBox;
import global.Common;


/**
 * ...
 * @author Kaelan Evans
 * 
 * Settings needed:
 * 	Saving mode: Full, minimum (Changes between remembering every setting unique to the track or not)
 * 	Compress save (add when LZS Compression is implemented)
 * 
 */
class FileMenu extends MovieClip
{

	var sWidth:Float = 0;
	var sHeight:Float = 0;
	
	var auto_save:CheckBox;
	var auto_save_freq:StepCounter;
	
	public function new() 
	{
		super();
		
		this.auto_save = new CheckBox("Autosave", true);
		this.addChild(this.auto_save);
		this.auto_save.x = 5;
		this.auto_save.y = 5;
		this.auto_save.box.addEventListener(MouseEvent.CLICK, toggle_autosave);
		this.auto_save_freq = new StepCounter();
		this.addChild(this.auto_save_freq);
		this.auto_save_freq.x = 5;
		this.auto_save_freq.y = this.auto_save.y + this.auto_save.height;
		this.auto_save_freq.set_numeric_mode(10, 60, 5, 10, " Min");
		this.auto_save_freq.stepDown.addEventListener(MouseEvent.CLICK, decAutoSaveFeq);
		this.auto_save_freq.stepUp.addEventListener(MouseEvent.CLICK, incAutoSaveFreq);
		
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
	
	private function incAutoSaveFreq(e:MouseEvent):Void 
	{
		Common.cvar_auto_save_freq = this.auto_save_freq.inc();
		Common.gAutoSaveManager.update_timer(Common.cvar_auto_save_freq);
	}
	private function decAutoSaveFeq(e:MouseEvent):Void 
	{
		Common.cvar_auto_save_freq = this.auto_save_freq.dec();
		Common.gAutoSaveManager.update_timer(Common.cvar_auto_save_freq);
	}
	private function toggle_autosave(e:MouseEvent):Void 
	{
		Common.cvar_auto_save = this.auto_save.toggle();
	}
}