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
	var state:PanelMode = file;
	
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
		
		this.tabFileMenu = new TextButton(Language.File, ButtonSize.b120x30);
		this.tabTrackSettings = new TextButton(Language.Track, ButtonSize.b120x30);
		this.tabProfile = new TextButton(Language.Profile, ButtonSize.b120x30);
		
		this.addChild(this.tabFileMenu);
		
		this.addChild(this.tabTrackSettings);
		this.tabTrackSettings.x = this.tabFileMenu.width;
		
		//this.addChild(this.tabProfile);
		//this.tabProfile.x = this.tabTrackSettings.x + this.tabTrackSettings.width;
		
		this.exit = new TextButton(Language.Close, ButtonSize.b120x30);
		this.addChild(exit);
		this.exit.x = this.width;
		
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