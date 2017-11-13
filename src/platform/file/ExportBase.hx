package platform.file;

import openfl.display.Sprite;
import openfl.utils.Object;

import global.Common;
/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract SaveType(String) from String to String {
	public var LRPK:String = "LRPK";
	public var JSON:String = "JSON";
	public var SOL:String = "SOL";
	public var TRK:String = "TRK";
}
class ExportBase extends Sprite
{
	var lineData:Object;
	var trackData:Object;
	var riderData:Object;
	public function new() 
	{
		super();
	}
}