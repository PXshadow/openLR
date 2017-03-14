package global;

import haxe.Timer;
/**
 * ...
 * @author ...
 */
class SimManager 
{
	var iterator:Timer;
	var desired_rate:Int = 40;
	public function new() 
	{
		this.iterator = new Timer(1000 * (1 / this.desired_rate));
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
	function update_sim()
	{
		++Common.sim_frames;
	}
	public function end_sim()
	{
		Common.sim_frames = 0;
		this.iterator.stop();
	}
	public function pause_sim()
	{
		this.iterator.stop();
	}
	public function resume_sim() {
		this.iterator = new Timer(1000 / this.desired_rate);
		this.iterator.run = function():Void {
			this.update_sim();
			Common.gTextInfo.update_sim();
		}
	}
}