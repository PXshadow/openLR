package;

//Primary
import openfl.display.Loader;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import openfl.net.URLRequest;
import haxe.Timer;
import ui.inter.AlertBox;
import ui.inter.CheckBox;
import ui.tool.timeline.Ticker;
import ui.tool.timeline.TimelineControl;
import openfl.Lib;
import openfl.Assets;

//third party

//openLR
import file.FileStart;
import file.LoadManager;
import global.Common;
import global.Language;
import ui.inter.SingleButton;
import file.SaveManager;
import global.FrameRate;
import global.SimManager;
import lr.TextInfo;
import ui.tool.Toolbar;
import lr.Track;
import file.AutosaveManager;
import file.Screenshot;
import lr.settings.SettingsMenu;
import global.RiderManager;

//TBD
import file.HXLZString;

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
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //Known issues to work around
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 *  --Performance drop when too many lines are in memory and track has to pan. This seems to only occur during the simulation, but isn't a problem with the sim itself
 * 		-Two fold solution
 * 			-Better frustum culling. Current method tries to toggle visibility per line, need to toggle visibility per node.
 * 			-Better camera system. Current method is like pushing a piece of paper around.
 *  --Saving track causes physics to break. Once saved, problem is irreversable, but only happens once. Unknown what the cause is. Need to double check on loading and saving.
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //Notes
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * --Need to clean up some of the "rabbit hole" functions. Starting to get lost in my own code.
 * --Need to make some UI classes. Check boxes, radio buttons, lists.
 * 		-OpenFL broke mouse collisions regarding sprites that use vector graphics. Need to incorperate button class.
 * --Need to work on defaults for settings. Alpha 0.0.4 will probably be that
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //To do
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * -- LZ-String port, this is needed if compatibility with .com must happen
 * -- UI system. Menus, checkboxes, radio buttons, arbitrarily sized buttons, fonts, blah blah blah
 * -- Better file management. Save with name support, save as (arbitrary location), load from saves folder, and browse. Look into Lime API.
 * 
 */
class Main extends Sprite 
{
	private var mainFileInit:FileStart; //this class controls settings
	private var visContainer:MovieClip; //simple display container. This will make it easier to take screenshots and record video without having to move a matrix all around
	private var track:Track;
	private var riders:RiderManager;
	private var toolBar:Toolbar;
	private var textInfo:TextInfo;
	private var FPS:FrameRate;
	private var welcome_alert:AlertBox;
	private var save_manager:SaveManager;
	private var timeline:TimelineControl;
	
	private var loadManager:LoadManager;
	
	private var settings_box:SettingsMenu;
	
	private var autosave:AutosaveManager;
	
	public var unique_id:String; 
	
	public function new() 
	{
		super(); //In Haxe, a super must be called when classes inherit
		
		this.mainFileInit = new FileStart(); //checks for default folders and saved settings in the track
		
		this.welcome_alert = new AlertBox(Language.Welcome + "\n" + "\n" + "Version: " + Common.version, this.start, Language.Continue);
		this.addChild(this.welcome_alert);
		this.welcome_alert.x = (this.stage.stageWidth * 0.5) - (this.welcome_alert.width * 0.5);
		this.welcome_alert.y = (this.stage.stageHeight * 0.5) - (this.welcome_alert.height * 0.5);
		
		//trace(HXLZString.compress("Hello, my name is Kevansevans"));
	}
	function start() {
		this.init_env();
		this.init_track();
		this.removeChild(this.welcome_alert);
		this.visContainer.visible = true;
	}
	public function init_env() //Initialize enviornment
	{
		this.stage.addEventListener(Event.RESIZE, resize);
		
		Common.gCode = this; //This class
		Common.gStage = this.stage; //The stage, not to be comfused with main.hx
		
		Common.stage_height = this.stage.stageHeight;
		Common.stage_width = this.stage.stageWidth;
		
		this.FPS = new FrameRate();
		
		this.autosave = new AutosaveManager();
	}
	
