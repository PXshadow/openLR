package lr.rider.phys.skeleton.links;

import haxe.ds.Vector;
import lr.rider.phys.anchors.CPoint;

import lr.rider.phys.skeleton.bones.*;
import lr.rider.phys.contacts.anchors.*;

/**
 * ...
 * @author Kaelan Evans
 */
class UBSkeleton extends SkeletonBase
{

	public function new(_anchors:Vector<CPoint>, _id:Int) 
	{
		super();
		
		this.riderID = _id;
		
		this.edges = new Vector(33); //"Bones" that hold the rider together and help retain shape.
		
		this.edges[0] = new Stick(_anchors[0], _anchors[1]);// Sled
		this.edges[1] = new Stick(_anchors[1], _anchors[2]);//
		this.edges[2] = new Stick(_anchors[2], _anchors[3]);//
		this.edges[3] = new Stick(_anchors[3], _anchors[0]);//
		this.edges[4] = new Stick(_anchors[0], _anchors[2]);//
		this.edges[5] = new Stick(_anchors[3], _anchors[1]);//
		
		this.edges[6] = new BindStick(_anchors[0], _anchors[4], this.riderID);// Sled to butt
		this.edges[7] = new BindStick(_anchors[1], _anchors[4], this.riderID);//
		this.edges[8] = new BindStick(_anchors[2], _anchors[4], this.riderID);//
		
		this.edges[9] = new Stick(_anchors[5], _anchors[4]); // Body
		
		//Arm 1
		this.edges[10] = new Stick(_anchors[5], _anchors[6]);// Shoulder to Elbow
		this.edges[11] = new Stick(_anchors[6], _anchors[7]);// Elbow to Hand
		this.edges[12] = new RepellStick(_anchors[5], _anchors[7]);// Shoulder to hand
		
		//Arm 2
		this.edges[13] = new Stick(_anchors[5], _anchors[8]);// Shoulder to Elbow
		this.edges[14] = new Stick(_anchors[8], _anchors[9]);// Elbow to Hand
		this.edges[15] = new RepellStick(_anchors[5], _anchors[9]);// Shoulder to hand
		
		//Leg 1
		this.edges[16] = new Stick(_anchors[4], _anchors[10]);// Butt to knee
		this.edges[17] = new Stick(_anchors[10], _anchors[11]);// Knee too foot
		this.edges[18] = new RepellStick(_anchors[4], _anchors[11]);// Butt to foot
		
		//Leg 2
		this.edges[19] = new Stick(_anchors[4], _anchors[12]);// Butt to knee
		this.edges[20] = new Stick(_anchors[12], _anchors[13]);// Knee too foot
		this.edges[21] = new RepellStick(_anchors[4], _anchors[13]);// Butt to foot
		
		
		this.edges[22] = new RepellStick(_anchors[0], _anchors[10]);//
		this.edges[23] = new RepellStick(_anchors[3], _anchors[10]);//
		this.edges[24] = new RepellStick(_anchors[0], _anchors[12]);//
		this.edges[25] = new RepellStick(_anchors[3], _anchors[12]);//
		
		this.edges[26] = new BindStick(_anchors[5], _anchors[0], this.riderID);// Shoulder to second peg
		this.edges[27] = new BindStick(_anchors[3], _anchors[7], this.riderID);// First peg to hand
		this.edges[28] = new BindStick(_anchors[3], _anchors[9], this.riderID);// First peg to hand
		this.edges[29] = new BindStick(_anchors[11], _anchors[2], this.riderID);// Foot to lower nose
		this.edges[30] = new BindStick(_anchors[13], _anchors[2], this.riderID);// Foot to lower nose
		
		this.edges[31] = new RepellStick(_anchors[5], _anchors[11]);// Shoulder to feet. Keeps shoulder from getting too close to feet
		this.edges[32] = new RepellStick(_anchors[5], _anchors[13]);//
		
		this.edges[12].rest *= 0.5;
		this.edges[15].rest *= 0.5;
		this.edges[18].rest *= 0.5;
		this.edges[21].rest *= 0.5;
	}
	
}