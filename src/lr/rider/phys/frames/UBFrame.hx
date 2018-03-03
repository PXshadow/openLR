package lr.rider.phys.frames;

import haxe.ds.Vector;

import global.engine.RiderManager;
import lr.rider.phys.anchors.CPoint;
import lr.rider.phys.bones.Stick;

/**
 * ...
 * @author Kaelan Evans
 */
class UBFrame extends FrameBase
{

	public function new(_x:Float, _y:Float, _id:Int) 
	{
		super();
		
		this.riderID = _id;
		
		this.start_x = _x;
		this.start_y = _y;
		
		this.anchors = new Vector(14); //Rider contact points
		this.anchors[0] = new CPoint(0, 0, 0.8, 0); //2nd Peg
		this.anchors[1] = new CPoint(0, 10, 0, 1); //Upper Nose
		this.anchors[2] = new CPoint(30, 10, 0, 2); //Lower Nose
		this.anchors[3] = new CPoint(35, 0, 0, 3); //1st peg
		
		this.anchors[4] = new CPoint(10, 0, 0.8, 4); //Butt
		
		this.anchors[5] = new CPoint(10, -11, 0.8, 5); //Shoulder
		
		this.anchors[6] = new CPoint(15, -10, 0.1, 6); //elbow
		this.anchors[7] = new CPoint(23, -10, 0.1, 6); //hand
		
		this.anchors[8] = new CPoint(15, -10, 0.1, 6); //elbow
		this.anchors[9] = new CPoint(23, -10, 0.1, 7); //hand
		
		this.anchors[10] = new CPoint(17, 5, 0, 8); //knee
		this.anchors[11] = new CPoint(20, 10, 0, 8); //Foot
		
		this.anchors[12] = new CPoint(17, 5, 0, 8); //knee
		this.anchors[13] = new CPoint(20, 10, 0, 9); //Foot
		
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
		this.reset();
		this.start_x = _x;
		this.start_y = _y;
		for (i in 0...anchors.length) {
			anchors[i].x = anchors[i].x + this.start_x;
			anchors[i].y = anchors[i].y + this.start_y;
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
	}
	public override function reset() {
		this.anchors[0].x = 0; //2nd Peg
		this.anchors[0].y = 0; //2nd Peg
		this.anchors[1].x = 0; //Upper Nose
		this.anchors[1].y = 10; //Upper Nose
		this.anchors[2].x = 30; //Lower Nose
		this.anchors[2].y = 10; //Lower Nose
		this.anchors[3].x = 35; //1st peg
		this.anchors[3].y = 0; //1st peg
		
		this.anchors[4].x = 10; //Butt
		this.anchors[4].y = 0; //Butt
		
		this.anchors[5].x = 10; //Shoulder
		this.anchors[5].y = -11; //Shoulder
		
		this.anchors[6].x = 15; //elbow
		this.anchors[6].y = -10; //elbow
		this.anchors[7].x = 23; //hand
		this.anchors[7].y = -10; //hand
		
		this.anchors[8].x = 15; //elbow
		this.anchors[8].y = -10; //elbow
		this.anchors[9].x = 23; //hand
		this.anchors[9].y = -10; //hand
		
		this.anchors[10].x = 20; //Foot
		this.anchors[10].y = 10; //Foot
		this.anchors[11].x = 17; //knee
		this.anchors[11].y = 5; //knee
		
		this.anchors[12].x = 20; //Foot
		this.anchors[12].y = 10; //Foot
		this.anchors[13].x = 17; //knee
		this.anchors[13].y = 5; //knee
		
		for (i in anchors) {
			i.x *= 0.5;
			i.y *= 0.5;
			i.x += this.start_x;
			i.y += this.start_y;
			i.vx = i.x - 0.4;
			i.vy = i.y;
		}
	}
	
}