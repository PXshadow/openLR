package lr.rider.phys.skeleton;

import haxe.ds.Vector;

import lr.rider.phys.skeleton.bones.*;
import lr.rider.phys.contacts.anchors.*;

/**
 * ...
 * @author Kaelan Evans
 */
class B2Skeleton extends SkeletonBase
{
	public function new(_anchors:Vector<CPoint>)
	{
		super();
		
		this.edges = new Vector(22); //"Bones" that hold the rider together and help retain shape.
		
		this.edges[0] = new Stick(_anchors[0], _anchors[1]);// Sled
		this.edges[1] = new Stick(_anchors[1], _anchors[2]);//
		this.edges[2] = new Stick(_anchors[2], _anchors[3]);//
		this.edges[3] = new Stick(_anchors[3], _anchors[0]);//
		this.edges[4] = new Stick(_anchors[0], _anchors[2]);//
		this.edges[5] = new Stick(_anchors[3], _anchors[1]);//
		
		this.edges[6] = new BindStick(_anchors[0], _anchors[4]);// Sled to butt
		this.edges[7] = new BindStick(_anchors[1], _anchors[4]);//
		this.edges[8] = new BindStick(_anchors[2], _anchors[4]);//
		
		this.edges[9] = new Stick(_anchors[5], _anchors[4]); // Body
		this.edges[10] = new Stick(_anchors[5], _anchors[6]);//
		this.edges[11] = new Stick(_anchors[5], _anchors[7]);//
		this.edges[12] = new Stick(_anchors[4], _anchors[8]);//
		this.edges[13] = new Stick(_anchors[4], _anchors[9]);//
		this.edges[14] = new Stick(_anchors[5], _anchors[7]);//Duplicate of edge 11. Necesary for any compatibility with other builds
		
		this.edges[15] = new BindStick(_anchors[5], _anchors[0]);// Shoulder to second peg
		this.edges[16] = new BindStick(_anchors[3], _anchors[6]);// First peg to hand
		this.edges[17] = new BindStick(_anchors[3], _anchors[7]);// First peg to hand
		this.edges[18] = new BindStick(_anchors[8], _anchors[2]);// Foot to lower nose
		this.edges[19] = new BindStick(_anchors[9], _anchors[2]);// Foot to lower nose
		
		this.edges[20] = new RepellStick(_anchors[5], _anchors[8]);// Shoulder to feet. Keeps shoulder from getting too close to feet
		this.edges[21] = new RepellStick(_anchors[5], _anchors[9]);//
		
		this.edges[20].rest *= 0.5;
		this.edges[21].rest *= 0.5;
	}
}