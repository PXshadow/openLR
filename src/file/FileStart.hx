package file;

import openfl.utils.Object;
import openfl.Assets;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

import global.Common;
import global.KeyBindings;

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
		if (FileSystem.exists("./settings/settings.json")) {
			this.get_and_set_defaults();
		} else {
			this.get_and_write_defaults();
		}
		if (FileSystem.exists("./settings/KeyBindings.json")) {
			this.set_key_bindings();
		} else {
			KeyBindings.write_settings();
		}
	}
	function set_key_bindings() {
		try {
			var _locFile = File.getContent("./settings/KeyBindings.json");
			var _locJson = Json.parse(_locFile);
			KeyBindings.set_bindings(_locJson);
		} catch (e:String) {
			
		}
	}
	public function get_and_write_defaults() {
		var file = File.write("./settings/KeyBindings.json", true);
		file.writeString(Json.stringify(Json.parse(Assets.getText("defaults/settings/KeyBindings.json")), null, "\t"));
	}
	function get_and_set_defaults() 
	{
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
	}
}