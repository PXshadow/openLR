package lr.lines;
import lr.rider.phys.frames.anchors.CPoint;
import openfl.utils.Object;

/**
 * ...
 * @author Kaelan Evans
 */
class Collision 
{
	private var parent:LineBase;
	public function new() 
	{
		
	}
	public function collide(dot:CPoint) {
		trace("No collision set. Am I supposed to be hit?");
	}
	public function checkIntersection(dot:CPoint):Bool
	{
		var a:Object = new Object();
		a.X = this.parent.x1;
		a.Y = this.parent.y1;
		var b:Object = new Object();
		b.X = this.parent.x2;
		b.Y = this.parent.y2;
		var c:Object = new Object();
		c.X = dot.vx;
		c.Y = dot.vy;
		var d:Object = new Object();
		d.X = dot.x;
		d.Y = dot.y;
		
		var denominator = ((b.X - a.X) * (d.Y - c.Y)) - ((b.Y - a.Y) * (d.X - c.X));
		var numerator1 = ((a.Y - c.Y) * (d.X - c.X)) - ((a.X - c.X) * (d.Y - c.Y));
		var numerator2 = ((a.Y - c.Y) * (b.X - a.X)) - ((a.X - c.X) * (b.Y - a.Y));
		if (denominator == 0) {
			return( numerator1 == 0 && numerator2 == 0);
		}
		var r = numerator1 / denominator;
		var s = numerator2 / denominator;
		
		return (r >= 0 && r <= 1) && (s >= 0 && s <= 1);
	}
}