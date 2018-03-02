package platform.file.importing;

import openfl.utils.Object;
import openfl.Lib;
import sys.io.File;
import haxe.Json;

import ui.inter.TextButton;
import ui.inter.AlertBox;
import global.Common;
import platform.file.ImportBase;
import platform.file.fileType.*;

/**
 * ...
 * @author Kaelan Evans
 * 
 * 
 * 	var data:String='{"data":{"0":0,"1":1},"method":"test"}';
	var res = haxe.Json.parse(data);
	for (n in Reflect.fields(res.data))
    trace(Reflect.field(res.data, n));
 * 
 * 
 */
class ImportSys extends ImportBase 
{
	var rootDirectoryList:Array<String>;
	var subFolderDirectoryList:Map<String, Array<String>>;
	var subDirectory:String;
	var inSubDir:Bool = false;
	
	var loadButton:TextButton;
	
	var trackData:Object;
	var error_alert:AlertBox;
	public function new() 
	{
		super();
	}
	override public function load(_path:String = null) 
	{
		try {
			var file:FileBase;
			var _locStringA = _path.substring(_path.length - 5, _path.length);
			var _locStringB = _path.substring(_path.length - 4, _path.length);
			
			switch (_locStringA) {
				case ".json" :
					file = new FileJSON();
					this.trackData = new Object();
					this.trackData = Json.parse(File.getContent(_path));
					file.json_decode(this.trackData);
					return;
				case ".lrpk" :
					file = new LRPK();
					file.lrpk_decode(File.getBytes(_path));
					return;
				default :
					//intentional fall through
			}
			switch (_locStringB) {
				case ".sol" :
					return;
				case ".trk" :
					return;
				default :
					return;
			}
			
		} catch (_msg:String) {
			this.error_alert = new AlertBox("Error! Are you sure that was a valid file?" + "\n" + "If it was, copy this error and provide a save if possible!" + "\n \n" + _msg + "\n" + _path, this.hide_error, "Silly Goose!");
			Lib.current.stage.addChild(this.error_alert);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
			return;
		}
	}
	private function hide_error() {
		Lib.current.stage.removeChild(this.error_alert);
	}
}