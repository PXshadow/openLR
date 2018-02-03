package lr.tool;

import openfl.display.Sprite;

import global.Common;
import global.SVar;
import lr.tool.ToolBase;
import lr.tool.icon.*;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Tool bar seen across top of screen
 * 
 */
class Toolbar extends Sprite
{

	public static var tool:ToolBase;
	public static var icon:IconBase;
	public static var swatch:IconBase;
	private var pencil:IconPencil;
	private var line:IconLine;
	private var eraser:IconEraser;
	private var save:IconSave;
	private var settings:IconSettings;
	private var swBlue:SwatchBlue;
	private var swRed:SwatchRed;
	private var swGreen:SwatchGreen;
	
	public var pause:IconPause;
	private var playB:IconPlay;
	private var stopB:IconStop;
	private var flag:IconFlag;
	
	private var tool_list:Array<IconBase>;
	private var swatch_list:Array<IconBase>;
	
	public function new() 
	{
		super();
		
		Common.gToolbar = this;
		
		this.tool_list = new Array();
		this.swatch_list = new Array();
		
		Toolbar.tool = new ToolBase();
		Toolbar.tool.set_listeners();
		
		pencil = new IconPencil();
		this.tool_list.push(this.pencil);
		
		line = new IconLine();
		this.tool_list.push(this.line);
		
		eraser = new IconEraser();
		this.tool_list.push(this.eraser);
		
		pause = new IconPause();
		this.tool_list.push(this.pause);
		this.pause.visible = false;
		
		playB = new IconPlay();
		this.tool_list.push(this.playB);
		
		stopB = new IconStop();
		this.tool_list.push(this.stopB);
		
		flag = new IconFlag();
		this.tool_list.push(this.flag);
		
		save = new IconSave();
		this.tool_list.push(this.save);
		
		settings = new IconSettings();
		this.tool_list.push(this.settings);
		
		this.swBlue = new SwatchBlue();
		this.swatch_list.push(this.swBlue);
		
		this.swRed = new SwatchRed();
		this.swatch_list.push(this.swRed);
		
		this.swGreen = new SwatchGreen();
		this.swatch_list.push(this.swGreen);
		
		Toolbar.icon = pencil;
		icon.select();
		Toolbar.swatch = swBlue;
		swBlue.select();
		
		Toolbar.tool.set_tool(ToolType.Pencil);
		
		this.place_icons();
	}
	private function place_icons() {
		var i = 0;
		for (a in this.tool_list) {
			this.addChild(a);
			a.x = (32 * i);
			++i;
		}
		i = 0;
		for (b in this.swatch_list) {
			this.addChild(b);
			b.y = 32;
			b.x = (32 * i);
			++i;
		}
	}
	public function update_icons(_type:String) {
		Toolbar.icon.deselect();
		switch (_type) {
			case ToolType.Pencil :
				Toolbar.icon = this.pencil;
				Toolbar.swatch.select();
			case ToolType.Line :
				Toolbar.icon = this.line;
				Toolbar.swatch.select();
			case ToolType.Eraser :
				Toolbar.icon = this.eraser;
				Toolbar.swatch.deselect();
				Common.line_type = -1;
		}
		Toolbar.icon.select();
	}
	public function update_swatch(_type:Int) {
		swatch.deselect();
		switch(_type) {
			case 0:
				Common.line_type = 0;
				swatch = swBlue;
			case 1 :
				Common.line_type = 1;
				swatch = swRed;
			case 2 :
				Common.line_type = 2;
				swatch = swGreen;
		}
		swatch.select();
	}
	public function set_full_edit_mode() {
		SVar.game_mode = GameState.edit;
		this.pencil.mouseChildren = true;
		this.pencil.enable();
		this.line.mouseChildren = true;
		this.line.enable();
		this.eraser.mouseChildren = true;
		this.eraser.enable();
		this.save.mouseChildren = true;
		this.save.enable();
		this.settings.mouseChildren = true;
		this.settings.enable();
		this.swBlue.mouseChildren = true;
		this.swBlue.enable();
		this.swRed.mouseChildren = true;
		this.swRed.enable();
		this.swGreen.mouseChildren = true;
		this.swGreen.enable();
	}
	public function set_live_draw_mode() {
		SVar.game_mode = GameState.livedraw;
		this.pencil.mouseChildren = true;
		this.pencil.enable();
		this.line.mouseChildren = true;
		this.line.enable();
		this.eraser.mouseChildren = true;
		this.eraser.enable();
		this.save.mouseChildren = true;
		this.save.enable();
		this.settings.mouseChildren = true;
		this.settings.enable();
		this.swBlue.mouseChildren = true;
		this.swBlue.enable();
		this.swRed.mouseChildren = true;
		this.swRed.enable();
		this.swGreen.mouseChildren = true;
		this.swGreen.enable();
	}
	public function set_play_mode() {
		SVar.game_mode = GameState.playback;
		this.pencil.mouseChildren = false;
		this.pencil.disable();
		this.line.mouseChildren = false;
		this.line.disable();
		this.eraser.mouseChildren = false;
		this.eraser.disable();
		this.save.mouseChildren = false;
		this.save.disable();
		this.settings.mouseChildren = false;
		this.settings.disable();
		this.swBlue.mouseChildren = false;
		this.swBlue.disable();
		this.swRed.mouseChildren = false;
		this.swRed.disable();
		this.swGreen.mouseChildren = false;
		this.swGreen.disable();
	}
}