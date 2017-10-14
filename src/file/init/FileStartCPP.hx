package file.init;

import openfl.utils.Object;
import openfl.Assets;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

import global.Common;
import global.CVar;
import global.KeyBindings;
import global.Language;

/**
 * ...
 * @author Kaelan Evans
 * 
 * makes sure directories are made and default settings are loaded.
 * 
 */
class FileStartCPP
{
	public var ready:Bool = false;
	public function new() 
	{
		
		checkDirectories();
		loadSettings();
	}
	function checkDirectories() 
	{
		if (FileSystem.isDirectory("./saves")) {
		} else{
			FileSystem.createDirectory("./saves");
		}
		if (FileSystem.isDirectory("./autosaves")) {
		} else{
			FileSystem.createDirectory("./autosaves");
		}
		if (FileSystem.isDirectory("./export")) {
		} else {
			FileSystem.createDirectory("./export");
		}
		if (FileSystem.isDirectory("./settings")) {
		} else {
			FileSystem.createDirectory("./settings");
		}
	}
	function loadSettings() 
	{
		if (FileSystem.exists("./settings/Settings.json")) {
			this.get_and_set_defaults();
		} else {
			this.get_and_write_settings();
		}
		if (FileSystem.exists("./settings/KeyBindings.json")) {
			this.set_key_bindings();
		} else {
			this.get_and_write_default_keys();
		}
		if (FileSystem.exists("./settings/language.json")) {
			this.get_and_set_language();
		} else {
			this.get_and_write_language();
		}
	}
	//////////
	//Keys
	//////////
	public function write_new_keys() 
	{
		KeyBindings.write_settings();
	}
	private function get_and_write_default_keys() { //This is to be exclusively used for DEFAULTS
		var file = File.write("./settings/KeyBindings.json", true);
		file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/settings/KeyBindings.json")), null, "\t"));
		file.close();
	}
	public function set_key_bindings() {
		try {
			var _locFile = File.getContent("./settings/KeyBindings.json");
			var _locJson = Json.parse(_locFile);
			KeyBindings.set_bindings(_locJson);
		} catch (e:String) {
			
		}
	}
	//////////
	//settings
	//////////
	public function write_new_settings() 
	{
		
	}
	function get_and_write_settings() { //This is to be exclusively used for DEFAULTS
		var file = File.write("./settings/Settings.json", true);
		file.writeString(Json.stringify(Json.parse(File.getContent("defaults/settings/Settings.json")), null, "\t"));
		file.close();
	}
	function get_and_set_defaults() 
	{
		var _locFile = File.getContent("./settings/Settings.json");
		var _locJson = Json.parse(_locFile);
		CVar.auto_save = _locJson.settings.autosave;
		CVar.auto_save_freq  = _locJson.settings.autosave_freq;
		CVar.angle_snap = _locJson.settings.angle_snap;
		CVar.line_snap = _locJson.settings.joint_snap;
		CVar.hit_test = _locJson.settings.hit_test;
		CVar.contact_points = _locJson.settings.contact_points;
		CVar.force_zoom = _locJson.settings.force_zoom;
		CVar.force_zoom_ammount = _locJson.settings.zoom_ammount;
		CVar.track_author = _locJson.settings.author;
		CVar.color_play = _locJson.settings.color_play;
		CVar.preview_mode  = _locJson.settings.preview_mode;
		CVar.dictionary = _locJson.settings.language;
		CVar.toolbar_scale = _locJson.settings.uiscale;
	}
	//////////
	//Language
	//////////
	public function get_and_write_language() 
	{
		var file = File.write("./settings/language.json", true);
		switch(CVar.dictionary) {
			case "English" :
				file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/languages/english_us.json")), null, "\t"));
			default :
				file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/languages/english_us.json")), null, "\t"));
		}
		file.close();
		this.get_and_set_language();
	}
	public function get_and_set_language() {
		var _locFile = File.getContent("./settings/language.json");
		var _locJson = Json.parse(_locFile);
		
		Language.Continue = _locJson.dictionary.cont;
		Language.Yes = _locJson.dictionary.yes;
		Language.No = _locJson.dictionary.no;
		Language.Title = _locJson.dictionary.title;
		Language.Splash_a = _locJson.dictionary.splash_a;
		Language.Splash_b = _locJson.dictionary.splash_b;
		Language.New_track = _locJson.dictionary.new_track;
		Language.Load_track = _locJson.dictionary.load_track;
		Language.Save_track = _locJson.dictionary.save_track;
		Language.Screencap = _locJson.dictionary.screencap;
		Language.File = _locJson.dictionary.file;
		Language.Track = _locJson.dictionary.track;
		Language.Profile = _locJson.dictionary.profile;
		Language.Close = _locJson.dictionary.close;
		Language.Save = _locJson.dictionary.save;
		Language.Load = _locJson.dictionary.load;
		Language.Cancel = _locJson.dictionary.cancel;
	}
}
