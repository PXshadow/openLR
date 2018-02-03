package platform;

#if (!flash)
	import openfl.display.Sprite;
#else
	import flash.display.Sprite;
#end

import platform.ControlBase;
import global.engine.RiderManager;
import lr.scene.TextInfo;
import lr.scene.Track;
import lr.menus.SettingsMenu;
import lr.tool.Toolbar;
import lr.scene.timeline.TimelineControl;
import platform.control.KeyControl;
import platform.file.ExportBase;
import platform.file.ImportBase;
#if sys
	import platform.file.SaveBrowser;
#end

/**
 * ...
 * @author Kaelan Evans
 */
class CoreBase extends Sprite
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
	#if sys
		private var newStartLoader:SaveBrowser;
	#end
	
	public function new() {
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
	public function start() {
		
	}
	public function setScale() {
		
	}
	public function align() {

	}
}