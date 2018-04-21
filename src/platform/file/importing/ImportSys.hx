package platform.file.importing;

import haxe.PosInfos;
import lime.system.System;
import openfl.utils.Object;
import openfl.Lib;
import openfl.events.MouseEvent;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

import ui.inter.TextButton;
import components.WindowBox;
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
	var error_alert:WindowBox;
	public function new() 
	{
		super();
	}
	override public function load(_path:String = null) 
	{
		try {
			var file:FileBase;
			var truePath = _path;
			
			if (FileSystem.isDirectory(_path)) {
				var tempList = FileSystem.readDirectory(_path);
				tempList.reverse();
				truePath = _path + "/" + tempList[0];
			}
			
			var _locStringA = truePath.substring(truePath.length - 5, truePath.length);
			var _locStringB = truePath.substring(truePath.length - 4, truePath.length);

			switch (_locStringA) {
				case ".json" :
					Common.gCode.set_load(true);
					file = new FileJSON();
					this.trackData = new Object();
					this.trackData = Json.parse(File.getContent(truePath));
					file.json_decode(this.trackData);
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
			this.error_alert = new WindowBox("Load error!", WindowMode.ERROR, 300, 250);
			Lib.current.stage.addChild(this.error_alert);
			this.error_alert.set_message_string("Are you sure that was a valid file?" + "\n" + "If it was, copy this error and provide a save if possible!" + "\n \n" + _msg + "\n" + _path, true);
			this.error_alert.frowny.addEventListener(MouseEvent.CLICK, this.hide_error);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
			return;
		}
	}
	private function hide_error(e:MouseEvent) {
		Lib.current.stage.removeChild(this.error_alert);
	}
}