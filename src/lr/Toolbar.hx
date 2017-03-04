package lr;

import global.Common;
import openfl.display.MovieClip;
import ui.tool.icon.IconBase;
import ui.tool.lr.*;
import ui.tool.icon.*;

/**
 * ...
 * @author Kaelan Evans
 */
class Toolbar extends MovieClip
{

	public static var tool:Any;
	private var pencil:IconPencil;
	private var line:IconLine;
	public function new() 
	{
		super();
		
		tool = new ToolLine();
		
		pencil = new IconPencil();
		this.addChild(this.pencil);
		
		line = new IconLine();
		this.addChild(line);
		this.line.x = 30;
		
	}
}