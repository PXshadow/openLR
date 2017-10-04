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
class IconStop extends IconBase
{

	public function new() 
	{
		super(Icon.stop);
	}
	override public function up(e:MouseEvent) {
		Common.gTrack.set_rendermode_edit();
		Common.gToolbar.pause.visible = false;
		Common.gToolbar.set_full_edit_mode();
		Common.gTrack.set_simmode_stop();
		Common.gSimManager.fast_forward = false;
		Common.gTimeline.update();
		if (!Common.gSimManager.paused) {
			Common.gTrack.x = Common.track_last_pos_x;
			Common.gTrack.y = Common.track_last_pos_y;
			Common.gRiderManager.x = Common.gTrack.x;
			Common.gRiderManager.y = Common.gTrack.y;
		}
		Common.gTrack.check_visibility();
	}
	
}