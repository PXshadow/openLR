package global;

import openfl.display.Sprite;

/**
 * ...
 * @author Kaelan Evans
 */
class TrackMask extends Sprite
{
	
	public function new() 
	{
		super();
		
		this.graphics.clear();
	}
	public function update(_width:Int, _height:Int)
	{
		this.graphics.clear();
		this.graphics.beginFill(0, 0);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(_width, 0);
		this.graphics.lineTo(_width, _height);
		this.graphics.lineTo(0, _height);
		this.graphics.lineTo(0, 0);
	}
}