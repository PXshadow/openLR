package platform.cores;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import platform.CoreBase;
import platform.file.exporting.ExportNative;

//third party

//openLR
import platform.titlecards.TitleCardCPP;
import platform.control.Desktop;
import platform.file.importing.ImportNative;
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
class SysCore extends CoreBase
{
	public function new() 
	{
		super();
		
		Common.gCode = this; //This class
			
		this.title_card = new TitleCardCPP();
		
		this.title_card.x = 0;
		this.title_card.y = 0;
	}
	override public function start(_load:Bool = false) {
		this.init_env();
		this.init_track();
		this.visContainer.visible = true;
		if (_load) {
			this.toggle_Loader();
		}
		this.controlScheme = new Desktop();
		
		Lib.current.stage.application.onExit.add (function (exitCode) {
			//Autosave code here
		});
	}
	function resize_title(e:Event):Void 
	{
		this.title_card.render();
	}
	public function init_env() //Initialize enviornment
	{
		Lib.current.stage.addEventListener(Event.RESIZE, resize);
		
		Common.stage_height = Lib.current.stage.stageHeight;
		Common.stage_width = Lib.current.stage.stageWidth;
	}
	override public function silent_load (_path:String) {
		this.importing = new ImportNative();
		this.importing.load(_path);
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
		this.timeline.x = (Lib.current.stage.stageWidth * 0.5) - (640);
		this.timeline.y = Lib.current.stage.stageHeight - 60;
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
			Toolbar.tool.set_tool("None");
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
		if (this.exportVisible == false) {
			this.exportVisible = true;
			
			this.toolBar.mouseChildren = false;
			this.toolBar.mouseEnabled = false;
			this.timeline.mouseChildren = false;
			this.timeline.mouseEnabled = false;
			Lib.current.stage.mouseEnabled = false;
			
			this.export = new ExportNative();
			Lib.current.stage.addChild(this.export);
			
			this.align();
			
			Toolbar.tool.set_tool("None");
		} else {
			this.exportVisible = false;
			
			this.toolBar.mouseChildren = true;
			this.toolBar.mouseEnabled = true;
			this.timeline.mouseChildren = true;
			this.timeline.mouseEnabled = true;
			Lib.current.stage.mouseEnabled = true;
			
			Lib.current.stage.removeChild(this.export);
			
			this.align();
			
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	override public function toggle_Loader() {
		if (this.importingVisible == false) {
			this.importingVisible = true;
			
			this.toolBar.mouseChildren = false;
			this.toolBar.mouseEnabled = false;
			this.timeline.mouseChildren = false;
			this.timeline.mouseEnabled = false;
			Lib.current.stage.mouseEnabled = false;
			
			this.importing = new ImportNative();
			Lib.current.stage.addChild(this.importing);
			
			this.align();
			
			Toolbar.tool.set_tool("None");
		} else {
			this.importingVisible = false;
			
			this.toolBar.mouseChildren = true;
			this.toolBar.mouseEnabled = true;
			this.timeline.mouseChildren = true;
			this.timeline.mouseEnabled = true;
			Lib.current.stage.mouseEnabled = true;
			
			Lib.current.stage.removeChild(this.importing);
			
			this.align();
			
			Toolbar.tool.set_tool(ToolBase.lastTool);
		}
	}
	private function resize(e:Event):Void
	{
		this.align();
	}
	override public function align() {
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
		this.timeline.y = Lib.current.stage.stageHeight - 60;
		
		if (this.exportVisible) {
			this.export.x = (Lib.current.stage.stageWidth * 0.5) - (this.export.width * 0.5);
			this.export.y = (Lib.current.stage.stageHeight * 0.5) - (this.export.height * 0.5);
		}
		
		Common.stage_tl = new Point(0, 0);
		Common.stage_br = new Point(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		Common.gTrack.check_visibility();
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

	}
	override public function end_screencap() {
		
	}
	
}