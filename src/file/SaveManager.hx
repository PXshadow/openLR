package file;

import haxe.io.Eof;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
import sys.io.FileInput;
import haxe.io.Bytes;

import global.Common;
import haxe.Serializer;
/**
 * ...
 * @author Kaelan Evans
 */
class SaveManager
{
	var trackParse:TrackParse;
	var directory:File;
	public function new() 
	{
		Common.gSaveManager = this;
	}
	public function generateSave() {
		var _locObject = this.trackParse.parse();
		var serial = Serializer.run(_locObject);
	}
}