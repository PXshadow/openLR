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
	
	private var playB:IconPlay;
	public function new() 
	{
		super();
		
		tool = new ToolPencil();
		
		pencil = new IconPencil();
		this.addChild(this.pencil);
		
		line = new IconLine();
		this.addChild(line);
		this.line.x = 30;
		
		playB = new IconPlay();
		this.addChild(playB);
		this.playB.x = 60;
		
		save = new IconSave();
		this.addChild(save);
		this.save.x = 90;
		
	}
}