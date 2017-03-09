package file;

import openfl.utils.Object;
import openfl.geom.Point;
import haxe.io.Eof;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
import sys.io.FileInput;
import haxe.io.Bytes;

import global.Common;
import haxe.Serializer;
import haxe.Unserializer;
/**
 * ...
 * @author Kaelan Evans
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
		
		var file = File.append("./test_save.txt", true);
		file.writeString("openLR save;");
		file.writeString("VER;"); //Version
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
		file.writeInt32(trackData.d); //save line count twice in case TRK; occurs before line count
		
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