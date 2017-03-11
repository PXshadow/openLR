package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import lr.Toolbar;
import ui.inter.SingleButton;
import file.SaveManager;

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
			this.removeChild(this.menu);
			this.open = false;
		} else if (!open) {
			this.saveManager = new SaveManager();
			
			this.menu = new MovieClip();
			this.addChild(menu);
			this.menu.graphics.clear();
			this.menu.graphics.lineStyle(2, 0xFFFFFF, 0);
			this.menu.graphics.beginFill(0xCCCCCC, 1);
			this.menu.graphics.lineTo(0, 0);
			
			this.new_track = new SingleButton("New Track", Common.gTrack.clear_stage);
			this.menu.addChild(this.new_track);
			this.menu.y = this.height + 5;
			this.menu.x = 5;
			
			this.save_track = new SingleButton("Save Track", Common.gSaveManager.generate_save_json);
			this.menu.addChild(this.save_track);
			this.save_track.y = this.new_track.height;
			
			this.open = true;
		}
	}
	override private function disable_tool(e:MouseEvent):Void 
	{
		Common.gToolBase.disable();
		if (!open) {
			this.alpha = 0.75;
		}
	}
}