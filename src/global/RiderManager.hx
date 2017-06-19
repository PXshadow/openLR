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
		this.riderArray[0] = new RiderBase();
		this.addChild(this.riderArray[0]);
		Common.svar_rider_count += 1;
	}
	public function advance_riders() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].step_rider();
		}
	}
	public function rewind_riders() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].step_back();
		}
	}
	public function restore_start() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].reset();
		}
	}
	public function set_flag() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].flag_location();
		}
	}
	public function enable_flag() {
		for (rider in riderArray) {
			rider.show_flag();
		}
	}
	public function disable_flag() {
		for (rider in riderArray) {
			rider.hide_flag();
		}
	}
	public function restore_flag() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].return_to_flag();
		}
	}
	public function destroy_flag() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].destroy_flag();
		}
	}
	public function update_render() {
		if (Common.svar_rider_count == 1) {
			this.riderArray[0].render_body();
		}
	}
	public function set_start(_x:Float, _y:Float, _id:Int = 0) {
		//for now we are going to assume setting start always applies to rider 0 since for now there's only one rider
		this.riderArray[_id].moveToStart(_x, _y);
		this.startPoint0 = new Point(_x, _y);
	}
	public function inject_frame(_frame:Int) {
		for (rider in this.riderArray) {
			rider.inject_frame(_frame);
		}
	}
}