package lr.rider.phys;
import openfl.geom.Point;
import openfl.utils.Object;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class SPoint
{
	static public var airFric:Float = 0.9;
	public var x:Float;
	public var y:Float;
	public var vx:Float;
	public var vy:Float;
	public var dx:Float;
	public var dy:Float;
	
	public function new(_x:Float, _y:Float) 
	{
		this.x = _x;
		this.y = _y;
		this.dx = this.dy = 0;
		this.vx = this.vy = 0;
	}
	public function verlet(grav:Object) {
		this.dx = (this.x - this.vx) * SPoint.airFric + grav.x;
        this.dy = (this.y - this.vy) * SPoint.airFric + grav.y;
        this.vx = this.x;
        this.vy = this.y;
        this.x = this.x + this.dx;
        this.y = this.y + this.dy;
	}
}