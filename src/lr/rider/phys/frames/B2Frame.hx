package lr.rider.phys.frames;

import haxe.ds.Vector;

import global.engine.RiderManager;
import lr.rider.phys.anchors.CPoint;

/**
 * ...
 * @author Kaelan Evans
 */
class B2Frame extends FrameBase
{
	public function new(_x:Float, _y:Float, _id:Int) 
	{
		super();
		
		this.riderID = _id;
		
		this.start_x = _x;
		this.start_y = _y;
		
		this.anchors = new Vector(10); //Rider contact points
		this.anchors[0] = new CPoint(0, 0, 0.8, 0); //2nd Peg
		this.anchors[1] = new CPoint(0, 10, 0, 1); //first peg
		this.anchors[2] = new CPoint(30, 10, 0, 2); //Lower Nose
		this.anchors[3] = new CPoint(35, 0, 0, 3); //String
		this.anchors[4] = new CPoint(10, 0, 0.8, 4); //Butt
		this.anchors[5] = new CPoint(10, -11, 0.8, 5); //Shoulder
		this.anchors[6] = new CPoint(23, -10, 0.1, 6); //hand
		this.anchors[7] = new CPoint(23, -10, 0.1, 7); //hand
		this.anchors[8] = new CPoint(20, 10, 0, 8); //Foot
		this.anchors[9] = new CPoint(20, 10, 0, 9); //Foot
		
		for (a in 0...anchors.length) {
			anchors[a].x *= 0.5;
			anchors[a].y *= 0.5;
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
		this.reset();
	}
	public override function reset() {
		this.anchors[0].x = 0;
		this.anchors[0].y = 0;
		this.anchors[1].x = 0;
		this.anchors[1].y = 10;
		this.anchors[2].x = 30;
		this.anchors[2].y = 10;
		this.anchors[3].x = 35;
		this.anchors[3].y = 0;
		this.anchors[4].x = 10;
		this.anchors[4].y = 0;
		this.anchors[5].x = 10;
		this.anchors[5].y = -11;
		this.anchors[6].x = 23;
		this.anchors[6].y = -10;
		this.anchors[7].x = 23;
		this.anchors[7].y = -10;
		this.anchors[8].x = 20;
		this.anchors[8].y = 10;
		this.anchors[9].x = 20;
		this.anchors[9].y = 10;
		
		for (i in anchors) {
			i.x *= 0.5;
			i.y *= 0.5;
			i.x += this.start_x;
			i.y += this.start_y;
			i.vx = i.x - 0.4;
			i.vy = i.y;
		}
		
		this.set_frame_angle();
	}
	override public function crash_check() {
		var _loc4:Float = this.anchors[3].x - this.anchors[0].x;
		var _loc5:Float = this.anchors[3].y - this.anchors[0].y;
		if (_loc4 * (this.anchors[1].y - this.anchors[0].y) - _loc5 * (this.anchors[1].x - this.anchors[0].x) < 0)
		{
			RiderManager.crash[this.riderID] = true; //Tail fakie counter measure.
		}
		if (_loc4 * (this.anchors[5].y - this.anchors[4].y) - _loc5 * (this.anchors[5].x - this.anchors[4].x) > 0)
		{
			RiderManager.crash[this.riderID] = true; //headflip check. Defs more of a bug than tail fake, prevents head from being logged beneath the sled.
		}
	}
}