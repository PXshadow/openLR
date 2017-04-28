package lr.settings;

import openfl.display.MovieClip;
import openfl.events.MouseEvent;

import ui.inter.SingleButton;
import global.Common;

enum PanelMode
{
	file;
	track;
	profile;
}

/**
 * ...
 * @author Kaelan Evans
 */
class SettingsMenu extends MovieClip
{
	var state:PanelMode = file;
	
	var tabFileMenu:SingleButton;
	var tabTrackSettings:SingleButton;
	var tabProfile:SingleButton;
	
	var fileMenu:FileMenu;
	var trackMenu:TrackSettings;
	var profileMenu:ProfileSettings;
	
	private var exit:SingleButton;
	public function new() 
	{
		super();
		
		this.tabFileMenu = new SingleButton("File", this.set_to_file);
		this.tabTrackSettings = new SingleButton("Track", this.set_to_track);
		this.tabProfile = new SingleButton("Profile", this.set_to_profile);
		
		/*this.addChild(this.tabFileMenu);
		
		this.addChild(this.tabTrackSettings);
		this.tabTrackSettings.x = this.tabFileMenu.width;
		
		this.addChild(this.tabProfile);
		this.tabProfile.x = this.tabTrackSettings.x + this.tabTrackSettings.width; */
		
		this.exit = new SingleButton("Close", Common.gCode.toggleSettings_box);
		this.addChild(exit);
		this.exit.x = this.width;
		
		this.fileMenu = new FileMenu();
		this.trackMenu = new TrackSettings();
		this.profileMenu = new ProfileSettings();
		
		this.set_to_track();
	}
	function clearMenu() {
		if (this.state == file) {
			this.removeChild(this.fileMenu);
		} else if (this.state == track) {
			this.removeChild(this.trackMenu);
		} else if (this.state == profile) {
			this.removeChild(this.profileMenu);
		}
	}
	function set_to_track() {
		this.clearMenu();
		this.state = track;
		this.addChild(this.trackMenu);
		this.trackMenu.update();
		this.trackMenu.y = this.tabFileMenu.height + 5;
		this.trackMenu.x = 5;
	}
	function set_to_file() {
		this.clearMenu();
		this.state = file;
		this.addChild(this.fileMenu);
		this.fileMenu.y = this.tabFileMenu.height + 5;
		this.fileMenu.x = 5;
	}
	function set_to_profile() {
		this.clearMenu();
		this.state = profile;
		this.addChild(this.profileMenu);
		this.profileMenu.y = this.tabFileMenu.height + 5;
		this.profileMenu.x = 5;
	}
}