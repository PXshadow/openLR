package lr.rider.phys.frames;

import haxe.ds.Vector;
import openfl.utils.Object;

import lr.rider.phys.anchors.CPoint;

/**
 * ...
 * @author Kaelan Evans
 */
class FrameBase 
{
	public var anchors:Vector<CPoint>;

	private var start_x:Float;
	private var start_y:Float;
	
	private var riderID:Int;
	
	private var angle:Float = 0;
	private var velX:Float = 0.4;
	private var velY:Float = 0;
	public function new() 
	{
		
	}
	public function verlet(_gravity:Object)
	{
		for (a in anchors) {
			a.verlet(_gravity);
		}
	}
	public function save_position() {
		for (a in anchors) {
			a.save();
		}
	}
	public function restore_position() {
		for (a in anchors) {
			a.restore();
		}
	}
	public function crash_check()
	{
		
	}
	public function reset() {
		
	}
	public function set_start(_x:Float, _y:Float) {
		
	}
	public function set_frame_angle(_angle:Float = null) {
		
		return;
		
		if (_angle != null) {
			this.angle = _angle;
		}
		var _locRad = angle * (Math.PI / 180);
		for (a in 0...anchors.length) {
			var x1 = anchors[a].x - anchors[0].x;
			var y1 = anchors[a].y - anchors[0].y;
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
			anchors[i].get_n();
		}
	}
}