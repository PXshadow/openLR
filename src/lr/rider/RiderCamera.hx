package lr.rider;

import lr.rider.phys.CPoint;
import openfl.geom.Point;

import global.Common;

/**
 * ...
 * @author ...
 */
class RiderCamera 
{
	private var left_bound:Float = Common.stage_width * 0.38;
	private var right_bound:Float = Common.stage_width * 0.61;
	private var top_bound:Float = Common.stage_height * 0.38;
	private var bottom_bound:Float = Common.stage_height * 0.61;
	
	public function new() 
	{
		Common.gCamera = this;
	}
	public function pan(dot:CPoint) {
		var _locPoint:Point = Common.gTrack.localToGlobal(new Point(dot.x, dot.y));
		var _locXPan:Float = 0;
		var _locYPan:Float = 0;
		if (_locPoint.x > this.right_bound) {
			_locXPan = this.right_bound - _locPoint.x;
		} else if (_locPoint.x < this.left_bound) {
			_locXPan = this.left_bound - _locPoint.x;
		}
		if (_locPoint.y > this.bottom_bound) {
			_locYPan = this.bottom_bound - _locPoint.y;
		} else if (_locPoint.y < this.top_bound) {
			_locYPan = this.top_bound - _locPoint.y;
		}
		Common.gTrack.x += _locXPan;
		Common.gTrack.y += _locYPan;
		Common.gRiderManager.x += _locXPan;
		Common.gRiderManager.y += _locYPan;
		
	}
	public function update_pan_bounds() {
		this.left_bound = Common.stage_width * 0.38;
		this.right_bound = Common.stage_width * 0.61;
		this.top_bound = Common.stage_height * 0.38;
		this.bottom_bound = Common.stage_height * 0.61;
	}
}