	public function init_track() //display minimum items
	{
		this.visContainer = new MovieClip();
		this.addChild(visContainer);
		Common.gVisContainer = this.visContainer;
		
		this.track = new Track();
		this.visContainer.addChild(this.track);
		this.track.x = this.stage.stageWidth * 0.5;
		this.track.y = this.stage.stageHeight * 0.5;
		this.track.scaleX = this.track.scaleY = 2;
		
		this.riders = new RiderManager();
		this.visContainer.addChild(this.riders);
		this.riders.x = this.track.x;
		this.riders.y = this.track.y;
		this.riders.scaleX = this.riders.scaleY = this.track.scaleY;
		
		this.toolBar = new Toolbar();
		this.visContainer.addChild(this.toolBar);
		
		this.textInfo = new TextInfo();
		this.visContainer.addChild(this.textInfo);
		
		this.settings_box = new SettingsMenu();
		this.visContainer.addChild(this.settings_box);
		this.settings_box.visible = false;
		
		this.loadManager = new LoadManager();
		this.addChild(this.loadManager);
		this.loadManager.visible = false;
		
		this.save_manager = new SaveManager();
		this.visContainer.addChild(this.save_manager);
		this.save_manager.visible = false;
		
		this.timeline = new TimelineControl();
		this.visContainer.addChild(this.timeline);
		this.timeline.update();
		
		this.visContainer.visible = false;
		
		this.align();
	}
	public function reset_timeline() {
		Common.sim_frames = 0;
		Common.sim_max_frames = 0;
		Common.sim_pause_frame = -1;
		Common.sim_slow_motion = false;
		Common.sim_slow_motion_rate = 5;
		this.visContainer.removeChild(this.timeline);
		this.timeline = new TimelineControl();
		this.visContainer.addChild(this.timeline);
		this.timeline.update();
		this.timeline.x = (this.stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = this.stage.stageHeight - this.timeline.height + 25;
	}
	public function toggleSettings_box()
	{
		if (!this.settings_box.visible) {
			Common.svar_game_mode = "settings";
			this.settings_box.visible = true;
			this.track.visible = false;
			this.toolBar.visible = false;
			this.textInfo.visible = false;
			this.timeline.visible = false;
			this.settings_box.update();
		} else {
			this.mainFileInit.write_new_settings();
			this.mainFileInit.write_new_keys();
			this.settings_box.visible = false;
			this.track.visible = true;
			this.toolBar.visible = true;
			this.textInfo.visible = true;
			this.timeline.visible = true;
			Common.svar_game_mode = "edit";
			Common.gToolBase.enable();
		}
	}
	public function toggle_save_menu() {
		if (this.save_manager.visible != true) {
			Common.svar_game_mode = "saving";
			this.save_manager.update();
			this.save_manager.visible = true;
			this.track.visible = false;
			this.toolBar.visible = false;
			this.textInfo.visible = false;
			this.timeline.visible = false;
		} else {
			this.save_manager.visible = false;
			this.track.visible = true;
			this.toolBar.visible = true;
			this.textInfo.visible = true;
			this.timeline.visible = true;
			Common.svar_game_mode = "edit";
			Common.gToolBase.enable();
		}
	}
	public function toggle_Loader() {
		if (!this.loadManager.visible) {
			Common.svar_game_mode = "loader";
			this.loadManager.visible = true;
			this.loadManager.update();
			this.track.visible = false;
			this.toolBar.visible = false;
			this.textInfo.visible = false;
			this.timeline.visible = false;
		} else {
			this.loadManager.visible = false;
			this.track.visible = true;
			this.toolBar.visible = true;
			this.textInfo.visible = true;
			this.timeline.visible = true;
			Common.svar_game_mode = "edit";
			Common.gToolBase.enable();
		}
	}
	private function resize(e:Event):Void
	{
		this.visContainer.x = this.visContainer.y = 0;
		this.toolBar.x = (this.stage.stageWidth * 0.5) - (this.toolBar.width * 0.25); 
		
		Common.stage_height = this.stage.stageHeight;
		Common.stage_width = this.stage.stageWidth;
		
		this.textInfo.x = (this.stage.stageWidth - this.textInfo.width) - 5;
		this.textInfo.y = 5;
		
		if (Common.gCamera != null) {
			Common.gCamera.update_pan_bounds();
		}
		
		this.save_manager.x = (this.stage.stageWidth * 0.5) - (this.save_manager.width * 0.5);
		this.save_manager.y = (this.stage.stageHeight * 0.5) - (this.save_manager.height * 0.5);
		
		this.settings_box.x = (this.stage.stageWidth * 0.5) - (this.settings_box.width * 0.5);
		this.settings_box.y = (this.stage.stageHeight * 0.5) - (this.settings_box.height * 0.5);
		
		this.loadManager.x = (this.stage.stageWidth * 0.5) - (this.loadManager.width * 0.5);
		this.loadManager.y = (this.stage.stageHeight * 0.5) - 300;
		
		this.timeline.x = (this.stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = this.stage.stageHeight - this.timeline.height + 25;
	}
	public function align() {
		this.visContainer.x = this.visContainer.y = 0;
		this.toolBar.x = (this.stage.stageWidth * 0.5) - (this.toolBar.width * 0.25); 
		
		Common.stage_height = this.stage.stageHeight;
		Common.stage_width = this.stage.stageWidth;
		
		this.textInfo.x = (this.stage.stageWidth - this.textInfo.width) - 5;
		this.textInfo.y = 5;
		
		if (Common.gCamera != null) {
			Common.gCamera.update_pan_bounds();
		}
		
		this.save_manager.x = (this.stage.stageWidth * 0.5) - (this.save_manager.width * 0.5);
		this.save_manager.y = (this.stage.stageHeight * 0.5) - (this.save_manager.height * 0.5);
		
		this.settings_box.x = (this.stage.stageWidth * 0.5) - (this.settings_box.width * 0.5);
		this.settings_box.y = (this.stage.stageHeight * 0.5) - (this.settings_box.height * 0.5);
		
		this.loadManager.x = (this.stage.stageWidth * 0.5) - (this.loadManager.width * 0.5);
		this.loadManager.y = (this.stage.stageHeight * 0.5) - 300;
		
		this.timeline.x = (this.stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = this.stage.stageHeight - this.timeline.height + 25;
	}
	public function return_to_origin(_x:Float = 0, _y:Float = 0) {
		this.track.x = this.stage.stageWidth * 0.5 - _x;
		this.track.y = this.stage.stageHeight * 0.5 - _y;
		this.track.scaleX = this.track.scaleY = 2;
	}
	public function return_to_origin_sim() {
		this.track.x = this.stage.stageWidth * 0.5;
		this.track.y = this.stage.stageHeight * 0.5;
	}
	public function take_screencap() {
		this.toolBar.visible = false;
		var sc:Screenshot = new Screenshot(this.visContainer);
	}
	public function end_screencap() {
		this.toolBar.visible = true;
	}
}
