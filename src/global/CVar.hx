package global;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Client Variables. Variables that are controlled by player input in some form.
 */
class CVar 
{
	public static var auto_save:Bool = true;
	public static var auto_save_freq:Int = 10;
	public static var angle_snap:Bool = false;
	public static var angle_snap_float:Float = 15;
	public static var angle_snap_offset:Int = 0;
	
	public static var color_play:Bool = false;
	public static var contact_points:Bool = false;
	
	public static var dictionary:String = "English";
	
	public static var force_zoom:Bool = false;
	public static var force_zoom_ammount:Float = 2;
	public static var force_zoom_inverse:Bool = false;
	
	public static var hit_test:Bool = false;
	public static var hit_test_live:Bool = false;
	
	public static var line_snap:Bool = true;
	
	public static var prev_zoom_ammount:Float;
	public static var preview_mode:Bool = false;
	
	public static var rider_alpha:Float = 10;
	
	public static var slow_motion_auto:Bool = false;
	public static var slow_motion_rate:Int = 5;
	
	public static var toolbar_scale:Float = 1;
	public static var track_author:String = "Made by: Anonymous";
	public static var track_name:String = "Untitled";
	public static var track_stepback_update:Int = 40;
	
	public static var universal_author_name:String = "Anonymous";
	
	public function new() 
	{
		
	}
	
}