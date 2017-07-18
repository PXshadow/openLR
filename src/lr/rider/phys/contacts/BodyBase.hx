package lr.rider.phys.contacts;

import haxe.ds.Vector;
import openfl.utils.Object;

import lr.rider.phys.contacts.anchors.CPoint;

/**
 * ...
 * @author Kaelan Evans
 */
class BodyBase 
{
	public var anchors:Vector<CPoint>;

	private var start_x:Float;
	private var start_y:Float;
	public function new() 
	{
		
	}
	public function verlet(_gravity:Object)
	{
		for (a in anchors) {
			a.verlet(_gravity);
		}
	}
	
}