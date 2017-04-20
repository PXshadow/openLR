package file;

import file.ui.FileWindow;
import openfl.display.MovieClip;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import openfl.utils.Object;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.Utf8;
import ui.inter.AlertBox;

import global.Common;
import lr.line.*;
import ui.inter.SingleButton;
import ui.tool.Toolbar;
//import src.com.LZString;

/**
 * ...
 * @author ...
 */
class LoadManager extends MovieClip
{
	var trackData:Object;
	private var itemWindow:FileWindow;
	public var selected_item:String;
	private var load_button:SingleButton;
	private var cancel_button:SingleButton;
	private var error_alert:AlertBox;
	public function new() 
	{
		super();
		Common.gLoadManager = this;
		
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(420, 0);
		this.graphics.lineTo(420, 420);
		this.graphics.lineTo(0, 420);
		this.graphics.lineTo(0, 0);
		
		this.parseSaveDirecotry();
		
		this.load_button = new SingleButton("Load Track", loadFromObject);
		this.addChild(this.load_button);
		this.load_button.x = 10;
		this.load_button.y = 430;
		
		this.cancel_button = new SingleButton("Cancel", Common.gCode.toggle_Loader);
		this.addChild(this.cancel_button);
		this.cancel_button.x = 300;
		this.cancel_button.y = 430;
	}
	function parseSaveDirecotry() {
		itemWindow = new FileWindow(FileSystem.readDirectory("saves/"));
		this.addChild(this.itemWindow);
		var _locDir = FileSystem.readDirectory("saves/");
		if (_locDir.length > 13) {
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.moveTo(10, 10);
			this.graphics.lineTo(390, 10);
			this.graphics.lineTo(390, 410);
			this.graphics.lineTo(10, 410);
			this.graphics.lineTo(10, 10);
		}
	}
	function loadFromArray() 
	{
		trace("Save not supported!");
	}
	
	function loadFromObject() 
	{
		if (FileWindow.selectedIndex != -1) {
			Common.gTrack.clear_stage();
			this.invoke_loader();
		}
	}
	
	function invoke_loader() 
	{
		var _locPath = this.itemWindow.currentList[FileWindow.selectedIndex];
		var _locExt = _locPath.substr(_locPath.length - 5, _locPath.length);
		if (_locExt == ".json") {
			this.pre_json_detect();
		}
		_locExt = _locPath.substr(_locPath.length - 4, _locPath.length); 
		if (_locExt == ".sol") {
			//this.parse_sol();
		}
	}
	function pre_json_detect() {
		var _locPath = this.itemWindow.currentList[FileWindow.selectedIndex];
		try {
			var _locFile = File.getContent("saves/" + _locPath);
			this.trackData = new Object();
			this.trackData = Json.parse(_locFile);
		} catch (_msg:String) {
			this.visible = false;
			this.error_alert = new AlertBox("Error! Are you sure that was a compatable JSON file?" + "\n" + "If it was, copy this error and provide a save if possible!" + "\n \n" + _msg + "\n" + this.itemWindow.currentList[FileWindow.selectedIndex], this.hide_error, "Silly Goose!");
			Common.gStage.addChild(this.error_alert);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
			return;
		}
		if (this.trackData.lines != null) {
			this.load_non_compressed();
		} else if (this.trackData.linesArrayCompressed != null) {
			this.load_compressed();
		} else if (this.trackData.linesArray != null){
			this.load_array();
		} else {
			this.visible = false;
			this.error_alert = new AlertBox("Error! Failed to load the save!" + "\n" + "Are you sure this was a save made in a compatible line rider version? If so, please send a copy to the developers so they may inspect it", this.hide_error, ":(");
			Common.gStage.addChild(this.error_alert);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
		}
	}
	
