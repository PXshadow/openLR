package lr.rider.phys;

import haxe.ds.Vector;

import lr.rider.phys.frames.anchors.CPoint;
import lr.rider.phys.skeleton.bones.Stick;

/**
 * ...
 * @author Kaelan Evans
 */
class RiderRecorder 
{
	private var frame_array:Array<Array<Array<Dynamic>>>;
	public function new() 
	{
		this.frame_array = new Array();
	}
	public function index_frame(_frame:Int, _anchors:Vector<CPoint>) {
		this.frame_array[_frame] = new Array();
		for (i in 0..._anchors.length) {
			this.frame_array[_frame][i] = new Array();
			this.frame_array[_frame][i][0] = _anchors[i].x;
			this.frame_array[_frame][i][1] = _anchors[i].y;
			this.frame_array[_frame][i][2] = _anchors[i].vx;
			this.frame_array[_frame][i][3] = _anchors[i].vy;
			this.frame_array[_frame][i][4] = _anchors[i].dx;
			this.frame_array[_frame][i][5] = _anchors[i].dy;
			this.frame_array[_frame][i][6] = Stick.crash;
		}
	}
	public function inject_frame(_frame:Int, _anchors:Vector<CPoint>) { //this doubles as the rewind
		
	}
}