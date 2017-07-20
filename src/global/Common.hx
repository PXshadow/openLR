package global;

import openfl.Assets;
import global.RiderManager;
import openfl.utils.Object;
import openfl.display.MovieClip;
import openfl.display.Stage;
import openfl.geom.Point;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import lr.Track;
import file.AutosaveManager;
import file.LoadManager;
import file.SaveManager;
import ui.tool.ToolBase;
import ui.tool.timeline.TimelineControl;
import ui.tool.Toolbar;
import lr.track.TextInfo;
import lr.nodes.B2Grid;
import lr.nodes.VisGrid;
import lr.rider.RiderCamera;

/**
 * ...
 * @author Kaelan Evans
 */
class Common
{

	public function new() 
	{
		
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//variables
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public static var version:String = "0.0.5";
	
	public static var gStage:Stage;
	public static var gCode:Main;
	public static var gTrack:Track;
	public static var gRiderManager:RiderManager;
	public static var gVisContainer:MovieClip;
	public static var gToolBase:ToolBase;
	public static var gToolCurrent:ToolBase;
	public static var gGrid:B2Grid;
	public static var gVisGrid:VisGrid;
	public static var gSaveManager:SaveManager;
	public static var gLoadManager:LoadManager;
	public static var gSimManager:SimManager;
	public static var gTextInfo:TextInfo;
	public static var gToolbar:Toolbar;
	public static var gCamera:RiderCamera;
	public static var gTimeline:TimelineControl;
	public static var gAutoSaveManager:AutosaveManager;
	
	public static var line_minLength:Int = 14;
	public static var line_type:Int = 0;
	
	public static var sLineCount:Int = 0;
	public static var sBLueLineCount:Int = 0;
	public static var sRedLineCount:Int = 0;
	public static var sGreenLineCount:Int = 0;
	public static var sLineID:Int = 0;
	
	public static var track_scale:Float;
	public static var track_scale_max:Float = 24;
	public static var track_scale_min:Float = 0.4;
	public static var track_start_x:Float = 0;
	public static var track_start_y:Float = 0;
	public static var track_last_pos_x:Float = 0;
	public static var track_last_pos_y:Float = 0;
	
	public static var sim_frames:Int = 0;
	public static var sim_frames_alt:Int = 0;
	public static var sim_max_frames:Int = 0;
	public static var simfl_frames:Int = 0;
	public static var sim_rider_speed:Float = 0;
	public static var sim_rider_speed_top:Float = 0;
	public static var sim_slow_motion:Bool = false;
	public static var sim_auto_slow_motion:Bool = false;
	public static var sim_slow_motion_rate:Int = 5;
	public static var sim_default_rate:Int = 40;
	public static var sim_pause_frame:Int = -1;
	public static var sim_flagged_frame:Int = -1;
	
	public static var cvar_dictionary:String = "English";
	public static var cvar_angle_snap_float:Float = 15;
	public static var cvar_angle_snap_offset:Int = 0;
	public static var cvar_angle_snap:Bool = false;
	public static var cvar_line_snap:Bool = true;
	public static var cvar_track_author:String = "Made by: Anonymous";
	public static var cvar_track_name:String = "Untitled";
	public static var cvar_author_comment:String = "This save was made in an alpha version of openLR. Please respect my rights as a track maker and avoid sharing this save without my permission.";
	public static var cvar_color_play:Bool = false;
	public static var cvar_preview_mode:Bool = false;
	public static var cvar_hit_test:Bool = false;
	public static var cvar_contact_points:Bool = false;
	public static var cvar_force_zoom:Bool = false;
	public static var cvar_force_zoom_ammount:Float = 2;
	public static var cvar_prev_zoom_ammount:Float;
	public static var cvar_add_time_stamp = false;
	public static var cvar_author_collab_list:Array<String>;
	public static var cvar_universal_author_name:String = "Anonymous";
	public static var cvar_track_stepback_update:Int = 40;
	public static var cvar_rider_alpha:Float = 1;
	public static var cvar_auto_save:Bool = true;
	public static var cvar_auto_save_freq:Int = 10;
	public static var cvar_frustrumCulling_enabled:Bool = true;
	public static var cvar_frustrumCulling_value:Int = 1;
	
	public static var svar_frame_rate:Float;
	public static var svar_framerate_avg_rate:Int = 60;
	public static var svar_gridsize:Int = 14;
	public static var svar_eraser_size:Int = 5;
	public static var svar_sim_running:Bool = false;
	public static var svar_game_mode:String = "edit";
	public static var svar_snap_distance:Int = 20;
	public static var svar_track_date_stamp:String = "";
	public static var svar_rider_count = 0;
	
	public static var stage_width:Float;
	public static var stage_height:Float;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//functions
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public static function get_angle_radians(_a:Point, _b:Point):Float
	{
		var _locAngle = Math.atan2(_b.y - _a.y, _b.x - _a.x);
		return (_locAngle);
	}
	public static function get_angle_degrees(_a:Point, _b:Point):Float
	{
		var _locAngle = Math.atan2(_b.y - _a.y, _b.x - _a.x) * 180 / Math.PI;
		return (_locAngle);
	}
	public static function get_point_vector(_dis:Int, _ang:Float):Point
	{
		var _loc1:Point = new Point((_dis * -1) * Math.cos(_ang), (_dis * -1) * Math.sin(_ang));
		return(_loc1);
	}
	public static function get_distance(_a:Point, _b:Point):Float 
	{
		return(Math.sqrt(Math.pow(_b.y - _a.y, 2) + Math.pow(_b.x - _a.x, 2)));
	}
	public static function get_distance_point(_a:Point, _b:Point):Point
	{
		var _loc1:Point = new Point(_b.y - _a.y, _b.x - _a.x);
		return(_loc1);
	}
	public static function gridPos(x:Float, y:Float):Object
	{
		var posObject:Object = new Object();
		posObject.x = Math.floor(x / Common.svar_gridsize);
		posObject.y = Math.floor(y / Common.svar_gridsize);
		posObject.gx = x - Common.svar_gridsize * posObject.x;
		posObject.gy = y - Common.svar_gridsize * posObject.y;
		return(posObject);
	}
	public static function time(_loc0:Int):String 
	{
		var _loc2:Int = _loc0;
		var _loc3:Int = Std.int(_loc2 / 40);
		var _loc8:Int = _loc2;
		var _loc7:Int = _loc3;
		var _loc6:Int = Std.int(_loc3 / 60);
		var _loc1:Int = _loc2 - _loc3 * 40;
		var _loc11:String = "";
		var _loc5:Int = _loc3 - _loc6 * 60;
		var _loc4:String = "";
		var _loc15:String = "";
		if (_loc2 < 40)
		{
			if (_loc2 < 10)
			{
				_loc4 = "0:0" + _loc2;
			}
			else
			{
				_loc4 = "0:" + _loc2;
			}
		}
		else if (_loc2 >= 40 && _loc3 < 60)
		{
			if (_loc1 < 10)
			{
				_loc11 = "0" + _loc1;
				_loc4 = _loc3 + ":" + _loc11;
			} else {
				_loc4 = _loc3 + ":" + _loc1;
			}
		}
		else if (_loc3 >= 60)
		{
			if (_loc1 < 10)
			{
				_loc11 = "0" + _loc1;
			} else {
				_loc11 = _loc1 + "";
			}
			if (_loc5 < 10)
			{
				_loc15 = "0" + _loc5;
			} else {
				_loc15 = _loc5 + "";
			}
			_loc4 = _loc6 + ":" + _loc15 + ":" + _loc11;
		}
		return (_loc4);
	}
	public static function font_vb_right(_size:Int):TextFormat {
		return(new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, _size, 0, null, null, null, null, null, TextFormatAlign.RIGHT));
	}
}