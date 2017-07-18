package lr.rider.phys.skeleton;

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
	var shoulder:CPoint;
	public function new(_shoulder:CPoint) 
	{
		super();
		
		this.shoulder = _shoulder;
		
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
	}
}