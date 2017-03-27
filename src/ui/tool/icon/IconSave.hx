package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;
import sys.io.File;
import sys.FileSystem;

import global.Common;
import ui.tool.Toolbar;
import ui.inter.SingleButton;
import file.SaveManager;
import file.LoadManager;
import ui.inter.ConfirmDialog;
import ui.inter.InputText;

/**
 * ...
 * @author Kaelan Evans
 */
class IconSave extends IconBase
{
	private var open:Bool = false;
	private var menu:MovieClip;
	private var new_track:SingleButton;
	private var save_track:SingleButton;
	private var saveManager:SaveManager;
	private var load_track:SingleButton;
	private var loadManager:LoadManager;
	private var save_name_input:InputText;
	private var safety_dialog:ConfirmDialog;
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
			this.saveManager = new SaveManager();
			this.loadManager = new LoadManager();
			
			this.menu = new MovieClip();
			this.addChild(menu);
			this.menu.graphics.clear();
			this.menu.graphics.lineStyle(2, 0xFFFFFF, 0);
			this.menu.graphics.beginFill(0xCCCCCC, 1);
			this.menu.graphics.lineTo(0, 0);
			
			this.new_track = new SingleButton("New Track", this.make_new_track);
			this.menu.addChild(this.new_track);
			this.menu.y = this.height + 5;
			this.menu.x = 5;
			
			this.save_track = new SingleButton("Save Track", this.getSaveInfo);
			this.menu.addChild(this.save_track);
			this.save_track.y = this.new_track.height;
			this.save_name_input = new InputText(Common.cvar_track_name);
			this.menu.addChild(save_name_input);
			this.save_name_input.x = this.save_track.width + 5;
			this.save_name_input.y = this.save_track.y;
			
			this.load_track = new SingleButton("Load JSON", this.show_loader);
			this.menu.addChild(this.load_track);
			this.load_track.y = this.save_track.y + this.load_track.height;
			
			this.open = true;
		}
	}
	
	function show_loader() 
	{
		this.show_menu();
		Common.gCode.init_Loader();
	}
	function make_new_track() 
	{
		this.show_menu();
		Common.gTrack.clear_stage();
	}
	
	function getSaveInfo() 
	{
		this.show_menu();
		Common.cvar_track_name = this.save_name_input.input_field.text;
		if (!FileSystem.exists("saves/" + Common.cvar_track_name + ".json")) {
			Common.gSaveManager.generate_save_json();
			trace("safe to save");
		} else {
			this.prompt_user();
			trace("not safe to save");
		}
	}
	function prompt_user() {
		this.safety_dialog = new ConfirmDialog("A save with the name \"" + Common.cvar_track_name +"\" already exists." + "\n" + "Do you want to overwite this file?", this.confirm_save, this.cancel_save);
		Common.gStage.addChild(this.safety_dialog);
		this.safety_dialog.x = (Common.stage_width * 0.5) - (this.safety_dialog.width * 0.5);
		this.safety_dialog.y = (Common.stage_height * 0.5) - (this.safety_dialog.height * 0.5);
	}
	
	function confirm_save() 
	{
		Common.gSaveManager.generate_save_json();
		Common.gStage.removeChild(this.safety_dialog);
	}
	function cancel_save()
	{
		Common.gStage.removeChild(this.safety_dialog);
	}
	override private function disable_tool(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		if (!open) {
			this.alpha = 0.75;
		}
	}
}