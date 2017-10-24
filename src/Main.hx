package;

import openfl.display.Sprite;

import platform.CoreBase;

#if android
    import platform.cores.AndroidCore;        
#elseif (windows || linux || osx)
    import platform.cores.CppCore;
#elseif flash
    import platform.cores.FlashCore;
#elseif js
    import platform.cores.JavaScriptCore;
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
        
        #if android
            this.core = new AndroidCore();
        #elseif (windows || linux || osx)
            this.core = new CppCore();
        #elseif (flash || air)
			this.core = new FlashCore();
        #elseif js
            this.core = new JavaScriptCore();
        #else
            trace("Deployment target not supported");
        #end
    }
}