package file;

import sys.FileSystem;
import sys.io.File;
import haxe.Json;

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
	
	function loadSettings() 
	{
		if (FileSystem.exists("./settings/defaults.json")) {
			//new defaults file
		} else {
			//load defaults file
		}
		if (FileSystem.exists("./settings/KeyBindings.json")) {
			this.set_key_bindings();
		} else {
			this.generate_key_binding_json();
		}
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
	function generate_key_binding_json() 
	{
		var _locJson = KeyBindings.get_json_defaults();
		var file = File.write("./settings/KeyBindings.json", true);
		file.writeString(Json.stringify(_locJson, null, "\t"));
		file.close();
	}
	function set_key_bindings() {
		var _locFile = File.getContent("./settings/KeyBindings.json");
		var _locJson = Json.parse(_locFile);
		KeyBindings.set_bindings(_locJson);
	}
}