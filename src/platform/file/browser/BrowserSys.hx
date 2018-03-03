package platform.file.browser;

import lime.system.System;
import openfl.Lib;
import openfl.events.Event;
import openfl.text.TextField;
import sys.FileSystem;

import platform.file.BrowserBase;
import platform.file.importing.ImportSys;
import ui.inter.TextButton;
import global.Common;

/**
 * ...
 * @author ...
 */
class BrowserSys extends BrowserBase
{
	var load_file:TextButton;
	var open_dir:TextButton;
	
	var rootDirectory:Array<String>;
	
	var currentSelectedPath:String;
	
	public static var selected_item:FileItemIcon;
	
	public function new() 
	{
		super();
	}
	override public function add_title_interface() 
	{
		this.load_file = new TextButton("Load", this.invoke_loader);
		this.addChild(this.load_file);
		this.load_file.x = 240;
		this.load_file.y = 5;
		this.load_file.visible = false;
		
		this.open_dir = new TextButton("Explore", this.invoke_loader);
		this.addChild(this.open_dir);
		this.open_dir.x = 240;
		this.open_dir.y = 40;
		this.open_dir.visible = false;
		
		this.textField_fileName = new TextField();
		this.addChild(this.textField_fileName); 
		this.textField_fileName.selectable = false; 
		this.textField_fileName.x = 330; 
		this.textField_fileName.y = 15; 
		this.textField_fileName.defaultTextFormat = this.font_b; 
		this.textField_fileName.width = 500; 
		this.textField_fileName.text = ""; 
			
		this.textField_filePath = new TextField();
		this.addChild(this.textField_filePath); 
		this.textField_filePath.selectable = false; 
		this.textField_filePath.x = 330; 
		this.textField_filePath.y = 45; 
		this.textField_filePath.defaultTextFormat = this.font_b; 
		this.textField_filePath.width = 500; 
		this.textField_filePath.text = "";
	}
	override public function display_info(_fileName:String, _fileType:Int, _filePath:String) {
		this.textField_fileName.text = _fileName;
		this.textField_filePath.text = _filePath;
		this.currentSelectedPath = _filePath;
		switch (_fileType) {
			case FileType.unknown :
				this.load_file.visible = true;
				this.open_dir.visible = false;
			case FileType.JSON :
				this.load_file.visible = true;
				this.open_dir.visible = false;
			case FileType.TRK :
				this.load_file.visible = true;
				this.open_dir.visible = false;
			case FileType.SOL :
				this.load_file.visible = true;
				this.open_dir.visible = false;
			case FileType.Directory :
				this.load_file.visible = true;
				this.open_dir.visible = true;
			case FileType.New :
				this.init_env();
			case FileType.cancel :
				Common.gCode.toggle_Loader();
		}
	}
	override public function parseDirectory() 
	{
		super.parseDirectory();
		
		var _locSaveDirectory:String = System.documentsDirectory + "/openLR/saves";
		if (!FileSystem.isDirectory(_locSaveDirectory) && Common.gTrack == null) {
			FileSystem.createDirectory(_locSaveDirectory);
			this.init_env();
			return;
		}
		this.rootDirectory = FileSystem.readDirectory(_locSaveDirectory);
		if (this.rootDirectory.length == 0 && Common.gTrack == null) {
			this.init_env();
			return;
		}
		this.rootDirectory.reverse();
		var itemCount:Int = 1;
		for (a in this.rootDirectory) {
			var b = _locSaveDirectory + "/" + a;
			if (FileSystem.isDirectory(_locSaveDirectory + "/" + a)) {
				this.iconArray.push(new FileItemIcon(itemCount, FileType.Directory, a, b));
			} else {
				var _locLength = a.length;
				var _locExtensionJSON:String = a.substring(_locLength - 5, _locLength);
				var _locExtensionSOLTRK:String = a.substring(_locLength - 4, _locLength);
				if (_locExtensionJSON == ".json") {
					this.iconArray.push(new FileItemIcon(itemCount, FileType.JSON, a, b));
				} else if (_locExtensionSOLTRK == ".trk") {
					this.iconArray.push(new FileItemIcon(itemCount, FileType.TRK, a, b));
				} else if (_locExtensionSOLTRK == ".sol") {
					this.iconArray.push(new FileItemIcon(itemCount, FileType.SOL, a, b));
				} else {
					this.iconArray.push(new FileItemIcon(itemCount, FileType.unknown, a, b));
				}
			}
			++itemCount;
		}
		this.displayDirectory();
	}
	override public function resize (e:Event) {
		
		super.resize(e);
		
		var x_offset = 0;
		var y_offset = 0;
		var x_max = Math.floor(Lib.current.stage.stageWidth / 120);
		for (a in this.iconArray) {
			a.x = 10 + (120 * x_offset);
			a.y = 90 + (140 * y_offset);
			++x_offset;
			if (x_offset >= x_max) {
				x_offset = 0;
				++y_offset;
			}
		}
	}
	function update_directory() {
		
	}
	
}