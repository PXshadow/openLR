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
		var serial:String = Serializer.run(_locObject);
		
		trace(serial);
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