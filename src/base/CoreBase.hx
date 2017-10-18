package base;

#if (!flash)
	import openfl.display.Stage;
	import openfl.display.Sprite;
#else
	import flash.display.Stage;
	import flash.display.Sprite;
#end

/**
 * ...
 * @author Kaelan Evans
 */
class CoreBase extends Sprite
{
	public function new() 
	{
		super();
	}
	public function return_to_origin(_x:Float = 0, _y:Float = 0) {
		
	}
	public function return_to_origin_sim() {
		
	}
	public function reset_timeline() {
		
	}
	public function toggle_Loader() {
		
	}
	public function toggleSettings_box() {
		
	}
	public function toggle_save_menu() {
		
	}
	public function take_screencap() {
		
	}
	public function end_screencap() {
		
	}
	public function start(_load:Bool = false) {
		
	}
	public function setScale() {
		
	}
	public function align() {
		
	}
}