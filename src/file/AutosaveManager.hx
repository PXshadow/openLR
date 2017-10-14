package file;

import haxe.Timer;
import openfl.utils.Object;

#if (cpp)
	import sys.FileSystem;
	import sys.io.File;
	import haxe.Json;
#end

import global.Common;
import global.CVar;

/**
 * ...
 * @author Kaelan Evans
 */
class AutosaveManager 
{
	public static var interval:Int = 600000; //ten minutes
	private var timer:Timer;
	public function new() 
	{
		Common.gAutoSaveManager = this;
		this.timer = new Timer(interval);
		this.timer.run = function():Void {
			this.call_autosave();
		}
	}
	public function update_timer(_inter) {
		this.timer.stop();
		AutosaveManager.interval = _inter * 1000 * 60;
		this.timer = new Timer(interval);
		this.timer.run = function():Void {
			this.call_autosave();
		}
	}
	private function call_autosave() {
		#if (cpp)
		if (!CVar.auto_save) {
			return;
		}
		var stamp:String = CVar.track_name + "_auto_Y" + Date.now().getFullYear() + "M" + Date.now().getMonth() + "D" + Date.now().getDay() + "H" + Date.now().getHours() + "m" + Date.now().getMinutes();
		var track:Object = parse_json();
		var file = File.write("./autosaves/" + stamp + ".json", true);
		file.writeString(Json.stringify(track));
		file.close();
		#end
	}
	public function parse_json():Object
	{
		var _locArray = this.json_line_aray_parse();
		var _locSettings = this.json_settings_array();
		var json_object:Object = {
			"label": CVar.track_name,
			"creator": CVar.track_author,
			"description": CVar.author_comment,
			"version": "openLR",
			"startPosition": {
				"x": Common.track_start_x,
				"y": Common.track_start_y
			},
			"duration": 0,
			"lines": _locArray,
			"dateStamp": Date.now().getFullYear() + Date.now().getDate() + Date.now().getHours() + "",
			"OLRsettings": _locSettings,
			"Collab": false,
			"AuthorList": null
		}
		return(json_object);
	}
	
	function json_settings_array():Object
	{
		var settings:Object = new Object();
		
		settings.angle_snap = CVar.angle_snap;
		settings.line_snap = CVar.line_snap;
		settings.color_play = CVar.color_play;
		settings.preview_mode = CVar.preview_mode;
		settings.hit_test = CVar.hit_test;
		
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
			++line_ID_Override; //this ID override is important. During Beta 2 builds, this was found to completely prevent tracks from corrupting and being impossible to recover from
								//Adding this safety feature here to ensure this doesn't happen, even if corruption is unlikely.
		}
		return(a);
	}
}