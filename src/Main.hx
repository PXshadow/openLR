package;

//Primary

#if (!flash)
	import openfl.utils.AssetLibrary;
	import openfl.display.Sprite;
#else
	import openfl.Assets;
	import flash.display.Sprite;
#end
#if sys
	import sys.FileSystem;
	import lime.system.System;
#end
import openfl.events.Event;
import openfl.display.FPS;
import openfl.geom.Point;
import openfl.Lib;
import platform.online.Dropbox;

//third party

//OLR
import global.Common;
import global.CVar;
import global.engine.RiderManager;
import global.SVar;
import lr.scene.TextInfo;
import lr.scene.Track;
import lr.menus.SettingsMenu;
import lr.tool.Toolbar;
import lr.tool.ToolBase;
import lr.scene.timeline.TimelineControl;
import platform.ControlBase;
import platform.control.KeyControl;
import platform.control.MouseControl;
import platform.file.ExportBase;
import platform.file.ImportBase;
import platform.file.BrowserBase;
#if sys
	import platform.file.browser.BrowserSys;
	import platform.file.exporting.ExportSys;
#elseif flash
	import platform.file.browser.BrowserFL;
#end

/**
 * ...
 * @author Kaelan Evans
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //OpenLR Project Release Alpha 0.0.5
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * This program was built using HaxeDevelop IDE, with haxe and openFL. Other libraries if used can be found in project.xml
 * 
 */

class Main extends Sprite 
{
	private var controlScheme:ControlBase;
	private var KeyboardControl:KeyControl;
	private var visContainer:Sprite;
	private var track:Track;
	private var riders:RiderManager;
	private var toolBar:Toolbar;
	private var textInfo:TextInfo;
	private var timeline:TimelineControl;
	private var settings_box:SettingsMenu;
	private var export:ExportBase;
	private var exportVisible:Bool = false;
	private var importing:ImportBase;
	private var importingVisible = false;
	private var newStartLoader:BrowserBase;
	private var dbx_manager:Dropbox;
	private var fps:FPS;
	
