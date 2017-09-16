package base.cores;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.Stage;

//third party

//openLR
import base.TitleCardBase;
import base.titlecards.TitleCardCPP;
import file.init.FileStartCPP;
import file.LoadManager;
import file.SaveManager;
import file.AutosaveManager;
import file.Screenshot;
import global.Common;
import global.FrameRate;
import global.Language;
import global.RiderManager;
import global.SimManager;
import lr.scene.TextInfo;
import lr.scene.Track;
import lr.settings.SettingsMenu;
import ui.inter.AlertBox;
import ui.tool.Toolbar;
import ui.tool.timeline.Ticker;
import ui.tool.timeline.TimelineControl;

/**
 * ...
 * @author Kaelan Evans
 */
class CppCore extends CoreBase
{
	private var mainFileInit:FileStartCPP; //this class controls settings
	private var visContainer:Sprite; //simple display container. This will make it easier to take screenshots and record video without having to move a matrix all around
	private var track:Track;
	private var riders:RiderManager;
	private var toolBar:Toolbar;
	private var textInfo:TextInfo;
	private var FPS:FrameRate;
	private var title_card:TitleCardBase;
	private var save_manager:SaveManager;
	private var timeline:TimelineControl;
	private var loadManager:LoadManager;
	private var settings_box:SettingsMenu;
	private var autosave:AutosaveManager;
	
	public function new(_stage:Stage) 
	{
		super(_stage);
		
		Common.gCode = this; //This class
		
		this.mainFileInit = new FileStartCPP(); //checks for default folders and saved settings in the track
			
		this.title_card = new TitleCardCPP();
		this.main_stage.addChild(this.title_card);
		
		this.title_card.x = (this.main_stage.stageWidth * 0.5) - (this.title_card.width * 0.5);
		this.title_card.y = (this.main_stage.stageHeight * 0.5) - (this.title_card.height * 0.5);
	}
	override public function start(_load:Bool = false) {
		this.init_env();
		this.init_track();
		this.visContainer.visible = true;
		if (_load) {
			this.toggle_Loader();
		}
		this.main_stage.removeChild(this.title_card);
	}
	public function init_env() //Initialize enviornment
	{
		this.main_stage.addEventListener(Event.RESIZE, resize);
		
		Common.stage_height = this.main_stage.stageHeight;
		Common.stage_width = this.main_stage.stageWidth;
		
		this.FPS = new FrameRate();
		
		this.autosave = new AutosaveManager();
	}
	
