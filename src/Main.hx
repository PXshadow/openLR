package;

//Primary
import openfl.display.Sprite;

//Secondary
import platform.CoreBase;

#if (android || ios)
    import platform.cores.MobileCore;        
#elseif (sys)
    import platform.cores.SysCore;
#elseif flash
    import platform.cores.FlashCore;
#elseif js
    import platform.cores.WebCore;
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
        
        #if (android || ios)
            this.core = new MobileCore();
        #elseif (sys)
            this.core = new SysCore();
        #elseif (flash || air)
			this.core = new FlashCore();
        #elseif js
            this.core = new WebCore();
        #else
           trace("Deployment target not supported");
        #end
    }
}