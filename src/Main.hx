package;

import base.cores.Flash;
import base.cores.JavaScript;
import base.cores.NativeCPP;
import openfl.display.Sprite;

import base.CoreBase;
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
		
		Common.gStage = this.stage; //The stage, not to be comfused with main.hx
		
		#if (cpp)
			this.core = new NativeCPP(this.stage);
		#elseif (flash)
			this.core = new Flash(this.stage);
		#elseif (js)
			this.core = new JavaScript(this.stage)
		#end
	}
}
