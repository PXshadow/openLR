package lr.settings;

import openfl.display.Sprite;
import openfl.events.MouseEvent;

import ui.inter.TextButton;
import global.Language;
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
class SettingsMenu extends Sprite
{
	var tabFileMenu:TextButton;
	var tabTrackSettings:TextButton;
	var tabProfile:TextButton;
	
	var fileMenu:FileMenu;
	var trackMenu:TrackSettings;
	var profileMenu:ProfileSettings;
	
	private var exit:TextButton;
	public function new() 
	{
		super();
		
		this.tabFileMenu = new TextButton(Language.File, this.set_to_file, ButtonSize.b120x30);
		this.tabTrackSettings = new TextButton(Language.Track, this.set_to_track, ButtonSize.b120x30);
		this.tabProfile = new TextButton(Language.Profile, this.set_to_profile, ButtonSize.b120x30);
		
		this.addChild(this.tabFileMenu);
		this.tabFileMenu.x = -140;
		
		this.addChild(this.tabTrackSettings);
		this.tabTrackSettings.x = -140;
		this.tabTrackSettings.y = 35;
		
		//this.addChild(this.tabProfile);
		//this.tabProfile.x = this.tabTrackSettings.x + this.tabTrackSettings.width;
		
		this.exit = new TextButton(Language.Close, Common.gCode.toggleSettings_box, ButtonSize.b120x30);
		this.addChild(exit);
		this.exit.x = -140;
		this.exit.y = 70;
		
		this.fileMenu = new FileMenu();
		this.trackMenu = new TrackSettings();
		//this.profileMenu = new ProfileSettings();
		
		this.set_to_track();
	}
	public function update() {
		this.fileMenu.update();
		this.trackMenu.update();
		//this.profileMenu.update();
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
	}
	function set_to_file() {
		this.clearMenu();
		this.state = file;
		this.addChild(this.fileMenu);
	}
	function set_to_profile() {
		this.clearMenu();
		this.state = profile;
		this.addChild(this.profileMenu);
	}
}