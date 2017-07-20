package lr.rider.phys.skeleton;

import haxe.ds.Vector;
import openfl.utils.Object;

import lr.rider.phys.skeleton.bones.ScarfStick;
import lr.rider.phys.frames.anchors.SPoint;

/**
 * ...
 * @author Kaelan Evans
 */
class ScarfBase 
{
	public var anchors:Vector<SPoint>;
	public var edges:Vector<ScarfStick>;
	private var start_x:Float;
	private var start_y:Float;
	private var riderID:Int;
	
	public function new() 
	{
		
	}
	public function reset() {
		
	}
	public function constrain() {
		for (a in edges) {
			a.constrain(); //need to figure out how to keep slinky scarf
		}
	}
	public function verlet(_grav:Object)
	{
		for (a in anchors) {
			a.verlet(_grav);
		}
	}
}