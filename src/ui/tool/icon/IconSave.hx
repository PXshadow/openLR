package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;
import sys.io.File;
import sys.FileSystem;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;

import global.Common;
import global.Language;
import ui.tool.Toolbar;
import ui.inter.TextButton;
import file.LoadManager;
import ui.inter.ConfirmDialog;
import ui.inter.InputText;
import file.SaveManager;

/**
 * ...
 * @author Kaelan Evans
 */
class IconSave extends IconBase
{
	private var open:Bool = false;
	private var menu:MovieClip;
	private var new_track:TextButton;
	private var save_track:TextButton;
	private var load_track:TextButton;
	private var loadManager:LoadManager;
	private var safety_dialog:ConfirmDialog;
	private var screen_cap:TextButton;
	public function new() 
	{
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/save.png"));
		this.addChild(this.icon);
	}
	override public function down(e:MouseEvent) {
		if (this.mouseY < 30)
		{
			this.show_menu();
			this.alpha = 1;
		}
	}
	private function show_menu()
	{
		if (open) {
			this.menu.removeChild(this.new_track);
			this.menu.removeChild(this.load_track);
			this.removeChild(this.menu);
			this.open = false;
		} else if (!open) {
			this.loadManager = new LoadManager();
			
			this.menu = new MovieClip();
			this.addChild(menu);
			this.menu.graphics.clear();
			this.menu.graphics.lineStyle(2, 0xFFFFFF, 0);
			this.menu.graphics.beginFill(0xCCCCCC, 1);
			this.menu.graphics.lineTo(0, 0);
			
			this.new_track = new TextButton(Language.New_track, ButtonSize.b120x30);
			this.menu.addChild(this.new_track);
			this.menu.y = 35;
			this.menu.x = 5;
			
			this.save_track = new TextButton(Language.Save_track, ButtonSize.b120x30);
			this.menu.addChild(this.save_track);
			this.save_track.y = this.new_track.height;
			
			this.load_track = new TextButton(Language.Load_track, ButtonSize.b120x30);
			this.menu.addChild(this.load_track);
			this.load_track.y = this.save_track.y + this.load_track.height;
			
			this.screen_cap = new TextButton(Language.Screencap, ButtonSize.b120x30);
			this.menu.addChild(this.screen_cap);
			this.screen_cap.y = this.load_track.y + this.screen_cap.height;
			
			this.open = true;
		}
	}
	
	function take_screenshot() 
	{
		Common.gCode.take_screencap();
		this.show_menu();
	}
	
	function show_loader() 
	{
		this.show_menu();
		Common.gCode.toggle_Loader();
	}
	function make_new_track() 
	{
		this.show_menu();
		this.safety_dialog = new ConfirmDialog("Are you sure you want to make a new track? All unsaved changes will be lost!", this.confirmed_new, this.negative_new);
		this.addChild(this.safety_dialog);
		this.safety_dialog.x = -320;
		this.safety_dialog.y = 180;
	}
	function open_save_menu() 
	{
		Common.gCode.toggle_save_menu();
	}
	override private function disable_tool(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		if (enabled) {
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}
	function confirmed_new() {
		this.removeChild(this.safety_dialog);
		SaveManager.new_track = true;
		Common.gTrack.clear_stage();
		Common.gToolBase.enable();
	}
	function negative_new() {
		this.show_menu();
		this.removeChild(this.safety_dialog);
	}
}