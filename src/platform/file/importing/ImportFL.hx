package platform.file.importing;

import flash.net.SharedObject;

import lr.lines.LineBase;
import platform.file.ImportBase;
import global.Common;
import global.CVar;

/**
 * ...
 * @author ...
 */
class ImportFL extends ImportBase 
{
	var solObject:SharedObject;
	public function new() 
	{
		super();
		
		this.solObject = SharedObject.getLocal("savedLines", "/");
	}
	override public function load(_path:String = null) 
	{
		var trackData = this.solObject.data.trackList[Std.parseInt(_path)];
		
		Common.gRiderManager.set_start(trackData.startLine[0], trackData.startLine[1]);
		
		CVar.track_name = trackData.label;
		
		var lineData:Array<Array<Dynamic>> = new Array();
		lineData = trackData.data;
		
		for (a in lineData) {
			var _bool:Bool = (a[5] == 1 ? true : false);
			var _locLine = new LineBase(a[9], a[0], a[1], a[2], a[3], _bool, a[4]);
			Common.gGrid.cacheLine(_locLine);
		}
	}
}