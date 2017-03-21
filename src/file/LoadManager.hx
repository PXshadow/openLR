package file;

import file.ui.FileWindow;
import openfl.display.MovieClip;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import openfl.utils.Object;
import lr.line.*;

import global.Common;

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
		this.visBGMC.graphics.lineTo(400, 0);
		this.visBGMC.graphics.lineTo(400, 420);
		this.visBGMC.graphics.lineTo(0, 420);
		this.visBGMC.graphics.lineTo(0, 0);
		
		this.parseSaveDirecotry();
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
		trackData.lines.reverse();
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
	}
}