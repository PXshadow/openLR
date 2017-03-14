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
 * This save system should be set up to allow data blocks to be arbitrarily loaded as read. This should, in theory, allow for future and backwards compatability, and prevent issues 
 * if data is missing entirely. IE It does not need an authors name to load a track. Future versions will include a pop up in case crucial data is missing, such as start position,
 * flagged frame but no position, etcetera.
 * 
 * Data blocks will start with a string that will be three characters, followed by a semi-colon. IE the lines data block will start with the string "TRK;"
 * At the end of the block, the ending string will be "E;" This will tell the parser (when made) to check for the next tag so it can switch.
 * The final end of the save data will be marked with "EOS;" (end of save). After this point, an authors comments can be added, and debug information will follow if needed.
 * 
 * The JSON format will be added for legacy saving. This will allow cross support for other versions that support it as well. However as a downside, it will not support exclusive features.
 * This is not to imply that I am excluding them, but it's to act as a measurement to make sure nothing in the save would conflict with other versions. Heavily consider saving under
 * this format for collab purposes if a build is not settled on. If other builds implement features originally exclusive, I'll tack them into the JSON legavy parser.
 * 
 * At the moment, SOL/AMF support will not be implemented. We've moved on people, some time in the distant future I'll add it after overlooking the parsing code Conun and Mhenr have. 
 * Until Beta release, this will also use JSON as default to maintain testing purposes. Once the project is ready to start using newer features that may need special save data, 
 * focus will be put towards this arbitrary save format file. This may be another fancy JSON format for other builds, but I do not expect this format to work with other builds
 * and have no plans to make sure they do work.
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
	public function generateSave() {
		var _locObject = this.parse();
		var time:String = Date.now().getDate() + "_" + Date.now().getMonth() + "_" + Date.now().getFullYear() + "_" + Date.now().getHours() + "_" + Date.now().getMinutes();
		var file = File.write("./saves/test_save_" + time + ".olrs", true); //.olrs = OpenLR Save.
		file.writeString("openLR save;");
		file.writeString("VER;"); //Version track was saved in
		file.writeString(trackData.a);
		file.writeString("E;"); //Marker to indicate end of data in case version does not support save data.
		file.writeString("AUT;"); //Author
		file.writeInt32(trackData.b.length);
		file.writeString(trackData.b);
		file.writeString("E;");
		file.writeString("DTS;"); //Date Track Saved
		file.writeInt32(trackData.c.length);
		file.writeString(trackData.c);
		file.writeString("LCT;"); //Line Count Total
		file.writeInt32(trackData.d);
		file.writeString("E;");
		file.writeString("TRK;");
		file.writeInt32(trackData.d); //save line count here in case "TRK;" occurs before line count
		file.writeInt32(Json.stringify(trackData.e).length); //string length
		file.writeString(Json.stringify(trackData.e)); //objects converted to string. Maintain some resemblance to .com's saves. Might convert the rest of it into this format.
		file.writeString("E;");
		file.writeString("EOS;"); //End of save
		file.writeString("\r\n");
		file.writeString("\r\n");
		file.writeString("\r\n" + Common.cvar_author_comment);
		file.writeString("\r\n");
		file.writeString("\r\n");
		file.writeString("the following are debug values:");
		file.writeString("\r\n" + "Version: " + Common.version);
		file.writeString("\r\n" + "Stage Dimensions: " + Common.stage_width + ", " + Common.stage_height);
		file.writeString("\r\n" + "Line Count: " + Common.sLineCount + ", " + Common.sBLueLineCount + ", " + Common.sRedLineCount + ", " + Common.sGreenLineCount + ", ");
		file.writeString("\r\n" + "Line ID: " + Common.sLineID);
		file.writeString("\r\n" + "Render: " + Common.cvar_line_render_mode);
		file.writeString("\r\n" + "track info: Scale " + Common.track_scale + ", Position " + Common.gTrack.x + ", " + Common.gTrack.y);
		file.writeString("\r\n");
		file.close(); //this is important, otherwise the file is held hostage by the program until it closes
	}
	public function parse():Object //runs through track and organizes data similar to beta 2
	{
		var lines = Common.gGrid.lines;
		trackData = new Object();
		
		this.trackData = new Object();
		this.trackData.a = Common.version;
		this.trackData.b = Common.cvar_track_author;
		this.trackData.c = Date.now();
		this.trackData.d = lines.length;
		this.trackData.e = new Array<Object>();
		
		for (i in 0...lines.length) {
			this.trackData.e[i] = new Object();
			this.trackData.e[i].a = lines[i].a; 
			this.trackData.e[i].b = lines[i].b; 
			this.trackData.e[i].type = lines[i].type; 
			this.trackData.e[i].inv = lines[i].inv;
			this.trackData.e[i].lim = lines[i]._lim;
			this.trackData.e[i].ID = lines[i].ID;
		}
		
		return(this.trackData);
	}
	public function generate_save_json() //Top function for generating JSON legacy file
	{
		var track:Object = parse_json();
		var time:String = Date.now().getDate() + "_" + Date.now().getMonth() + "_" + Date.now().getFullYear() + "_" + Date.now().getHours() + "_" + Date.now().getMinutes();
		var file = File.write("./saves/test_save_" + time + ".json", true); //.json = legacy format
		file.writeString(Json.stringify(track));
		file.close();
	}
	public function parse_json():Object //top object. Gets name, author, etc.
	{
		var _locArray = this.json_line_aray_parse();
		var json_object:Object = {
			"label": "test_track",
			"creator": " ",
			"description": Common.cvar_author_comment,
			"version": "openLR",
			"startPosition": {
				"x": 0,
				"y": 0
			},
			"duration": 0,
			"lines": _locArray
		}
		return(json_object);
	}
	private function json_line_aray_parse():Array<Object> //parses line array and organizes data
	{
		var lines = Common.gGrid.lines;
		var a:Array<Object> = new Array();
		for (i in 0...lines.length) {
			a[i] = new Object();
			a[i] = {
				"id": lines[i].ID,
				"type": lines[i].type,
				"x1": lines[i].x1,
				"y1": lines[i].y1,
				"x2": lines[i].x2,
				"y2": lines[i].y2,
				"flipped": lines[i].inv,
				"leftExtended": false,
				"rightExtended": false
			}
		}
		return(a);
	}
}