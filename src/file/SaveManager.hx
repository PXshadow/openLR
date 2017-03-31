package file;

import openfl.utils.Object;
import openfl.geom.Point;
import haxe.io.Eof;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
import sys.io.FileInput;
import haxe.Json;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 */
class SaveManager
{
	var directory:File;
	var trackData:Object;
	public function new() 
	{
		Common.gSaveManager = this;
	}
	public function generate_save_json() //Top function for generating JSON legacy file
	{
		var track:Object = parse_json();
		var time:String = Date.now().getDate() + "D_" + Date.now().getMonth() + "M_" + Date.now().getFullYear() + "Y_" + Date.now().getHours() + "h_" + Date.now().getMinutes() + "m_" + Date.now().getSeconds() + "s";
		var name:String = "alpha003_save_" + time;
		if (Common.cvar_track_name != "") {
			name = Common.cvar_track_name;
		}
		var file = File.write("./saves/" + name + ".json", true); //.json = legacy format
		file.writeString(Json.stringify(track));
		file.close();
	}
	public function parse_json():Object //top object. Gets name, author, etc.
	{
		var _locArray = this.json_line_aray_parse();
		var _locSettings = this.json_settings_array();
		var json_object:Object = {
			"label": Common.cvar_track_name,
			"creator": " ",
			"description": Common.cvar_author_comment,
			"version": "openLR",
			"startPosition": {
				"x": 0,
				"y": 0
			},
			"duration": 0,
			"lines": _locArray,
			"OLRsettings" : _locSettings
		}
		return(json_object);
	}
	
	function json_settings_array():Object
	{
		var settings:Object = new Object();
		
		settings.angle_snap = Common.cvar_angle_snap;
		settings.line_snap = Common.cvar_line_snap;
		settings.color_play = Common.cvar_color_play;
		settings.preview_mode = Common.cvar_preview_mode;
		settings.hit_test = Common.cvar_hit_test;
		
		return(settings);
	}
	private function json_line_aray_parse():Array<Object> //parses line array and organizes data
	{
		var lines = Common.gGrid.lines;
		lines.reverse();
		var a:Array<Object> = new Array();
		var line_ID_Override:Int = 0;
		for (i in 0...lines.length) {
			if (lines[i] == null) {
				continue;
			}
			trace(i);
			a[line_ID_Override] = new Object();
			a[line_ID_Override] = {
				"id": lines[i].ID,
				"type": lines[i].type,
				"x1": lines[i].x1,
				"y1": lines[i].y1,
				"x2": lines[i].x2,
				"y2": lines[i].y2,
				"flipped": lines[i].inv,
				"leftExtended": false,
				"rightExtended": false
			};
			++line_ID_Override;
		}
		return(a);
	}
}