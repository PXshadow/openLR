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
		this.line.x = 30;
		
		eraser = new IconEraser();
		this.addChild(eraser);
		this.eraser.x = 60;
		
		pan = new IconPan();
		this.addChild(pan);
		this.pan.x = 90;
		
		pause = new IconPause();
		this.addChild(pause);
		this.pause.x = 90;
		this.pause.visible = false;
		
		playB = new IconPlay();
		this.addChild(playB);
		this.playB.x = 120;
		
		stopB = new IconStop();
		this.addChild(stopB);
		this.stopB.x = 150;
		
		flag = new IconFlag();
		this.addChild(flag);
		this.flag.x = 180;
		
		save = new IconSave();
		this.addChild(save);
		this.save.x = 210;
		
		settings = new IconSettings();
		this.addChild(settings);
		this.settings.x = 240;
		
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(270, 0);
		this.graphics.lineTo(270, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
		
		this.swBlue = new SwatchBlue();
		this.addChild(swBlue);
		this.swBlue.y = 33;
		
		this.swRed = new SwatchRed();
		this.addChild(swRed);
		this.swRed.y = 33;
		this.swRed.x = 30;
		
		this.swGreen = new SwatchGreen();
		this.addChild(swGreen);
		this.swGreen.y = 33;
		this.swGreen.x = 60;
		
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