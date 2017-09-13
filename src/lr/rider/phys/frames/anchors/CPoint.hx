package lr.rider.phys.frames.anchors;
import openfl.geom.Point;
import openfl.utils.Object;

/**
 * ...
 * @author ...
 */
class CPoint 
{
	public var lgrav:Object;
	public var x:Float;
	public var y:Float;
	public var vx:Float;
	public var vy:Float;
	public var dx:Float;
	public var dy:Float;
	public var nx:Float;
	public var ny:Float;
	public var fr:Float;
	public var ID:Int;
	
	public var sx:Float;
	public var sy:Float;
	public var svx:Float;
	public var svy:Float;
	public var sdx:Float;
	public var sdy:Float;
	
	public function new(_x:Float, _y:Float, _fr:Float, _id:Int) 
	{
		this.x = _x;
		this.y = _y;
		this.dx = this.dy = 0;
		this.vx = this.vy = 0;
		this.fr = _fr;
		this.ID = _id;
		this.loc = new Point(x, y);
		this.lgrav = new Object();
		this.lgrav.x = 0;
		this.lgrav.y = 0.175;
	}
	public function verlet(grav:Object) {
		this.dx = this.x - this.vx + grav.x;
		this.dy = this.y - this.vy + grav.y;
		this.vx = this.x;
		this.vy = this.y;
		this.x = this.x + this.dx;
		this.y = this.y + this.dy;
		this.lgrav = grav;
		this.get_n();
	}
	public function get_n() 
	{
		var tdx = this.x - this.vx + lgrav.x;
		var tdy = this.y - this.vy + lgrav.y;
		this.nx = this.x + tdx;
		this.ny = this.y + tdy;
	}
	public function save() {
		this.sx = this.x;
		this.sy = this.y;
		this.svx = this.vx;
		this.svy = this.vy;
		this.sdx = this.dx;
		this.sdy = this.dy;
	}
	public function restore() {
		this.x = this.sx;
		this.y = this.sy;
		this.vx = this.svx;
		this.vy = this.svy;
		this.dx = this.sdx;
		this.dy = this.sdy;
	}
}