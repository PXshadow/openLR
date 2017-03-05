package file;

import global.Common;
import openfl.utils.Object;

/**
 * ...
 * @author Kaelan Evans
 */
class TrackParse
{

	var lines:Array<Dynamic>;
	var trackData:Object;
	public function new()
	{
		
	}
	public function parse():Object
	{
		this.lines = Common.gGrid.lines;
		
		this.trackData = new Object();
		this.trackData.a = Common.version;
		this.trackData.b = Common.cvar_track_author;
		this.trackData.c = Date.now();
		this.trackData.d = this.lines.length;
		this.trackData.e = new Array<Object>();
		
		for (i in 0...lines.length) {
			this.trackData.e[i] = new Object();
			this.trackData.e[i].a = lines[i].a; 
			this.trackData.e[i].b = lines[i].b; 
			this.trackData.e[i].type = lines[i].type; 
			this.trackData.e[i].inv = lines[i].inv;
			this.trackData.e[i].lim = lines[i]._lim;
		}
		
		return(this.trackData);
	}
}