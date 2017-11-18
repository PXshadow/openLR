package platform.cores;

import flash.Lib;
import flash.events.Event;
import openfl.Assets;
import platform.CoreBase;

//third party

//openLR
import platform.control.Desktop;
import platform.titlecards.TitleCardFL;
import global.Common;
import global.CVar;
import global.SVar;
import global.engine.RiderManager;
import lr.scene.TextInfo;
import lr.scene.Track;
import lr.menus.SettingsMenu;
import lr.tool.Toolbar;
import lr.tool.ToolBase;
import lr.scene.timeline.TimelineControl;

/**
 * ...
 * @author Kaelan Evans
 */
class FlashCore extends CoreBase
{
	public function new() 
	{
		super();
		
		Assets.loadLibrary("olr_fl");
		
		Common.gCode = this; //This class
		
		this.title_card = new TitleCardFL();
		Lib.current.stage.addChild(this.title_card);
		
		this.title_card.x = (Lib.current.stage.stageWidth * 0.5) - (this.title_card.width * 0.5);
		this.title_card.y = (Lib.current.stage.stageHeight * 0.5) - (this.title_card.height * 0.5);
	}
	override public function start(_load:Bool = false) {
		Lib.current.stage.removeChild(this.title_card);
		this.init_env();
		this.init_track();
		if (_load) {
			this.toggle_Loader();
		}
		this.controlScheme = new Desktop();
	}
	public function init_env() //Initialize enviornment
	{
		Lib.current.stage.addEventListener(Event.RESIZE, resize);
		
		Common.stage_height = Lib.current.stage.stageHeight;
		Common.stage_width = Lib.current.stage.stageWidth;
	}
	
	public function init_track() //display minimum items
	{
		this.track = new Track();
		Lib.current.stage.addChild(this.track);
		this.track.x = Lib.current.stage.stageWidth * 0.5;
		this.track.y = Lib.current.stage.stageHeight * 0.5;
		this.track.scaleX = this.track.scaleY = 2;
		
		this.riders = new RiderManager();
		this.riders.add_rider(2, 0, 0);
		Lib.current.stage.addChild(this.riders);
		this.riders.x = this.track.x;
		this.riders.y = this.track.y;
		this.riders.scaleX = this.riders.scaleY = this.track.scaleY;
		
		this.toolBar = new Toolbar();
		Lib.current.stage.addChild(this.toolBar);
		
		this.textInfo = new TextInfo();
		Lib.current.stage.addChild(this.textInfo);
		
		this.settings_box = new SettingsMenu();
		Lib.current.stage.addChild(this.settings_box);
		this.settings_box.visible = false;
		
		this.timeline = new TimelineControl();
		Lib.current.stage.addChild(this.timeline);
		this.timeline.update();
		
		this.align();
		
		SVar.game_mode = GameState.edit;
	}
	override public function reset_timeline() {
		SVar.frames = 0;
		SVar.max_frames = 0;
		SVar.pause_frame = -1;
		SVar.slow_motion = false;
		CVar.slow_motion_rate = 5;
		Lib.current.stage.removeChild(this.timeline);
		this.timeline = new TimelineControl();
		Lib.current.stage.addChild(this.timeline);
		this.timeline.update();
		this.timeline.x = (Lib.current.stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = Lib.current.stage.stageHeight - this.timeline.height + 25;
	}
	override public function toggleSettings_box()
	{
		if (!this.settings_box.visible) {
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
	override public function toggle_save_menu() {

	}
	override public function toggle_Loader() {

	}
	private function resize(e:Event):Void
	{
		this.align();
	}
	override public function align() {
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
		
		this.timeline.x = (Lib.current.stage.stageWidth * 0.5) - (this.timeline.width * 0.5);
		this.timeline.y = Lib.current.stage.stageHeight - this.timeline.height + 25;
	}
	override public function setScale() {
		this.toolBar.scaleX = this.toolBar.scaleY = CVar.toolbar_scale;
	}
	override public function return_to_origin(_x:Float = 0, _y:Float = 0) {
		this.track.x = Lib.current.stage.stageWidth * 0.5 - _x;
		this.track.y = Lib.current.stage.stageHeight * 0.5 - _y;
		this.track.scaleX = this.track.scaleY = 2;
	}
	override public function return_to_origin_sim() {
		this.track.x = Lib.current.stage.stageWidth * 0.5;
		this.track.y = Lib.current.stage.stageHeight * 0.5;
	}
	override public function take_screencap() {
		this.toolBar.visible = false;
		this.timeline.visible = false;
	}
	override public function end_screencap() {
		this.toolBar.visible = true;
		this.timeline.visible = true;
	}
	
}