package file;

import openfl.utils.Object;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class Defaults
{
	var settingsData:Object;
	public function new() 
	{
		
	}
	public function dump_json() {
		this.settingsData = new Object();
		this.settingsData = {
			"uniAuthor" : Common.cvar_universal_author_name;
		}
	}
	public function pull_json() {
		
	}
	private function write() {
		
	}
}