	function load_array() 
	{
		SaveManager.new_track = false;
		Common.cvar_author_comment = this.trackData.description;
		Common.svar_track_date_stamp = this.trackData.dateStamp;
		Common.cvar_track_name = this.trackData.label;
		Common.track_start_x = this.trackData.startPosition.x;
		Common.track_start_y = this.trackData.startPosition.y;
		Common.gTrack.set_rider_start(this.trackData.startPosition.x, this.trackData.startPosition.y);
		Common.gCode.return_to_origin(this.trackData.startPosition.x, this.trackData.startPosition.y);
		this.trackData.linesArray.reverse();
		for (i in 0...trackData.linesArray.length) {
			var _loc1:Dynamic;
			if (trackData.linesArray[i][0] == 0) {
				_loc1 = new LineFloor(trackData.linesArray[i][2], trackData.linesArray[i][3], trackData.linesArray[i][4], trackData.linesArray[i][5], trackData.linesArray[i][7]);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (trackData.linesArray[i][0] == 1) {
				_loc1 = new LineAccel(trackData.linesArray[i][2], trackData.linesArray[i][3], trackData.linesArray[i][4], trackData.linesArray[i][5], trackData.linesArray[i][7]);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (trackData.linesArray[i][0] == 2) {
				_loc1 = new LineScene(trackData.linesArray[i][2], trackData.linesArray[i][3], trackData.linesArray[i][4], trackData.linesArray[i][5], trackData.linesArray[i][7]);
				_loc1.ID = Common.sLineID;
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			}
			Common.sLineID += 1;
		}
		Common.gCode.toggle_Loader();
	}
	function load_compressed() 
	{
		//insert LZ-String decompression code here
		this.error_alert = new AlertBox("Error! A small discrepancy is making this save difficult." + "\n" + "\"linesArrayCommpressed\"" + "\n" + "needs to be \"lines\"" +  "\n \n" + "Save type unsupported... for now.", this.hide_error, "D:<");
		Common.gStage.addChild(this.error_alert);
		this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
		this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
	}
	private function hide_error() {
		Common.gStage.removeChild(this.error_alert);
		this.visible = true;
	}
	function load_non_compressed() {
		SaveManager.new_track = false;
		Common.cvar_author_comment = this.trackData.description;
		Common.svar_track_date_stamp = this.trackData.dateStamp;
		Common.cvar_track_name = this.trackData.label;
		Common.track_start_x = this.trackData.startPosition.x;
		Common.track_start_y = this.trackData.startPosition.y;
		Common.gTrack.set_rider_start(this.trackData.startPosition.x, this.trackData.startPosition.y);
		Common.gCode.return_to_origin(this.trackData.startPosition.x, this.trackData.startPosition.y);
		this.trackData.lines.reverse();
		for (i in 0...trackData.lines.length) {
			var _loc1:LineBase;
			if (trackData.lines[i].type == 0) {
				_loc1 = new LineFloor(trackData.lines[i].x1, trackData.lines[i].y1, trackData.lines[i].x2, trackData.lines[i].y2, trackData.lines[i].flipped);
				_loc1.ID = Common.sLineID;
				_loc1.set_lim(this.get_lim_to_set(trackData.lines[i].leftExtended, trackData.lines[i].rightExtended));
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (trackData.lines[i].type == 1) {
				_loc1 = new LineAccel(trackData.lines[i].x1, trackData.lines[i].y1, trackData.lines[i].x2, trackData.lines[i].y2, trackData.lines[i].flipped);
				_loc1.ID = Common.sLineID;
				_loc1.set_lim(this.get_lim_to_set(trackData.lines[i].leftExtended, trackData.lines[i].rightExtended));
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			} else if (trackData.lines[i].type == 2) {
				_loc1 = new LineScene(trackData.lines[i].x1, trackData.lines[i].y1, trackData.lines[i].x2, trackData.lines[i].y2, trackData.lines[i].flipped);
				_loc1.ID = Common.sLineID;
				_loc1.set_lim(this.get_lim_to_set(trackData.lines[i].leftExtended, trackData.lines[i].rightExtended));
				Common.gTrack.add_vis_line(_loc1);
				Common.gGrid.cache_stroke([_loc1]);
			}
			Common.sLineID += 1;
		}
		Common.gCode.toggle_Loader();
	}
	public function get_lim_to_set(l:Bool, r:Bool):Int {
		trace(l, r);
		if (!l && !r) {
			return(0);
		} else if (l && !r) {
			return(1);
		} else if (!l && r) {
			return(2);
		} else if (l && r) {
			return(3);
		} else {
			return(0);
		}
	}
	public function update() {
		this.removeChild(this.itemWindow);
		this.parseSaveDirecotry();
	}
}