	public function new() 
	{
		super();
		
		this.fps = new FPS(5, 5);
		this.addChild(this.fps);
		
		#if (sys || js)
			#if sys
				this.init_paths();
			#end
		
			var load = AssetLibrary.loadFromFile("swf/assets.bundle");
			load.onComplete(this.launch);
		#elseif flash
			Assets.loadLibrary("olr_fl");
		
			this.launch();
		#end
	}
	#if (sys || js)
		function launch(lib:AssetLibrary = null) {
	#elseif flash
		function launch() {
	#end
		Common.gCode = this; //This class
		
		#if (sys || js)
			Common.OLR_Assets = lib;
		#end
		
		#if sys
			this.newStartLoader = new BrowserSys();
			this.newStartLoader.x = 0;
			this.newStartLoader.y = 0;
			
			//this.dbx_manager = new Dropbox();
		#elseif flash
			this.newStartLoader = new BrowserFL();
			this.newStartLoader.x = 0;
			this.newStartLoader.y = 0;
		#elseif js
			this.start();
		#end
	}
	public function start() {
		this.KeyboardControl = new KeyControl();
		this.init_env();
		this.init_track();
		this.visContainer.visible = true;
		this.controlScheme = new MouseControl();
		
		Lib.current.stage.application.onExit.add (function (exitCode) {
			//Autosave code here
		});
	}
	#if sys
		function init_paths() 
		{
			if (!FileSystem.isDirectory(System.documentsDirectory + "/openLR/")) FileSystem.createDirectory(System.documentsDirectory + "/openLR/");
		}
	#end
	function resize_title(e:Event):Void 
	{
		this.newStartLoader.render();
	}
	public function init_env() //Initialize enviornment
	{
		Lib.current.stage.addEventListener(Event.RESIZE, resize);
		
		Common.stage_height = Lib.current.stage.stageHeight;
		Common.stage_width = Lib.current.stage.stageWidth;
	}
	public function init_track() //display minimum items
	{
		this.visContainer = new Sprite();
		Lib.current.stage.addChild(visContainer);
		Common.gVisContainer = this.visContainer;
		
		this.track = new Track();
		this.visContainer.addChild(this.track);
		this.track.x = Lib.current.stage.stageWidth * 0.5;
		this.track.y = Lib.current.stage.stageHeight * 0.5;
		this.track.scaleX = this.track.scaleY = 2;
		
		this.riders = new RiderManager();
		this.riders.add_rider(2, 0, 0);
		this.visContainer.addChild(this.riders);
		this.riders.x = this.track.x;
		this.riders.y = this.track.y;
		this.riders.scaleX = this.riders.scaleY = this.track.scaleY;
		
		this.toolBar = new Toolbar();
		this.visContainer.addChild(this.toolBar);
		
		this.textInfo = new TextInfo();
		this.visContainer.addChild(this.textInfo);
		
		this.settings_box = new SettingsMenu();
		Lib.current.stage.addChild(this.settings_box);
		this.settings_box.visible = false;
		
		this.timeline = new TimelineControl();
		Lib.current.stage.addChild(this.timeline);
		this.timeline.update();
		
		this.visContainer.visible = false;
		
		this.align();
		
		SVar.game_mode = GameState.edit;
	}
	public function reset_timeline() {
		SVar.frames = 0;
		SVar.max_frames = 0;
		SVar.pause_frame = -1;
		SVar.slow_motion = false;
		CVar.slow_motion_rate = 5;
		Lib.current.stage.removeChild(this.timeline);
		this.timeline = new TimelineControl();
		Lib.current.stage.addChild(this.timeline);
		this.timeline.update();
		this.timeline.x = (Lib.current.stage.stageWidth * 0.5) - (640);
		this.timeline.y = Lib.current.stage.stageHeight - 45;
	}
	public function toggleSettings_box()
	{
		if (!this.settings_box.visible) {
			Toolbar.tool.set_tool("None");
			SVar.game_mode = GameState.inmenu;
			this.settings_box.visible = true;
			this.track.visible = false;
			this.toolBar.mouseChildren = false;
			this.textInfo.visible = false;
			this.timeline.visible = false;
			this.settings_box.update();
		} else {
			this.settings_box.visible = false;
			this.track.visible = true;
			this.toolBar.mouseChildren = true;
			this.textInfo.visible = true;
			this.timeline.visible = true;
			SVar.game_mode = GameState.edit;
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	public function toggle_save_menu() {
		if (this.exportVisible == false) {
			#if sys
				this.exportVisible = true;
				
				this.toolBar.mouseChildren = false;
				this.toolBar.mouseEnabled = false;
				this.timeline.mouseChildren = false;
				this.timeline.mouseEnabled = false;
				Lib.current.stage.mouseEnabled = false;
			
				this.export = new ExportSys();
				Lib.current.stage.addChild(this.export);
			
				this.align();
			
				Toolbar.tool.set_tool("None");
				SVar.game_mode = GameState.inmenu;
			#else
				return;
			#end
		} else {
			this.exportVisible = false;
			
			this.toolBar.mouseChildren = true;
			this.toolBar.mouseEnabled = true;
			this.timeline.mouseChildren = true;
			this.timeline.mouseEnabled = true;
			Lib.current.stage.mouseEnabled = true;
			
			Lib.current.stage.removeChild(this.export);
			
			this.align();
			
			SVar.game_mode = GameState.edit;
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	public function toggle_Loader() {
		if (this.importingVisible == false) {
			
			#if sys
				this.newStartLoader = new BrowserSys();
			#elseif flash
				this.newStartLoader = new BrowserFL();
			#end
			
			this.importingVisible = true;
			
			this.track.visible = false;
			this.toolBar.visible = false;
			this.timeline.visible = false;
			
			Lib.current.stage.addChild(this.newStartLoader);
			
			this.align();
			
			Toolbar.tool.set_tool("None");
			SVar.game_mode = GameState.inmenu;
		} else {
			this.importingVisible = false;
			
			this.track.visible = true;
			this.toolBar.visible = true;
			this.timeline.visible = true;
			
			Lib.current.stage.removeChild(this.newStartLoader);
			this.align();
			
			SVar.game_mode = GameState.edit;
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	private function resize(e:Event):Void
	{
		this.align();
	}
	public function align() {
		this.visContainer.x = this.visContainer.y = 0;
		
		this.toolBar.x = (Lib.current.stage.stageWidth / 2) - (128 * CVar.toolbar_scale);
		
		Common.stage_height = Lib.current.stage.stageHeight;
		Common.stage_width = Lib.current.stage.stageWidth;
		
		this.textInfo.x = (Lib.current.stage.stageWidth - this.textInfo.width) - 5;
		this.textInfo.y = 5;
		
		if (Common.gCamera != null) {
			Common.gCamera.update_pan_bounds();
		}
		
		this.settings_box.x = (Lib.current.stage.stageWidth * 0.5) - (this.settings_box.width * 0.5);
		this.settings_box.y = 100;
		
		this.timeline.x = (Lib.current.stage.stageWidth * 0.5) - (640);
		this.timeline.y = Lib.current.stage.stageHeight - 45;
		
		if (this.exportVisible) {
			this.export.x = (Lib.current.stage.stageWidth * 0.5) - (this.export.width * 0.5);
			this.export.y = (Lib.current.stage.stageHeight * 0.5) - (this.export.height * 0.5);
		}
		
		Common.stage_tl = new Point(0, 0);
		Common.stage_br = new Point(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		Common.gTrack.check_visibility();
	}
	public function setScale() {
		this.toolBar.scaleX = this.toolBar.scaleY = CVar.toolbar_scale;
	}
	public function return_to_origin(_x:Float = 0, _y:Float = 0) {
		this.track.x = Lib.current.stage.stageWidth * 0.5 - _x;
		this.track.y = Lib.current.stage.stageHeight * 0.5 - _y;
		this.track.scaleX = this.track.scaleY = 2;
	}
	public function return_to_origin_sim() {
		this.track.x = Lib.current.stage.stageWidth * 0.5;
		this.track.y = Lib.current.stage.stageHeight * 0.5;
	}
	public function take_screencap() {

	}
	public function end_screencap() {
		
	}
}