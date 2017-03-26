package ui.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import ui.tool.Toolbar;

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
		super();
		this.icon = new Bitmap(Assets.getBitmapData("icon/flag.png"));
		this.lock = new Bitmap(Assets.getBitmapData("icon/lock.png"));
		this.addChild(this.icon);
	}
	override public function down(e:MouseEvent) {
		if (!flagLock) {
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
	}
	override public function alt(e:MouseEvent) {
		if (flagLock) {
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
	}
	override private function double_click(e:MouseEvent) {
		if (this.flagLock) {
			this.flagLock = false;
			this.removeChild(this.lock);
		} else if (!this.flagLock) {
			this.flagLock = true;
			this.addChild(this.lock);
			this.lock.x = 20;
			this.lock.y = 20;
		}
	}
}