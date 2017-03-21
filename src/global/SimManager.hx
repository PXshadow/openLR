package global;

import haxe.Timer;
import lr.rider.RiderBase;
/**
 * ...
 * @author ...
 */
class SimManager 
{
	var iterator:Timer;
	var desired_rate:Int = 40;
	var rider:RiderBase;
	var sim_running:Bool = false;
	public function new() 
	{
		this.rider = new RiderBase();
	}
	public function start_sim() {
		this.rider.init_rider();
		Common.sim_frames = 0;
		if (!sim_running) {
			this.iterator = new Timer(1000 * (1 / this.desired_rate));
			this.iterator.run = function():Void {
				this.update_sim();
				Common.gTextInfo.update_sim();
			}
			this.sim_running = true;
		}
	}
	function update_sim()
	{
		this.rider.step_rider();
		++Common.sim_frames;
	}
	public function end_sim()
	{
		this.sim_running = false;
		Common.sim_frames = 0;
		this.iterator.stop();
	}
	public function pause_sim()
	{
		this.sim_running = false;
		this.iterator.stop();
	}
	public function resume_sim() {
		this.iterator = new Timer(1000 / this.desired_rate);
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	public function set_rider_start(_x:Float, _y:Float)
	{
		this.rider.moveToStart(_x, _y);
	}
}