package;

import openfl.display.Sprite;

import base.CoreBase;
#if (cpp)
	#if (!android)
		import base.cores.CppCore;
	#else
		import base.cores.AndroidCore;
	#end
#elseif (flash)
	import base.cores.FlashCore;
#elseif (js)
	import base.cores.JavaScriptCore;
#end
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //OpenLR Project Release Alpha 0.0.5
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * This program was built using HaxeDevelop IDE, with haxe and openFL. Other libraries if used can be found in project.xml
 * 
 */

class Main extends Sprite 
{
	private var core:CoreBase;
	public function new() {
		
		super();
		
		#if (cpp)
			#if (!android)
				this.core = new CppCore(this.stage);
			#else
				this.core = new AndroidCore(this.stage);
			#end
		#elseif (flash)
			this.core = new FlashCore(this.stage);
		#elseif (js)
			this.core = new JavaScriptCore(this.stage);
		#else
			trace("Deployment target not supported");
		#end
	}
}
