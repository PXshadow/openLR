package lr;
import openfl.display.MovieClip;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class Track extends MovieClip
{

	public function new() 
	{
		super();
		Common.gTrack = this;
		
		this.graphics.clear();
		this.graphics.lineStyle(1, 0x000000, 1);
		this.graphics.moveTo( -5, 0);
		this.graphics.lineTo(5, 0);
		this.graphics.moveTo(0, -5);
		this.graphics.lineTo(0, 5);
	}
	
}