package platform.file;

import openfl.display.Sprite;
import openfl.utils.Object;

import global.Common;
/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract SaveType(Int) from Int to Int {
	public var LRPK:Int = 0;
	public var JSON:Int = 1;
	public var SOL:Int = 2;
	public var TRK:Int = 3;
}
class ExportBase extends Sprite
{
	var lineData:Object;
	var trackData:Object;
	var riderData:Object;
	public function new() 
	{
		
	}
	publicic function getNameSpace() {
		
	}
	public function getData() {
		this.lineData = this.getLineData();
		this.trackData
	}
	public function flushData() {
		
	}
	function getLineData() 
	{
		var _locLoopCount = 0;
		var lines = Common.gGrid.lines;
		lines.reverse();
		var a:Array<Object> = new Array();
		for (i in lines) {
			if (i == null) {
				continue;
			}
			a[_locLoopCount] = new Object();
			a[_locLoopCount] = {
				"id": i.ID,
				"type": i.type,
				"x1": i.x1,
				"y1": i.y1,
				"x2": i.x2,
				"y2": i.y2,
				"flipped": i.inv,
				"leftExtended":  i.lExt,
				"rightExtended":  i.rExt
			};
			_locLoopCount += 1;
		}
		return(a);
	}
}