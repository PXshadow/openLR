package file;

import sys.FileSystem;

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
		if (FileSystem.exists("./settings.dat")) {
			trace("settings found");
		} else {
			trace("settings non-existant");
		}
	}
	
	function checkDirectories() 
	{
		if (FileSystem.isDirectory("./saves")) {
		} else{
			FileSystem.createDirectory("./saves");
		}
		if (FileSystem.isDirectory("./export")) {
		} else {
			FileSystem.createDirectory("./export");
		}
	}
}