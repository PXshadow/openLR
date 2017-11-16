package lr.tool.icon;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;
import openfl.net.URLRequest;

import global.Common;
import lr.tool.Toolbar;
import lr.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class IconPlay extends IconBase
{

	public function new() 
	{
		super(Icon.play);
	}
	override public function up(e:MouseEvent) {
		if (!Common.gSimManager.paused) {
			Common.track_last_pos_x = Common.gTrack.x;
			Common.track_last_pos_y = Common.gTrack.y;
		}
		Common.gTrack.set_rendermode_play();
		Common.gTrack.set_simmode_play();
		
		Common.gToolbar.pause.visible = true;
		Common.gToolbar.set_play_mode();
		
		Toolbar.tool.set_tool("None");
		
		Common.gRiderManager.x = Common.gTrack.x;
		Common.gRiderManager.y = Common.gTrack.y;
		
		Common.gTrack.check_visibility();
	}
	
}