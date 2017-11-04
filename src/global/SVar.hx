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
	public static var frames:Int = 0;
	public static var frames_alt:Int = 0;
	public static var max_frames:Int = 0;
	public static var fl_frames:Int = 0;
	public static var rider_speed:Float = 0;
	public static var rider_speed_top:Float = 0;
	public static var slow_motion:Bool = false;
	public static var default_rate:Int = 40;
	public static var pause_frame:Int = -1;
	public static var flagged_frame:Int = -1;
	public static var frame_rate:Float;
	public inline static var framerate_avg_rate:Int = 60;
	public inline static var gridsize:Int = 14;
	public inline static var tilesize:Int = 100;
	public inline static var eraser_size:Int = 5;
	public static var sim_running:Bool = false;
	public static var game_mode:Int = GameState.title;
	public static var snap_distance:Int = 20;
	public static var track_date_stamp:String = "";
	public static var rider_count = 0;
	public static var current_tool:String = "none set";
	public static var lineCount:Int = 0;
	public static var blueLineCount:Int = 0;
	public static var redLineCount:Int = 0;
	public static var greenLineCount:Int = 0;
	public static var lineID:Int = 0;
	
	public function new() 
	{
		
	}
	
}