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
		Common.gToolbar.set_play_mode();
		Common.gToolbar.pause.visible = true;
		Common.gTrack.set_simmode_play();
		
		Common.gRiderManager.x = Common.gTrack.x;
		Common.gRiderManager.y = Common.gTrack.y;
	}
	
}