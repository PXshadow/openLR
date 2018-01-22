package platform.file.fileType;

import haxe.io.Bytes;
import openfl.utils.ByteArray;
import openfl.utils.Object;

/**
 * ...
 * @author Kaelan Evans
 */
class FileBase 
{
	public var data:Object;
	var name:String;
	var author:String;
	var description:String;
	var fileName:String;
	public var exportString:String = "";
	public var exportBytes:ByteArray;
	public function new() 
	{
		
	}
	public function encode(_name:String = "", _author:String = "", _description:String = "") {
		
	}
	public function json_decode(_obj:Object) {
		
	}
	public function lrpk_decode(_data:Bytes) {
		
	}
	public function get_lim_to_set(l:Bool, r:Bool):Int {
		if (!l && !r) {
			return(0);
		} else if (l && !r) {
			return(1);
		} else if (!l && r) {
			return(2);
		} else if (l && r) {
			return(3);
		} else {
			return(0);
		}
	}
	public function stringFloat(_v:Float):String 
	{
		return "" + _v;
	}
}
