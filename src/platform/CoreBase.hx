package platform;

#if (!flash)
	import openfl.display.Stage;
	import openfl.display.Sprite;
#else
	import flash.display.Stage;
	import flash.display.Sprite;
#end

import platform.TitleCardBase;
import platform.ControlBase;
import global.Common;
import global.CVar;
import global.SVar;
import global.engine.FrameRate;
import global.Language;
import global.engine.RiderManager;
import global.engine.SimManager;
import lr.scene.TextInfo;
import lr.scene.Track;
import lr.menus.SettingsMenu;
import ui.inter.AlertBox;
import lr.tool.Toolbar;
import lr.scene.timeline.Ticker;
import lr.scene.timeline.TimelineControl;
import platform.file.ExportBase;

/**
 * ...
 * @author Kaelan Evans
 */
class CoreBase extends Sprite
{
	
	private var controlScheme:ControlBase;
	private var visContainer:Sprite;
	private var track:Track;
	private var riders:RiderManager;
	private var toolBar:Toolbar;
	private var textInfo:TextInfo;
	private var FPS:FrameRate;
	private var title_card:TitleCardBase;
	private var timeline:TimelineControl;
	private var settings_box:SettingsMenu;
	private var export:ExportBase;
	private var exportVisible:Bool = false;
	
	public function new() 
	{
		super();
	}
	public function return_to_origin(_x:Float = 0, _y:Float = 0) {
		
	}
	public function return_to_origin_sim() {
		
	}
	public function reset_timeline() {
		
	}
	public function toggle_Loader() {
		
	}
	public function toggleSettings_box() {
		
	}
	public function toggle_save_menu() {
		
	}
	public function take_screencap() {
		
	}
	public function end_screencap() {
		
	}
	public function start(_load:Bool = false) {
		
	}
	public function setScale() {
		
	}
	public function align() {
		
	}
}