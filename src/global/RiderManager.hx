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
	public static var crash:Array<Bool>;
	public function new() 
	{
		super();
		Common.gRiderManager = this;
		
		this.riderArray = new Array();
		RiderManager.crash = new Array();
	}
	public function add_rider(_type:Int, _x:Float, _y:Float) {
		switch(_type) {
			case 1 :
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta1, _x, _y, Common.svar_rider_count);
			case 2 :
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta2, _x, _y, Common.svar_rider_count);
			case 3 :
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta3a, _x, _y, Common.svar_rider_count);
			default:
				this.riderArray[Common.svar_rider_count] = new RiderBase(RiderType.Beta2, _x, _y, Common.svar_rider_count);
		}
		this.addChild(this.riderArray[Common.svar_rider_count]);
		RiderManager.crash[Common.svar_rider_count] = false;
		Common.svar_rider_count += 1;
	}
	public function set_rider_visual_start() {
		for (a in riderArray) {
			a.set_rider_play_mode();
		}
	}
	public function set_rider_visual_stop() {
		for (a in riderArray) {
			a.set_rider_edit_mode();
		}
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
	public function update_riders(_frame:Int) {
		for (a in riderArray) {
			a.inject_and_update(_frame);
		}
	}
	public function set_single_rider_start(_x:Float, _y:Float) {
		//this function assumes the only rider is the default one
		this.riderArray[0].set_start(_x, _y);
	}
	public function set_multiple_rider_start(_list:Array<Int>) {
		
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