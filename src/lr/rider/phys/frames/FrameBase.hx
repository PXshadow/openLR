package lr.rider.phys.frames;

import haxe.ds.Vector;
import openfl.utils.Object;

import lr.rider.phys.frames.anchors.CPoint;

/**
 * ...
 * @author Kaelan Evans
 */
class FrameBase 
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
	public function crash_check()
	{
		
	}
}