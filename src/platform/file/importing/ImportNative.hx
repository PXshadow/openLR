package platform.file.importing;

import openfl.utils.Object;
import openfl.Lib;
import sys.FileSystem;
import sys.io.File;
import lime.system.System;
import haxe.Json;

import ui.inter.FileWindow;
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
class ImportNative extends ImportBase 
{
	var rootDirectoryList:Array<String>;
	var subFolderDirectoryList:Map<String, Array<String>>;
	var subDirectory:String;
	var inSubDir:Bool = false;
	
	var loadButton:TextButton;
	
	var itemWindow:FileWindow;
	
	var trackData:Object;
	var error_alert:AlertBox;
	public function new() 
	{
		super();
	}
	override public function load(_path:String = null) 
	{
		var path:String;
		if (_path != null) {
			path = _path;
			if (FileSystem.isDirectory(_path)) {
				var tempArray = FileSystem.readDirectory(path);
				path = _path + "/" + tempArray.pop();
			}
		} else if (this.inSubDir) {
			path = System.documentsDirectory + "/openLR/saves/" + this.subDirectory + "/" + this.subFolderDirectoryList[this.subDirectory][FileWindow.selectedIndex];
		} else {
			if (FileSystem.isDirectory(System.documentsDirectory + "/openLR/saves/" + this.rootDirectoryList[FileWindow.selectedIndex])) {
				var tempArray = FileSystem.readDirectory(System.documentsDirectory + "/openLR/saves/" + this.rootDirectoryList[FileWindow.selectedIndex]);
				path = System.documentsDirectory + "/openLR/saves/" + this.rootDirectoryList[FileWindow.selectedIndex] + "/" + tempArray.pop();
			} else {
				path = System.documentsDirectory + "/openLR/saves/" + this.rootDirectoryList[FileWindow.selectedIndex];
			}
		}
		try {
			var file:FileBase;
			var _locStringA = path.substring(path.length - 5, path.length);
			var _locStringB = path.substring(path.length - 4, path.length);
			
			switch (_locStringA) {
				case ".json" :
					file = new FileJSON();
					this.trackData = new Object();
					this.trackData = Json.parse(File.getContent(path));
					file.json_decode(this.trackData);
					return;
				case ".lrpk" :
					file = new LRPK();
					file.lrpk_decode(File.getBytes(path));
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
			this.visible = false;
			this.error_alert = new AlertBox("Error! Are you sure that was a valid file?" + "\n" + "If it was, copy this error and provide a save if possible!" + "\n \n" + _msg + "\n" + this.itemWindow.currentList[FileWindow.selectedIndex], this.hide_error, "Silly Goose!");
			Lib.current.stage.addChild(this.error_alert);
			this.error_alert.x = (Common.stage_width * 0.5) - (this.error_alert.width * 0.5);
			this.error_alert.y = (Common.stage_height * 0.5) - (this.error_alert.height * 0.5);
			return;
		}
	}
	private function hide_error() {
		Lib.current.stage.removeChild(this.error_alert);
		this.visible = true;
	}
}