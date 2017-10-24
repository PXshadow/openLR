package platform;

import openfl.display.Sprite;
import openfl.text.TextField;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class TitleCardBase extends Sprite
{

	var version_info:TextField;
	public function new() 
	{
		super();
	}
	public function add_version_specs()
	{
		this.version_info = new TextField();
		this.addChild (this.version_info);
		this.version_info.width = 584;
		this.version_info.selectable = false;
		var _locString0:String = "Version " + Common.version;
		var _locString1:String = "";
		#if (cpp)
			_locString1= Sys.systemName();
		#end
		#if (cpp)
			_locString0 = _locString0 + " C++ " + _locString1;
		#elseif (flash)
			_locString0 = _locString0 + " Flash " + _locString1;
		#elseif (js) 
			_locString0 = _locString0 + " JavaScript/HTML5 " + _locString1;
		#else
			_locString0 = _locString0 + " NaKP " + _locString1;
		#end
		#if (debug)
			_locString0 = _locString0 + " Debug";
		#else
			_locString0 = _locString0 + " Release";
		#end
		this.version_info.text = _locString0;
		this.version_info.x = 8;
		this.version_info.y = 280;
	}
}