package ui.tool;

import global.Common;
import openfl.display.MovieClip;
import openfl.events.KeyboardEvent;

import ui.tool.ToolBase;
import ui.tool.lr.*;
import ui.tool.icon.*;
import global.KeyBindings;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Tool bar seen across top of screen
 * 
 */
class Toolbar extends MovieClip
{

	public static var tool:ToolBase;
	public static var icon:IconBase;
	public static var swatch:IconBase;
	private var pencil:IconPencil;
	private var line:IconLine;
	private var save:IconSave;
	private var eraser:IconEraser;
	public var pan:IconPan;
	public var pause:IconPause;
	private var settings:IconSettings;
	private var swBlue:SwatchBlue;
	private var swRed:SwatchRed;
	private var swGreen:SwatchGreen;
	
	private var playB:IconPlay;
	private var stopB:IconStop;
	private var flag:IconFlag;
	
	public function new() 
	{
		super();
		Common.gToolbar = this;
		
		Common.gStage.addEventListener(KeyboardEvent.KEY_UP, key_tool_switch);
		
		tool = new ToolPencil();
		
		pencil = new IconPencil();
		this.addChild(this.pencil);
		
		line = new IconLine();
		this.addChild(line);
		this.line.x = 31;
		
		eraser = new IconEraser();
		this.addChild(eraser);
		this.eraser.x = 62;
		
		pan = new IconPan();
		this.addChild(pan);
		this.pan.x = 93;
		
		pause = new IconPause();
		this.addChild(pause);
		this.pause.x = 93;
		this.pause.visible = false;
		
		playB = new IconPlay();
		this.addChild(playB);
		this.playB.x = 124;
		
		stopB = new IconStop();
		this.addChild(stopB);
		this.stopB.x = 155;
		
		flag = new IconFlag();
		this.addChild(flag);
		this.flag.x = 186;
		
		save = new IconSave();
		this.addChild(save);
		this.save.x = 217;
		
		settings = new IconSettings();
		this.addChild(settings);
		this.settings.x = 248;
		
		this.swBlue = new SwatchBlue();
		this.addChild(swBlue);
		this.swBlue.x = -2;
		this.swBlue.y = 33;
		
		this.swRed = new SwatchRed();
		this.addChild(swRed);
		this.swRed.y = 33;
		this.swRed.x = 30;
		
		this.swGreen = new SwatchGreen();
		this.addChild(swGreen);
		this.swGreen.y = 33;
		this.swGreen.x = 62;
		
		Toolbar.icon = pencil;
		icon.select();
		Toolbar.swatch = swBlue;
		swBlue.select();
	}
	
	private function key_tool_switch(e:KeyboardEvent):Void 
	{
		if (e.keyCode == KeyBindings.pencil_1 || e.keyCode == KeyBindings.pencil_2) {
			Common.gToolBase.disable();
			icon.deselect();
			tool = new ToolPencil();
			icon = pencil;
			icon.select();
			swatch.select();
		}
		if (e.keyCode == KeyBindings.line_1 || e.keyCode == KeyBindings.line_2) {
			Common.gToolBase.disable();
			icon.deselect();
			tool = new ToolLine();
			icon = line;
			icon.select();
			swatch.select();
		}
		if (e.keyCode == KeyBindings.eraser_1 || e.keyCode == KeyBindings.eraser_2) {
			Common.gToolBase.disable();
			icon.deselect();
			tool = new ToolEraser();
			icon = eraser;
			icon.select();
			swatch.deselect();
			Common.line_type = -1;
		}
		if (e.keyCode == KeyBindings.pan_1 || e.keyCode == KeyBindings.pan_2) {
			Common.gToolBase.disable();
			icon.deselect();
			tool = new ToolPan();
			icon = pan;
			icon.select();
			swatch.deselect();
		}
		if (e.keyCode == KeyBindings.swatch_blue) {
			swatch.deselect();
			Common.line_type = 0;
			swatch = swBlue;
			swatch.select();
		}
		if (e.keyCode == KeyBindings.swatch_red) {
			swatch.deselect();
			Common.line_type = 1;
			swatch = swRed;
			swatch.select();
		}
		if (e.keyCode == KeyBindings.swatch_green) {
			swatch.deselect();
			Common.line_type = 2;
			swatch = swGreen;
			swatch.select();
		}
	}
	public function set_play_mode() {
		this.pencil.disable();
		this.line.disable();
		this.eraser.disable();
		this.pan.disable();
		this.save.disable();
		this.settings.disable();
		this.swBlue.disable();
		this.swGreen.disable();
		this.swRed.disable();
		Common.gStage.removeEventListener(KeyboardEvent.KEY_DOWN, key_tool_switch);
	}
	public function set_edit_mode() {
		this.pencil.enable();
		this.line.enable();
		this.eraser.enable();
		this.pan.enable();
		this.save.enable();
		this.settings.enable();
		this.swBlue.enable();
		this.swRed.enable();
		this.swGreen.enable();
		Common.gStage.addEventListener(KeyboardEvent.KEY_UP, key_tool_switch);
	}
}