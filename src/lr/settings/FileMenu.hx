package lr.settings;

import openfl.display.MovieClip;
import openfl.events.MouseEvent;

import ui.inter.SingleButton;
import ui.inter.StepCounter;
import ui.inter.CheckBox;
import global.Common;


/**
 * ...
 * @author Kaelan Evans
 * 
 * Settings needed:
 * 	Autosave
 * 		Frequency in minutes + Frequency in lines
 * 	Saving mode: Full, minimum (Changes between remembering every setting unique to the track or not)
 * 	Compress save (add when LZS Compression is implemented)
 * 
 */
class FileMenu extends MovieClip
{

	var sWidth:Float = 0;
	var sHeight:Float = 0;
	
	public function new() 
	{
		super();
		
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
	
}