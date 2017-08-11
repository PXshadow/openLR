package lr.rider.phys.skeleton.scarf;

import haxe.ds.Vector;
import lr.rider.phys.frames.anchors.CPoint;

import lr.rider.phys.frames.anchors.SPoint;
import lr.rider.phys.skeleton.bones.ScarfStick;

/**
 * ...
 * @author Kaelan Evans
 */
class B2Scarf extends ScarfBase
{
	public function new(_shoulder:CPoint, _origin:CPoint, _x:Float, _y:Float, _id:Int) 
	{
		super();
		
		this.riderID = _id;
		
		this.start_x = _x;
		this.start_y = _y;
		this.shoulder = _shoulder;
		this.origin = _origin;
		
		this.anchors = new Vector(6); //Scarf contact points
		this.anchors[0] = new SPoint(7, -10);
		this.anchors[1] = new SPoint(3, -10);
		this.anchors[2] = new SPoint(0, -10);
		this.anchors[3] = new SPoint(-4, -10);
		this.anchors[4] = new SPoint(-7, -10);
		this.anchors[5] = new SPoint( -11, -10);
		
		for (a in anchors) {
			a.x *= 0.5;
			a.y *= 0.5;
		}
		for (i in 0...anchors.length) {
			anchors[i].x = anchors[i].x + this.start_x;
			anchors[i].y = anchors[i].y + this.start_y;
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
		
		this.edges = new Vector(6);
		this.edges[0] = new ScarfStick(this.shoulder, this.anchors[0]);
		this.edges[1] = new ScarfStick(this.anchors[0], this.anchors[1]);
		this.edges[2] = new ScarfStick(this.anchors[1], this.anchors[2]);
		this.edges[3] = new ScarfStick(this.anchors[2], this.anchors[3]);
		this.edges[4] = new ScarfStick(this.anchors[3], this.anchors[4]);
		this.edges[5] = new ScarfStick(this.anchors[4], this.anchors[5]);
	}
	override public function reset()
	{
		this.anchors[0].x = 7;
		this.anchors[0].y = -10;
		this.anchors[1].x = 3;
		this.anchors[1].y = -10;
		this.anchors[2].x = 0;
		this.anchors[2].y = -10;
		this.anchors[3].x = -4;
		this.anchors[3].y = -10;
		this.anchors[4].x = -7;
		this.anchors[4].y = -10;
		this.anchors[5].x = -11;
		this.anchors[5].y = -10;
		
		for (a in anchors) {
			a.x *= 0.5;
			a.y *= 0.5;
		}
		for (i in 0...anchors.length) {
			anchors[i].x = anchors[i].x + this.start_x;
			anchors[i].y = anchors[i].y + this.start_y;
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
	}
	public override function set_start(_x:Float, _y:Float) {
		this.start_x = _x;
		this.start_y = _y;
		for (i in 0...anchors.length) {
			anchors[i].x = anchors[i].x + this.start_x;
			anchors[i].y = anchors[i].y + this.start_y;
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
	}
}