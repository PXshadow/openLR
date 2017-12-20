package platform.file.fileType;

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
	public function new() 
	{
		
	}
	public function encode(_name:String = "", _author:String = "", _description:String = "") {
		
	}
	public function decode(_path:String) {
		
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
}
