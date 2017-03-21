package file;

import sys.io.File;
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
	public function new() 
	{
		Common.gLoadMaganer = this;
	}
	public function browse() {
		trace("init loading");
		var file = File.getContent("saves/Sleepyhead.json");
		trackData = Json.parse(file);
		
		Common.gTrack.set_rider_start(trackData.startPosition.x, trackData.startPosition.y);
		Common.track_start_x = trackData.startPosition.x;
		Common.track_start_y = trackData.startPosition.y;
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