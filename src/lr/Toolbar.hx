package lr;

import global.Common;
import openfl.display.MovieClip;
import ui.tool.icon.IconBase;
import ui.tool.lr.*;
import ui.tool.icon.*;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Tool bar seen across top of screen
 * 
 */
class Toolbar extends MovieClip
{

	public static var tool:Any;
	private var pencil:IconPencil;
	private var line:IconLine;
	private var save:IconSave;
	private var eraser:IconEraser;
	private var pan:IconPan;
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
		
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(this.width, 0);
		this.graphics.lineTo(this.width, this.height);
		this.graphics.lineTo(0, this.height);
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
	}
	public function set_play_mode() {
		this.pencil.disable();
		this.line.disable();
		this.eraser.disable();
		this.pan.disable();
		this.swBlue.disable();
		this.swGreen.disable();
		this.swRed.disable();
	}
	public function set_edit_mode() {
		this.pencil.enable();
		this.line.enable();
		this.eraser.enable();
		this.pan.enable();
		this.swBlue.enable();
		this.swRed.enable();
		this.swGreen.enable();
	}
}