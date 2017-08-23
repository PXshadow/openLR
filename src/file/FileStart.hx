package file;

import openfl.utils.Object;
import openfl.Assets;

#if (cpp)
	import sys.FileSystem;
	import sys.io.File;
	import haxe.Json;
#end

import global.Common;
import global.KeyBindings;
import global.Language;

/**
 * ...
 * @author Kaelan Evans
 * 
 * makes sure directories are made and default settings are loaded.
 * 
 */
class FileStart
{
	public var ready:Bool = false;
	public function new() 
	{
		
		checkDirectories();
		loadSettings();
	}
	function checkDirectories() 
	{
		#if (cpp)
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
		#end
	}
	function loadSettings() 
	{
		#if (cpp)
		if (FileSystem.exists("./settings/settings.json")) {
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
		#end
	}
	//////////
	//Keys
	//////////
	public function write_new_keys() 
	{
		KeyBindings.write_settings();
	}
	private function get_and_write_default_keys() { //This is to be exclusively used for DEFAULTS
		#if (cpp)
		var file = File.write("./settings/KeyBindings.json", true);
		file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/settings/KeyBindings.json")), null, "\t"));
		file.close();
		#end
	}
	public function set_key_bindings() {
		#if (cpp)
		try {
			var _locFile = File.getContent("./settings/KeyBindings.json");
			var _locJson = Json.parse(_locFile);
			KeyBindings.set_bindings(_locJson);
		} catch (e:String) {
			
		}
		#end
	}
	//////////
	//settings
	//////////
	public function write_new_settings() 
	{
		
	}
	function get_and_write_settings() { //This is to be exclusively used for DEFAULTS
		#if (cpp)
		var file = File.write("./settings/Settings.json", true);
		file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/settings/Settings.json")), null, "\t"));
		file.close();
		#end
	}
	function get_and_set_defaults() 
	{
		#if (cpp)
		var _locFile = File.getContent("./settings/Settings.json");
		var _locJson = Json.parse(_locFile);
		Common.cvar_auto_save = _locJson.settings.autosave;
		Common.cvar_auto_save_freq  = _locJson.settings.autosave_freq;
		Common.cvar_angle_snap = _locJson.settings.angle_snap;
		Common.cvar_line_snap = _locJson.settings.joint_snap;
		Common.cvar_hit_test = _locJson.settings.hit_test;
		Common.cvar_contact_points = _locJson.settings.contact_points;
		Common.cvar_force_zoom = _locJson.settings.force_zoom;
		Common.cvar_force_zoom_ammount = _locJson.settings.zoom_ammount;
		Common.cvar_track_author = _locJson.settings.author;
		Common.cvar_color_play = _locJson.settings.color_play;
		Common.cvar_preview_mode  = _locJson.settings.preview_mode;
		Common.cvar_dictionary = _locJson.settings.language;
		Common.cvar_toolbar_scale = _locJson.settings.uiscale;
		#end
	}
	//////////
	//Language
	//////////
	public function get_and_write_language() 
	{
		#if (cpp)
		var file = File.write("./settings/language.json", true);
		switch(Common.cvar_dictionary) {
			case "English" :
				file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/languages/english_us.json")), null, "\t"));
			default :
				file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/languages/english_us.json")), null, "\t"));
		}
		file.close();
		this.get_and_set_language();
		#end
	}
	public function get_and_set_language() {
		#if (cpp)
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
		#end
	}
}
