package file;

import openfl.utils.Object;
import openfl.geom.Point;
import haxe.io.Eof;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
import sys.io.FileInput;

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
		var file = File.append("./saves/test_save_" + time + ".olrs", true); //.olrs = OpenLR Save.
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
		
		for (i in 0...trackData.d) {
			file.writeFloat(this.trackData.e[i].a.x);
			file.writeFloat(this.trackData.e[i].a.y);
			file.writeFloat(this.trackData.e[i].b.x);
			file.writeFloat(this.trackData.e[i].b.y);
			file.writeInt8(this.trackData.e[i].type);
			file.writeInt8(Std.int(this.trackData.e[i].inv));
			file.writeInt8(this.trackData.e[i].lim);
			file.writeInt32(this.trackData.e[i].ID);
		}
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
}