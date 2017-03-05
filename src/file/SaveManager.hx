package file;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class SaveManager
{
	var trackParse:TrackParse;
	public function new() 
	{
		Common.gSaveManager = this;
	}
	public function generateSave() {
		this.trackParse = new TrackParse();
		var _locObject = this.trackParse.parse();
	}
}