package;

//Primary
import openfl.display.Sprite;

//Secondary
import platform.CoreBase;

#if android
    import platform.cores.AndroidCore;        
#elseif (windows || linux || osx || mac)
    import platform.cores.CppCore;
#elseif flash
    import platform.cores.FlashCore;
#elseif js
    import platform.cores.JavaScriptCore;
#end

//third party

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
        #elseif (windows || linux || osx || mac)
            this.core = new CppCore();
        #elseif (flash || air)
			this.core = new FlashCore();
        #elseif js
            this.core = new JavaScriptCore();
        #else
           this.traceInfo();
        #end
    }
	function traceInfo() 
	{
		#if(!js)
			trace("Platform not supported");
			trace(Sys.systemName()); //Dumps the conditional name the compiler should expect. Add this to the above conditionals for desired/custom core
			trace(Sys.environment()); //idk might be useful who knows.
		#end
	}
}