	public function init_track() //display minimum items
	{
		this.visContainer = new Sprite();
		this.main_stage.addChild(visContainer);
		Common.gVisContainer = this.visContainer;
		
		this.track = new Track();
		this.visContainer.addChild(this.track);
		this.track.x = this.main_stage.stageWidth * 0.5;
		this.track.y = this.main_stage.stageHeight * 0.5;
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
		this.main_stage.addChild(this.settings_box);
		this.settings_box.visible = false;
		
		this.loadManager = new LoadManager();
		this.main_stage.addChild(this.loadManager);
		this.loadManager.visible = false;
		
		this.save_manager = new SaveManager();
		this.main_stage.addChild(this.save_manager);
		this.save_manager.visible = false;
		
		this.timeline = new TimelineControl();
		this.main_stage.addChild(this.timeline);
		this.timeline.update();
		
		this.visContainer.visible = false;
		
		this.align();
	}
	override public function reset_timeline() {
		Common.sim_frames = 0;
		Common.sim_max_frames = 0;
		Common.sim_pause_frame = -1;
		Common.sim_slow_motion = false;
		Common.sim_slow_motion_rate = 5;
		this.visContainer.removeChild(this.timeline);
		this.timeline = new TimelineControl();
		this.visContainer.addChild(this.timeline);
		this.timeline.update();
		this.timeline.x = (this.main_stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = this.main_stage.stageHeight - this.timeline.height + 25;
	}
	override public function toggleSettings_box()
	{
		if (!this.settings_box.visible) {
			Common.svar_game_mode = GameState.inmenu;
			this.settings_box.visible = true;
			this.track.visible = false;
			this.toolBar.mouseChildren = false;
			this.textInfo.visible = false;
			this.timeline.visible = false;
			this.settings_box.update();
		} else {
			this.mainFileInit.write_new_settings();
			this.mainFileInit.write_new_keys();
			this.settings_box.visible = false;
			this.track.visible = true;
			this.toolBar.mouseChildren = true;
			this.textInfo.visible = true;
			this.timeline.visible = true;
			Common.svar_game_mode = GameState.edit;
			Common.gToolBase.enable();
		}
	}
	override public function toggle_save_menu() {
		if (this.save_manager.visible != true) {
			Common.svar_game_mode = GameState.inmenu;
			this.save_manager.update();
			this.save_manager.visible = true;
			this.track.visible = false;
			this.toolBar.mouseChildren = false;
			this.textInfo.visible = false;
			this.timeline.visible = false;
		} else {
			this.save_manager.visible = false;
			this.track.visible = true;
			this.toolBar.mouseChildren = true;
			this.textInfo.visible = true;
			this.timeline.visible = true;
			Common.svar_game_mode = GameState.edit;
			Common.gToolBase.enable();
		}
	}
	override public function toggle_Loader() {
		if (!this.loadManager.visible) {
			Common.svar_game_mode = GameState.inmenu;
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
			Common.svar_game_mode = GameState.edit;
			Common.gToolBase.enable();
		}
	}
	private function resize(e:Event):Void
	{
		this.visContainer.x = this.visContainer.y = 0;
		
		this.toolBar.x = (this.main_stage.stageWidth / 2) - (128 * Common.cvar_toolbar_scale);
		
		Common.stage_height = this.main_stage.stageHeight;
		Common.stage_width = this.main_stage.stageWidth;
		
		this.textInfo.x = (this.main_stage.stageWidth - this.textInfo.width) - 5;
		this.textInfo.y = 5;
		
		if (Common.gCamera != null) {
			Common.gCamera.update_pan_bounds();
		}
		
		this.save_manager.x = (this.main_stage.stageWidth * 0.5) - (this.save_manager.width * 0.5);
		this.save_manager.y = (this.main_stage.stageHeight * 0.5) - (this.save_manager.height * 0.5);
		
		this.settings_box.x = 200;
		this.settings_box.y = 200;
		
		this.loadManager.x = (this.main_stage.stageWidth * 0.5) - (this.loadManager.width * 0.5);
		this.loadManager.y = (this.main_stage.stageHeight * 0.5) - 300;
		
		this.timeline.x = (this.main_stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = this.main_stage.stageHeight - this.timeline.height + 25;
	}
	override public function align() {
		this.visContainer.x = this.visContainer.y = 0;
		
		this.toolBar.x = (this.main_stage.stageWidth / 2) - (128 * Common.cvar_toolbar_scale);
		
		Common.stage_height = this.main_stage.stageHeight;
		Common.stage_width = this.main_stage.stageWidth;
		
		this.textInfo.x = (this.main_stage.stageWidth - this.textInfo.width) - 5;
		this.textInfo.y = 5;
		
		if (Common.gCamera != null) {
			Common.gCamera.update_pan_bounds();
		}
		
		this.save_manager.x = (this.main_stage.stageWidth * 0.5) - (this.save_manager.width * 0.5);
		this.save_manager.y = (this.main_stage.stageHeight * 0.5) - (this.save_manager.height * 0.5);
		
		this.settings_box.x = 200;
		this.settings_box.y = 200;
		
		this.loadManager.x = (this.main_stage.stageWidth * 0.5) - (this.loadManager.width * 0.5);
		this.loadManager.y = (this.main_stage.stageHeight * 0.5) - 300;
		
		this.timeline.x = (this.main_stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = this.main_stage.stageHeight - this.timeline.height + 25;
	}
	override public function setScale() {
		this.timeline.scaleX = this.timeline.scaleY = Common.cvar_toolbar_scale;
		this.toolBar.scaleX = this.toolBar.scaleY = Common.cvar_toolbar_scale;
	}
	override public function return_to_origin(_x:Float = 0, _y:Float = 0) {
		this.track.x = this.main_stage.stageWidth * 0.5 - _x;
		this.track.y = this.main_stage.stageHeight * 0.5 - _y;
		this.track.scaleX = this.track.scaleY = 2;
	}
	override public function return_to_origin_sim() {
		this.track.x = this.main_stage.stageWidth * 0.5;
		this.track.y = this.main_stage.stageHeight * 0.5;
	}
	override public function take_screencap() {
		this.toolBar.visible = false;
		this.timeline.visible = false;
		var sc:Screenshot = new Screenshot(this.visContainer);
	}
	override public function end_screencap() {
		this.toolBar.visible = true;
		this.timeline.visible = true;
	}
	
}