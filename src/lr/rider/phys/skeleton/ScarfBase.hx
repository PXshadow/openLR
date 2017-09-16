package lr.rider.phys.skeleton;

import haxe.ds.Vector;
import lr.rider.phys.frames.anchors.CPoint;
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
	public var shoulder:CPoint;
	public var origin:CPoint;
	
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
	public function set_start(_x:Float, _y:Float) {
		
	}
	public function set_frame_angle(_angle:Float) {
		if (_angle == 0) {
			return;
		}
		var _locRad = _angle * (Math.PI / 180);
		for (a in 0...anchors.length) {
			var x1 = anchors[a].x - this.origin.x;
			var y1 = anchors[a].y - this.origin.y;
			var x2 = (x1 * Math.cos(_locRad)) - (y1 * Math.sin(_locRad));
			var y2 = (y1 * Math.cos(_locRad)) + (x1 * Math.sin(_locRad));
			anchors[a].x = x2; 
			anchors[a].y = y2; 
		}
		this.adjust_velocity_start();
	}
	public function adjust_velocity_start(_vx:Float = 0.4, _vy:Float = 0) {
		for (i in 0...anchors.length) {
			anchors[i].x = anchors[i].x + this.start_x;
			anchors[i].y = anchors[i].y + this.start_y;
			anchors[i].vx = anchors[i].x - _vx;
			anchors[i].vy = anchors[i].y - _vy;
		}
	}
}