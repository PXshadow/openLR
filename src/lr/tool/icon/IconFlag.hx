package lr.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;

import global.Common;
import global.SVar;
import lr.tool.IconBase;

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
		if (SVar.sim_running) {
			Common.gSimManager.mark_rider_position();
			Common.gSimManager.show_flag();
		} else if (!SVar.sim_running) {
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