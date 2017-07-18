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
	}
	public function add_rider(_type:Int) {
		switch(_type) {
			case 1 :
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta1);
			case 2 :
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta2);
			default:
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta2);
		}
		this.addChild(this.riderArray[Common.svar_rider_count]);
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
		for (a in riderArray) {
			a.enable_flag();
		}
	}
	public function disable_flag() {
		for (a in riderArray) {
			a.disable_flag();
		}
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