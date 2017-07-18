package global;
import openfl.display.Sprite;
import openfl.geom.Point;

import lr.rider.RiderBase;

/**
 * ...
 * @author Kaelan Evans
 */
class RiderManager extends Sprite
{
	private var riderArray:Array<RiderBase>;
	public var startPoint0:Point = new Point(0, 0);
	public function new() 
	{
		super();
		Common.gRiderManager = this;
		
		this.riderArray = new Array();
		this.riderArray[0] = new RiderBase(RiderType.Beta2);
		this.addChild(this.riderArray[0]);
		Common.svar_rider_count += 1;
	}
	public function advance_riders() {
		for (a in riderArray) {
			a.step_rider();
		}
	}
	public function sub_step_riders() {
		for (a in riderArray) {
			a.step_rider_sub();
		}
	}
	public function rewind_riders() {
		for (a in riderArray) {
			a.step_rider_back();
		}
	}
	public function restore_start() {
		for (a in riderArray) {
			a.inject_postion(0);
		}
	}
	public function set_flag() {
		for (a in riderArray) {
			a.store_location();
		}
	}
	public function enable_flag() {

	}
	public function disable_flag() {

	}
	public function restore_flag() {
		for (a in riderArray) {
			a.inject_postion(Common.sim_flagged_frame);
		}
	}
	public function destroy_flag() {

	}
	public function update_render() {

	}
	public function set_start(_x:Float, _y:Float, _id:Int = 0) {

	}
	public function inject_frame(_frame:Int) {
		for (a in riderArray) {
			a.inject_postion(_frame);
		}
	}
}