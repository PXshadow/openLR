package lr.tool.icon;

import openfl.events.MouseEvent;

import global.Common;
import global.CVar;
import lr.tool.Toolbar;
import lr.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPause extends IconBase
{
	var paused:Bool = false;
	public function new() 
	{
		super(Icon.pause);
	}
	override public function up(e:MouseEvent) {
		if (CVar.paused) {
			Common.gSimManager.resume_sim();
			Common.gToolbar.set_play_mode();
			Toolbar.tool.set_tool("None");
		} else if (!CVar.paused) {
			Common.gSimManager.pause_sim();
			Toolbar.tool.set_tool(ToolBase.lastTool);
			Common.gToolbar.set_live_draw_mode();
			Toolbar.icon.select();
		}
	}
	
}