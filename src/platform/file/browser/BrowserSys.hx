package platform.file.browser;

import lime.system.System;
import openfl.Lib;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
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
	var iconArray:Array<FileItemIcon>;
	
	var currentSelectedPath:String;
	
	public static var selected_item:FileItemIcon;
	
	public function new() 
	{
		super();
		
		Common.gSaveBrowser = this;
		
		this.add_title_interface();
		
		this.parseDirectory();
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
	function parseDirectory() 
	{
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
		this.iconArray = new Array<FileItemIcon>();
		if (Common.gTrack == null) this.iconArray.push(new FileItemIcon(0, FileType.New, "Key:NewTrack", "null"));
		else this.iconArray.push(new FileItemIcon(0, FileType.cancel, "Key:CancelLoad", "null"));
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
	function displayDirectory() {
		var x_offset = 0;
		var y_offset = 0;
		var x_max = Math.floor(Lib.current.stage.stageWidth / 120);
		for (a in this.iconArray) {
			this.addChild(a);
			a.x = 10 + (120 * x_offset);
			a.y = 90 + (140 * y_offset);
			++x_offset;
			if (x_offset >= x_max) {
				x_offset = 0;
				++y_offset;
			}
		}
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
	function init_env() 
	{
		if (Common.gTrack == null) Common.gCode.start();
		else Common.gTrack.clear_stage();
		Lib.current.stage.removeChild(this);
	}
	function invoke_loader() {
		if (Common.gTrack == null) Common.gCode.start();
		else Common.gTrack.clear_stage();
		Lib.current.stage.removeChild(this);
		Common.gRiderManager.set_single_rider_start(Common.track_start_x, Common.track_start_y);
		Common.gTrack.visible = true;
		Common.gToolbar.visible = true;
		Common.gTimeline.visible = true;
		
		#if (sys)
			this.fileLoader = new ImportSys();
			this.fileLoader.load(this.currentSelectedPath);
		#end
	}
	function update_directory() {
		
	}
	
}
class FileItemIcon extends Sprite
{
	var iconType:Int = -1;
	var pathToFile:String = "";
	var itemName:String;
	var itemNameField:TextField;
	var id:Int;
	var fileType:Int;
	var path:String;
	var icon:Sprite;
	var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 10, 0, null, null, null, null, null, TextFormatAlign.CENTER); 

	public function new(_id:Int, _type:Int, _name:String, _path:String) {
		super();
		
		this.id = _id;
		this.fileType = _type;
		this.itemName = _name;
		this.path = _path;
		
		this.attachClip();
		
		if (this.itemName == "Key:NewTrack" && this.path == "null") return;
		if (this.itemName == "Key:CancelLoad" && this.path == "null") return;
		this.itemNameField = new TextField();
		this.itemNameField.text = this.itemName;
		this.addChild(this.itemNameField); 
		this.itemNameField.selectable = false; 
		this.itemNameField.x = 50 - this.itemNameField.width / 2; 
		this.itemNameField.y = 110;
		this.itemNameField.defaultTextFormat = this.font_a; 
	}
	function attachClip() 
	{
		switch (this.fileType) {
			case FileType.unknown:
				this.icon = Common.OLR_Assets.getMovieClip("iconUNKNOWN");
			case FileType.New:
				this.icon = Common.OLR_Assets.getMovieClip("iconNew");
			case FileType.cancel :
				this.icon = Common.OLR_Assets.getMovieClip("iconCancel");
			case FileType.JSON:
				this.icon = Common.OLR_Assets.getMovieClip("iconJSON");
			case FileType.TRK:
				this.icon = Common.OLR_Assets.getMovieClip("iconTRK");
			case FileType.SOL:
				this.icon = Common.OLR_Assets.getMovieClip("iconSOL");
			case FileType.Directory:
				this.icon = Common.OLR_Assets.getMovieClip("iconDIR");
		}
		this.addChild(this.icon);
		this.icon.x = this.icon.y = 50;
		this.icon.addEventListener(MouseEvent.CLICK, this.single);
	}
	function single(e:MouseEvent):Void 
	{
		Common.gSaveBrowser.display_info(this.itemName, this.fileType, this.path);
	}
}