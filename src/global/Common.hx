package global;

import file.LoadManager;
import lr.Toolbar;
import lr.rider.RiderCamera;
import openfl.utils.Object;
import file.SaveManager;
import lr.TextInfo;
import lr.line.Grid;
import openfl.display.MovieClip;
import openfl.display.Stage;
import openfl.geom.Point;
import ui.tool.ToolBase;

import lr.Track;

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
	
	public static var version:String = "0.0.3";
	
	public static var gStage:Stage;
	public static var gCode:Main;
	public static var gTrack:Track;
	public static var gVisContainer:MovieClip;
	public static var gToolBase:ToolBase;
	public static var gToolCurrent:Any;
	public static var gGrid:Grid;
	public static var gSaveManager:SaveManager;
	public static var gLoadManager:LoadManager;
	public static var gSimManager:SimManager;
	public static var gTextInfo:TextInfo;
	public static var gToolbar:Toolbar;
	public static var gCamera:RiderCamera;
	
	public static var line_minLength:Int = 14;
	public static var line_type:Int = 0;
	
	public static var sLineCount:Int = 0;
	public static var sBLueLineCount:Int = 0;
	public static var sRedLineCount:Int = 0;
	public static var sGreenLineCount:Int = 0;
	public static var sLineID:Int = 0;
	
	public static var track_scale:Float;
	public static var track_scale_max:Float = 12;
	public static var track_scale_min:Float = 0.6;
	public static var track_start_x:Float = 0;
	public static var track_start_y:Float = 0;
	
	public static var sim_frames:Int = 0;
	public static var simfl_frames:Int = 0;
	public static var sim_rider_speed:Float = 0;
	public static var sim_rider_speed_top:Float = 0;
	
	public static var cvar_icon_hit_display:Bool = false;
	public static var cvar_line_render_mode:Int = 0; //0 = color, 1 = black, 2 = color play, 3 = preview
	public static var cvar_track_author:String = "Unknown";
	public static var cvar_track_name:String = "Untitled";
	public static var cvar_save_mode:String = "openLR"; //openLR will be the native file which will support theoretical features exclusive here, while the second option of JSON will be the bare minimum
	
	public static var svar_frame_rate:Float;
	public static var svar_framerate_avg_rate:Int = 60;
	public static var svar_gridsize:Int = 14;
	public static var svar_eraser_size:Int = 5;
	public static var svar_sim_running:Bool = false;
	public static var svar_game_mode:String = "edit";
	
	public static var stage_width:Float;
	public static var stage_height:Float;
	
	public static var cvar_author_comment:String = "This save was made in an alpha version of openLR.";
	
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
}