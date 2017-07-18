package global;
import openfl.display.Sprite;
import openfl.geom.Point;

import lr.rider.RiderBaseNew;

/**
 * ...
 * @author Kaelan Evans
 */
class RiderManager extends Sprite
{
	private var riderArray:Array<RiderBaseNew>;
	public var startPoint0:Point = new Point(0, 0);
	public function new() 
	{
		super();
		Common.gRiderManager = this;
		
		this.riderArray = new Array();
		this.riderArray[0] = new RiderBaseNew(RiderType.Beta2);
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

	}
	public function restore_start() {

	}
	public function set_flag() {

	}
	public function enable_flag() {

	}
	public function disable_flag() {

	}
	public function restore_flag() {

	}
	public function destroy_flag() {

	}
	public function update_render() {

	}
	public function set_start(_x:Float, _y:Float, _id:Int = 0) {

	}
	public function inject_frame(_frame:Int) {

	}
}