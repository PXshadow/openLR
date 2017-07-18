package lr.rider.objects;
import openfl.display.MovieClip;

/**
 * ...
 * @author Kaelan Evans
 */
class StartPointVis extends MovieClip
{

	public function new() 
	{
		super();
		this.graphics.clear();
		this.graphics.lineStyle(2, 0xFF0000, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.drawCircle(0, 0, 5);
		this.graphics.drawCircle(0, 0, 2);
		this.graphics.drawCircle(0, 0, 2);
	}
	
}