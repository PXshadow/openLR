package;

import openfl.display.Sprite;

import base.CoreBase;
import base.cores.CppCore;
import base.cores.FlashCore;
import base.cores.JavaScriptCore;
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
		
		Common.gStage = this.stage;
		
		#if (cpp || android)
			this.core = new CppCore(this.stage);
		#elseif (flash)
			this.core = new FlashCore(this.stage);
		#elseif (js)
			this.core = new JavaScriptCore(this.stage)
		#end
	}
}
