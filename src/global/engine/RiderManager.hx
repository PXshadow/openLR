package global.engine;
import openfl.display.Sprite;

import lr.rider.RiderBase;

/**
 * ...
 * @author Kaelan Evans
 */
class RiderManager extends Sprite
{
	public var riderArray:Array<RiderBase>;
	public static var crash:Array<Bool>;
	public static var speed:Array<Float>;
	public function new() 
	{
		super();
		Common.gRiderManager = this;
		
		this.riderArray = new Array();
		RiderManager.crash = new Array();
		RiderManager.speed = new Array();
	}
	public function add_rider(_type:Int, _x:Float, _y:Float) {
		this.riderArray[SVar.rider_count] = new RiderBase(_type, _x, _y, SVar.rider_count);
		this.riderArray[SVar.rider_count].set_init_start();
		Common.gTrack.rider.addChild(this.riderArray[SVar.rider_count]);
		RiderManager.crash[SVar.rider_count] = false;
		SVar.rider_count += 1;
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
			a.inject_postion(SVar.flagged_frame);
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
	public function set_rider_colors(_index:Int, _hexA:Int, _hexB:Int) {
		this.riderArray[_index].update_color(_hexA, _hexB);
	}
	public function set_rider_name(_index:Int, _name:String) {
		this.riderArray[_index].update_name(_name);
	}
	public function set_multiple_rider_start(_list:Array<Int>) {
		
	}
	public function destroy_flag() {

	}
	public function update_render() {

	}
	public function set_start(_x:Float, _y:Float, _id:Int = 0) {
		this.riderArray[_id].set_start(_x, _y);
	}
	public function inject_frame(_frame:Int) {
		for (a in riderArray) {
			a.inject_postion(_frame);
		}
	}
}