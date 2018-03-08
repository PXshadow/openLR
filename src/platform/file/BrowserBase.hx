package platform.file;

//Primary
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

//secondary
import global.Common;
#if sys
	import platform.file.importing.ImportSys;
#elseif flash
	import platform.file.importing.ImportFL;
#elseif js

#end
import ui.inter.TextButton;

//third party


/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract FileType(Int) from Int to Int {
	public var cancel:Int = -2;
	public var unknown:Int = -1;
	public var New:Int = 0;
	public var Directory:Int = 1;
	public var JSON:Int = 2;
	public var TRK:Int = 3;
	public var SOL:Int = 4;
	public var SOL6_2:Int = 5;
	public var SOL6_1:Int = 6;
	public var SOL6_0:Int = 7;
}
class BrowserBase extends Sprite
{
	var fileLoader:ImportBase;
	
	var load_file:TextButton;
	var open_dir:TextButton;
	var currentSelectedPath:String;
	
	var textField_title:TextField;
	var textField_versionInfo:TextField;
	
	var textField_fileName:TextField;
	var textField_filePath:TextField;
	
	var iconArray:Array<FileItemIcon>;
	var iconTray:Sprite;
	var iconMask:Sprite;
	
	var scrolling:Bool = false;
	
	private var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 24, 0, null, null, null, null, null, TextFormatAlign.LEFT); 
	private var font_b:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT); 
	
	public function new() {
		super();
		
		Common.gSaveBrowser = this;
		
		this.draw_title();
		
		this.render();
		
		Lib.current.stage.addChild(this);
		
		Lib.current.stage.addEventListener(Event.RESIZE, this.resize);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.scroll_list);
		
		this.add_title_interface();
		
		this.parseDirectory();
	}
	public function draw_title() {
		this.textField_title = new TextField(); 
		this.addChild(this.textField_title); 
		this.textField_title.selectable = false; 
		this.textField_title.x = this.textField_title.y = 5; 
		this.textField_title.defaultTextFormat = this.font_a; 
		this.textField_title.width = 160; 
		#if sys
			this.textField_title.text = "OpenLR\nC++";
		#elseif js
			this.textField_title.text = "OpenLR\nHTML5";
		#elseif flash
			#if air
				this.textField_title.text = "OpenLR\nAir";
			#else
				this.textField_title.text = "OpenLR\nFlash";
			#end
		#end
		this.textField_title.text += " " + Common.version;
		
		this.iconTray = new Sprite();
		this.addChild(this.iconTray);
		this.iconTray.y = 90;
		
		this.iconMask = new Sprite();
		this.addChild(this.iconMask);
		this.iconMask.y = 90;
		this.iconMask.mouseEnabled = false;
		
		this.iconTray.mask = this.iconMask;
	}
	public function add_title_interface() {
		this.load_file = new TextButton("Load", this.invoke_loader);
		this.addChild(this.load_file);
		this.load_file.x = 210;
		this.load_file.y = 5;
		this.load_file.visible = false;
		
		this.textField_fileName = new TextField();
		this.addChild(this.textField_fileName); 
		this.textField_fileName.selectable = false; 
		this.textField_fileName.x = 420; 
		this.textField_fileName.y = 15; 
		this.textField_fileName.defaultTextFormat = this.font_b; 
		this.textField_fileName.width = 500; 
		this.textField_fileName.text = ""; 
			
		this.textField_filePath = new TextField();
		this.addChild(this.textField_filePath); 
		this.textField_filePath.selectable = false; 
		this.textField_filePath.x = 420; 
		this.textField_filePath.y = 45; 
		this.textField_filePath.defaultTextFormat = this.font_b; 
		this.textField_filePath.width = 500; 
		this.textField_filePath.text = "";
	}
	public function render() {
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(Lib.current.stage.stageWidth, 0);
		this.graphics.lineTo(Lib.current.stage.stageWidth, 80);
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.lineTo(0, 80);
		
		this.iconMask.graphics.clear();
		this.iconMask.graphics.beginFill(0, 0.1);
		this.iconMask.graphics.moveTo(0, 0);
		this.iconMask.graphics.lineTo(Lib.current.stage.stageWidth, 0);
		this.iconMask.graphics.lineTo(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight - 80);
		this.iconMask.graphics.lineTo(0, Lib.current.stage.stageHeight - 80);
		this.iconMask.graphics.lineTo(0, 0);
	}
	public function resize(e:Event) {
		this.render();
	}
	function scroll_list(e:MouseEvent):Void 
	{
		if (!this.scrolling) return;
		
		var platDelta:Float;
			#if (cpp || flash)
				platDelta = e.delta;
			#elseif (js)
				platDelta = e.delta / 100;
			#else
				trace("Unsupported platform, accomodate: ", e.delta);
				return;
			#end
		if (platDelta > 0) {
			this.iconTray.y += 11;
			if (this.iconTray.y >= 90) {
				this.iconTray.y = 90;
			}
		}
		if (platDelta < 0) {
			this.iconTray.y -= 11;
			if (this.iconTray.y + this.iconTray.height <= Lib.current.stage.stageHeight - 15) {
				this.iconTray.y = Lib.current.stage.stageHeight - this.iconTray.height - 15;
			}
		}
	}
	public function display_info(_fileName:String, _fileType:Int, _filePath:String) {
		
	}
	public function parseDirectory() {
		this.iconArray = new Array<FileItemIcon>();
		if (Common.gTrack == null) this.iconArray.push(new FileItemIcon(0, FileType.New, "Key:NewTrack", "null"));
		else this.iconArray.push(new FileItemIcon(0, FileType.cancel, "Key:CancelLoad", "null"));
	}
	public function displayDirectory() {
		var x_offset = 0;
		var y_offset = 0;
		var x_max = Math.floor(Lib.current.stage.stageWidth / 120);
		for (a in this.iconArray) {
			this.iconTray.addChild(a);
			a.x = 10 + (120 * x_offset);
			a.y = 140 * y_offset;
			++x_offset;
			if (x_offset >= x_max) {
				x_offset = 0;
				++y_offset;
			}
		}
		if (this.iconTray.height + 80 > Lib.current.stage.stageHeight) { this.scrolling = true; }
		else {
			this.scrolling = false;
			this.iconTray.y = 90;
		}
	}
	public function init_env() 
	{
		if (Common.gTrack == null) Common.gCode.start();
		else Common.gTrack.clear_stage();
		Lib.current.stage.removeChild(this);
	}
	public function invoke_loader() {
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
		#elseif flash
			this.fileLoader = new ImportFL();
			this.fileLoader.load(this.currentSelectedPath);
		#end
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
		#if sys
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
				case FileType.SOL6_0:
					this.icon = Common.OLR_Assets.getMovieClip("iconSOL_6_0");
				case FileType.SOL6_1:
					this.icon = Common.OLR_Assets.getMovieClip("iconSOL_6_1");
				case FileType.SOL6_2:
					this.icon = Common.OLR_Assets.getMovieClip("iconSOL_6_2");
				case FileType.Directory:
					this.icon = Common.OLR_Assets.getMovieClip("iconDIR");
			}
		#elseif (flash || air)
			switch (this.fileType) {
				case FileType.unknown:
					this.icon = Assets.getMovieClip("swf-library:iconUNKNOWN");
				case FileType.New:
					this.icon = Assets.getMovieClip("swf-library:iconNew");
				case FileType.cancel :
					this.icon = Assets.getMovieClip("swf-library:iconCancel");
				case FileType.JSON:
					this.icon = Assets.getMovieClip("swf-library:iconJSON");
				case FileType.TRK:
					this.icon = Assets.getMovieClip("swf-library:iconTRK");
				case FileType.SOL:
					this.icon = Assets.getMovieClip("swf-library:iconSOL");
				case FileType.SOL6_0:
					this.icon = Assets.getMovieClip("swf-library:iconSOL_6_0");
				case FileType.SOL6_1:
					this.icon = Assets.getMovieClip("swf-library:iconSOL_6_1");
				case FileType.SOL6_2:
					this.icon = Assets.getMovieClip("swf-library:iconSOL_6_2");
				case FileType.Directory:
					this.icon = Assets.getMovieClip("swf-library:iconDIR");
			}
		#end
		this.addChild(this.icon);
		this.icon.x = this.icon.y = 50;
		this.icon.addEventListener(MouseEvent.CLICK, this.single);
	}
	function single(e:MouseEvent):Void 
	{
		Common.gSaveBrowser.display_info(this.itemName, this.fileType, this.path);
	}
}
	