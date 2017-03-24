package file;

import file.ui.FileWindow;
import openfl.display.MovieClip;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import openfl.utils.Object;
import haxe.io.Bytes;
import lime.utils.compress.GZip;
import haxe.Utf8;
import lime.utils.compress.Zlib;
import ui.inter.AlertBox;

import global.Common;
import lr.line.*;
import ui.inter.SingleButton;
import lr.Toolbar;

/**
 * ...
 * @author ...
 */
class LoadManager 
{
	var trackData:Object;
	private var visBGMC:MovieClip;
	private var itemWindow:FileWindow;
	public var selected_item:String;
	private var load_button:SingleButton;
	private var cancel_button:SingleButton;
	private var error_alert:AlertBox;
	public function new() 
	{
		Common.gLoadManager = this;
	}
	public function displayTrackListVis() {
		this.visBGMC = new MovieClip();
		Common.gStage.addChild(this.visBGMC);
		this.visBGMC.graphics.clear();
		this.visBGMC.graphics.lineStyle(2, 0, 1);
		this.visBGMC.graphics.beginFill(0xFFFFFF, 1);
		this.visBGMC.graphics.moveTo(0, 0);
		this.visBGMC.graphics.lineTo(420, 0);
		this.visBGMC.graphics.lineTo(420, 420);
		this.visBGMC.graphics.lineTo(0, 420);
		this.visBGMC.graphics.lineTo(0, 0);
		
		this.parseSaveDirecotry();
		
		this.load_button = new SingleButton("Load Track", loadFromObject);
		this.visBGMC.addChild(this.load_button);
		this.load_button.x = 10;
		this.load_button.y = 430;
		
		this.cancel_button = new SingleButton("Cancel", Common.gCode.cancel_load);
		this.visBGMC.addChild(this.cancel_button);
		this.cancel_button.x = 300;
		this.cancel_button.y = 430;
	}
	function parseSaveDirecotry() {
		itemWindow = new FileWindow(FileSystem.readDirectory("saves/"));
		this.visBGMC.addChild(this.itemWindow);
		var _locDir = FileSystem.readDirectory("saves/");
		if (_locDir.length > 13) {
			this.visBGMC.graphics.beginFill(0xFFFFFF, 1);
			this.visBGMC.graphics.moveTo(10, 10);
			this.visBGMC.graphics.lineTo(390, 10);
			this.visBGMC.graphics.lineTo(390, 410);
			this.visBGMC.graphics.lineTo(10, 410);
			this.visBGMC.graphics.lineTo(10, 10);
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
		try {
			var _locFile = File.getContent("saves/" + _locPath);
			this.trackData = new Object();
			this.trackData = Json.parse(_locFile);
		} catch (_msg:String) {
			this.visBGMC.visible = false;
			this.error_alert = new AlertBox("Error! Are you sure that was a compatable JSON file?" + "\n" + "If it was, copy this error and provide a save if possible!" + "\n \n" + _msg, this.hide_error, "Silly Goose!");
			Common.gStage.addChild(this.error_alert);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
			return;
		}
		if (this.trackData.lines != null) {
			this.load_non_compressed();
		} else if (this.trackData.linesArrayCompressed != null) {
			this.load_compressed();
		} else {
			this.visBGMC.visible = false;
			this.error_alert = new AlertBox("Error! Failed to load the save!" + "\n" + "We're not exactly sure what the problem is. This might be an unsuported JSON save type, no line data contained in the file, or not a JSON at all. If you are old school, sorry to inform that SOL saves are currently unsupported.", this.hide_error, ":(");
			Common.gStage.addChild(this.error_alert);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
		}
	}
	
	function load_compressed() 
	{
		//insert LZ-String decompression code here
		this.visBGMC.visible = false;
		this.error_alert = new AlertBox("Error! This save type is currently unsupported!" + "\n" + "trackData.linesArrayCommpressed needs to be trackData.lines \n" + "Support for this save type is currently in dvelopment.", this.hide_error);
		Common.gStage.addChild(this.error_alert);
		this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
		this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
	}
	private function hide_error() {
		Common.gStage.removeChild(this.error_alert);
		this.visBGMC.visible = true;
	}
	function load_non_compressed() {
		this.trackData.lines.reverse();
		Common.track_start_x = this.trackData.startPosition.x;
		Common.track_start_y = this.trackData.startPosition.y;
		Common.gTrack.set_rider_start(this.trackData.startPosition.x, this.trackData.startPosition.y);
		Common.gCode.return_to_origin(this.trackData.startPosition.x, this.trackData.startPosition.y);
		for (i in 0...trackData.lines.length) {
			var _loc1:Dynamic;
			if (trackData.lines[i].type == 0) {
				_loc1 = new LineFloor(trackData.lines[i].x1, trackData.lines[i].y1, trackData.lines[i].x2, trackData.lines[i].y2, trackData.lines[i].flipped);
				Common.gTrack.add_vis_line(_loc1);
			} else if (trackData.lines[i].type == 1) {
				_loc1 = new LineAccel(trackData.lines[i].x1, trackData.lines[i].y1, trackData.lines[i].x2, trackData.lines[i].y2, trackData.lines[i].flipped);
				Common.gTrack.add_vis_line(_loc1);
			} else if (trackData.lines[i].type == 2) {
				_loc1 = new LineScene(trackData.lines[i].x1, trackData.lines[i].y1, trackData.lines[i].x2, trackData.lines[i].y2, trackData.lines[i].flipped);
				Common.gTrack.add_vis_line(_loc1);
			}
		}
		Common.gCode.cancel_load();
	}
	public function destroy_self() {
		Common.gStage.removeChild(this.visBGMC);
	}
}