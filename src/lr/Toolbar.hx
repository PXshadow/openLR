package lr;

import global.Common;
import openfl.display.MovieClip;
import ui.tool.ToolMouseNull;
import ui.tool.icon.IconBase;
import ui.tool.lr.*;

/**
 * ...
 * @author Kaelan Evans
 */
class Toolbar extends MovieClip
{

	public var tool:Any;
	public function new() 
	{
		super();
		
		tool = new Pencil();
		Common.gToolCurrent = this.tool;
	}
	
}