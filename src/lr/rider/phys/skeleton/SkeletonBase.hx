package lr.rider.phys.skeleton;

import haxe.ds.Vector;
import lr.rider.phys.skeleton.bones.Stick;

/**
 * ...
 * @author Kaelan Evans
 */
class SkeletonBase 
{
	public var edges:Vector<Stick>;
	public function new() 
	{
		
	}
	public function constrain() {
		for (b in 0...edges.length) {
			if (edges[b].constrain()) {} //Adjust all of the riders bones (edges)
		}
		//for (d in edges_scarf) {
			//d.constrain(); //need to figure out how to keep slinky scarf
		//}
	}
}