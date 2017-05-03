package global;
import openfl.display.Sprite;

import lr.rider.RiderBase;

/**
 * ...
 * @author Kaelan Evans
 */
class RiderManager extends Sprite
{
	private var riderArray:Array<RiderBase>;
	public function new() 
	{
		super();
		Common.gRiderManager = this;
		
		this.riderArray = new Array();
		this.riderArray[0] = new RiderBase();
		this.addChild(this.riderArray[0]);
	}
	
}