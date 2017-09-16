package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import ui.tool.Toolbar;
import ui.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class IconFlag extends IconBase
{
	private var flagLock:Bool;
	private var lock:Bitmap;
	public function new() 
	{
		super(Icon.flag);
	}
	override public function up(e:MouseEvent) {
		if (Common.svar_sim_running) {
			Common.gSimManager.mark_rider_position();
			Common.gSimManager.show_flag();
		} else if (!Common.svar_sim_running) {
			if (Common.gSimManager.flagged == false) {
				Common.gSimManager.show_flag();
				Common.gSimManager.flagged = true;
			} else if (Common.gSimManager.flagged == true) {
				Common.gSimManager.hide_flag();
				Common.gSimManager.flagged = false;
			}
		}
	}
	override public function alt(e:MouseEvent) {
		
	}
}