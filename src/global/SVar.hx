package global;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Server variables. Varaibles for the engine or ones indirectly controlled by the player.
 */
class SVar 
{
	public static var current_tool:String = "none set";
	
	public inline static var eraser_size:Int = 5;
	
	public static var fl_frames:Int = 0;
	public static var flagged_frame:Int = -1;
	public static var frame_rate:Float;
	public static var frames:Int = 0;
	public static var frames_alt:Int = 0;
	
	public static var game_mode:Int = GameState.title;
	
	public static var keysEnabled:Bool = true;
	
	public static var lineCount:Int = 0;
	public static var lineCount_blue:Int = 0;
	public static var lineCount_red:Int = 0;
	public static var lineCount_green:Int = 0;
	public static var lineID:Int = 0;
	
	public static var max_frames:Int = 0;
	
	public static var new_track:Bool = true;
	public inline static var node_gridsize:Int = 14;
	public inline static var node_tilesize:Int = 140;
	
	public static var pause_frame:Int = -1;
	public static var playbackModifierString:String = "";
	public static var prev_zoom_ammount:Float;
	
	public static var rider_count = 0;
	public static var rider_speed:Float = 0;
	public static var rider_speed_top:Float = 0;
	
	public static var sim_running:Bool = false;
	public static var slow_motion:Bool = false;
	public static var snap_distance:Int = 20;
	public static var sim_rate:Float = 40;
	
	public static var track_date_stamp:String = "";
	
	public function new() 
	{
		
	}
	
}