package global;

import haxe.Timer;
/**
 * ...
 * @author ...
 */
class TrackTimer 
{
	var tick:Int = 0;
	var iterator:Timer();
	var desired_rate:Int = 40;
	public function new() 
	{
		this.iterator = new Timer(1000 / this.desired_rate);
		this.iterator.run = function {
				this.update_sim();
			}
		}
	}
	function update_sim()
	{
		++tick;
		trace(this.tick);
	}
}