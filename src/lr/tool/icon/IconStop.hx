package lr.tool.icon;

import openfl.events.MouseEvent;

import global.Common;
import global.CVar;
import lr.tool.IconBase;

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
		Common.gTimeline.update();
		if (!CVar.paused) {
			Common.gTrack.x = Common.track_last_pos_x;
			Common.gTrack.y = Common.track_last_pos_y;
			Common.gRiderManager.x = Common.gTrack.x;
			Common.gRiderManager.y = Common.gTrack.y;
		}
		Common.gTrack.check_visibility();
	}
	
}