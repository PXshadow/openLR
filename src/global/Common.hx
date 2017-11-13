package global;

import openfl.Assets;
import openfl.utils.Object;
import openfl.display.Stage;
import openfl.geom.Point;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.display.Sprite;

import global.engine.RiderManager;
import global.engine.SimManager;
import lr.scene.Track;
import lr.tool.ToolBase;
import lr.scene.timeline.TimelineControl;
import lr.tool.Toolbar;
import lr.scene.TextInfo;
import lr.nodes.Grid;
import lr.rider.RiderCamera;
import platform.CoreBase;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract GameState(Int) from Int to Int {
	public var title:Int = 0;
	public var edit:Int = 1;
	public var playback:Int = 2;
	public var livedraw:Int = 3;
	public var inmenu:Int = 4;
}
class Common
{

	public function new() 
	{
		
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//variables
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public static var version:String = "0.0.5";
	
	public static var gCode:CoreBase;
	public static var gTrack:Track;
	public static var gRiderManager:RiderManager;
	public static var gVisContainer:Sprite;
	public static var gToolBase:ToolBase;
	public static var gToolCurrent:ToolBase;
	public static var gGrid:Grid;
	public static var gSimManager:SimManager;
	public static var gTextInfo:TextInfo;
	public static var gToolbar:Toolbar;
	public static var gCamera:RiderCamera;
	public static var gTimeline:TimelineControl;
	
	public static var line_minLength:Int = 14;
	public static var line_type:Int = 0;
	
	public static var track_scale:Float;
	public static var track_scale_max:Float = 75;
	public static var track_scale_min:Float = 0.5;
	public static var track_start_x:Float = 0;
	public static var track_start_y:Float = 0;
	public static var track_last_pos_x:Float = 0;
	public static var track_last_pos_y:Float = 0;
	
	public static var stage_width:Float;
	public static var stage_height:Float;
	public static var stage_tl:Point = new Point(0, 0);
	public static var stage_br:Point = new Point(0, 0);
	
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
		posObject.x = Math.floor(x / SVar.gridsize);
		posObject.y = Math.floor(y / SVar.gridsize);
		posObject.gx = x - SVar.gridsize * posObject.x;
		posObject.gy = y - SVar.gridsize * posObject.y;
		return(posObject);
	}
	public static function tilePos(x:Float, y:Float):Object
	{
		var posObject:Object = new Object();
		posObject.x = Math.floor(x / SVar.tilesize);
		posObject.y = Math.floor(y / SVar.tilesize);
		posObject.gx = x - SVar.tilesize * posObject.x;
		posObject.gy = y - SVar.tilesize * posObject.y;
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