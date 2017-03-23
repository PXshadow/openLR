package lr.rider.phys;
import openfl.geom.Point;
import openfl.utils.Object;

import global.Common;

/**
 * ...
 * @author ...
 */
class CPoint 
{
	public var loc:Point;
	public var x:Float;
	public var y:Float;
	public var vx:Float;
	public var vy:Float;
	public var dx:Float;
	public var dy:Float;
	public var fr:Float;
	public var ID:Int;
	public function new(_x:Float, _y:Float, _fr:Float, _id:Int) 
	{
		this.x = _x;
		this.y = _y;
		this.dx = this.dy = 0;
		this.vx = this.vy = 0;
		this.fr = _fr;
		this.ID = _id;
		this.loc = new Point(x, y);
	}
	public function verlet(grav:Object) {
		this.dx = this.x - this.vx + grav.x;
		this.dy = this.y - this.vy + grav.y;
		this.vx = this.x;
		this.vy = this.y;
		this.x = this.x + this.dx;
		this.y = this.y + this.dy;
		this.loc = Common.gStage.localToGlobal(new Point(x, y));
	}
}