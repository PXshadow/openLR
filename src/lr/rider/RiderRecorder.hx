package lr.rider;

import haxe.ds.Vector;

import global.Common;
import global.RiderManager;
import lr.rider.phys.frames.anchors.CPoint;
import lr.rider.phys.frames.anchors.SPoint;
import lr.rider.phys.skeleton.bones.Stick;

/**
 * ...
 * @author Kaelan Evans
 */
class RiderRecorder 
{
	private var frame_array:Array<Array<Array<Dynamic>>>;
	private var scarf_array:Array<Array<Array<Dynamic>>>;
	private var riderID:Int;
	public function new(_id:Int) 
	{
		this.frame_array = new Array();
		this.scarf_array = new Array();
		this.riderID = _id;
	}
	public function index_frame(_frame:Int, _anchors:Vector<CPoint>, _scarf:Vector<SPoint>) {
		this.frame_array[_frame] = new Array();
		this.scarf_array[_frame] = new Array();
		for (i in 0..._anchors.length) {
			this.frame_array[_frame][i] = new Array();
			this.frame_array[_frame][i][0] = _anchors[i].x;
			this.frame_array[_frame][i][1] = _anchors[i].y;
			this.frame_array[_frame][i][2] = _anchors[i].vx;
			this.frame_array[_frame][i][3] = _anchors[i].vy;
			this.frame_array[_frame][i][4] = _anchors[i].dx;
			this.frame_array[_frame][i][5] = _anchors[i].dy;
			this.frame_array[_frame][i][6] = RiderManager.crash[this.riderID];
		}
		for (j in 0..._scarf.length) {
			this.scarf_array[_frame][j] = new Array();
			this.scarf_array[_frame][j][0] = _scarf[j].x;
			this.scarf_array[_frame][j][1] = _scarf[j].y;
			this.scarf_array[_frame][j][2] = _scarf[j].vx;
			this.scarf_array[_frame][j][3] = _scarf[j].vy;
			this.scarf_array[_frame][j][4] = _scarf[j].dx;
			this.scarf_array[_frame][j][5] = _scarf[j].dy;
		}
	}
	public function inject_frame(_frame:Int, _anchors:Vector<CPoint>, _scarf:Vector<SPoint>) { //this doubles as the rewind
		try {
			for (i in 0..._anchors.length) {
				_anchors[i].x = this.frame_array[_frame][i][0];
				_anchors[i].y = this.frame_array[_frame][i][1];
				_anchors[i].vx = this.frame_array[_frame][i][2];
				_anchors[i].vy = this.frame_array[_frame][i][3];
				_anchors[i].dx = this.frame_array[_frame][i][4];
				_anchors[i].dy = this.frame_array[_frame][i][5];
				RiderManager.crash[this.riderID] = this.frame_array[_frame][i][6];
			}
			for (j in 0..._scarf.length) {
				_scarf[j].x = this.scarf_array[_frame][j][0];
				_scarf[j].y = this.scarf_array[_frame][j][1];
				_scarf[j].vx = this.scarf_array[_frame][j][2];
				_scarf[j].vy = this.scarf_array[_frame][j][3];
				_scarf[j].dx = this.scarf_array[_frame][j][4];
				_scarf[j].dy = this.scarf_array[_frame][j][5];
			}
			Common.sim_frames = _frame;
		} catch(e:String) {
			return;
		}
	}
}