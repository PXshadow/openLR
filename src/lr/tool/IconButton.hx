package lr.tool;

#if (!flash)
	import openfl.display.SimpleButton;
#else
	import openfl.Assets;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.MovieClip;
#end
	
import lr.tool.IconBase;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class IconButton extends SimpleButton
{
	var selected:Dynamic;
	public function new(_icon = Icon.undefined) 
	{
		super();
		
		#if (!flash)
			this.attachClip(_icon);
		#else
			this.attachFlashClips(_icon);
		#end
	}
	#if (!flash)
		function attachClip(_name:String) 
		{
			this.upState = Common.OLR_Assets.getMovieClip("up_" + _name);
			this.hitTestState = Common.OLR_Assets.getMovieClip("up_" + _name);
			this.overState = Common.OLR_Assets.getMovieClip("over_" + _name);
			this.downState = Common.OLR_Assets.getMovieClip("down_" + _name);
		}
	#elseif (flash)
		function attachFlashClips(_object:String) 
		{
			if (_object != Icon.swBlue && _object != Icon.swGreen && _object != Icon.swRed) {
				this.upState = Assets.getMovieClip ("swf-library:up_" + _object);
				this.hitTestState = Assets.getMovieClip ("swf-library:up_" + _object);
				this.overState = Assets.getMovieClip ("swf-library:over_" + _object);
				this.downState = Assets.getMovieClip ("swf-library:down_" + _object);
			} else {
				var nameSpace:String = "";
				switch(_object) {
					case Icon.swBlue :
						nameSpace = "blue";
					case Icon.swRed :
						nameSpace = "red";
					case Icon.swGreen :
						nameSpace = "green";
				}
				this.upState = Assets.getMovieClip ("swf-library:up_" + nameSpace);
				this.hitTestState = Assets.getMovieClip ("swf-library:up_" + nameSpace);
				this.overState = Assets.getMovieClip ("swf-library:over_" + nameSpace);
				this.downState = Assets.getMovieClip ("swf-library:down_" + nameSpace);
			}
		}
	#end
}