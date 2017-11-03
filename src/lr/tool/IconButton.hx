package lr.tool;

#if (!flash)
	import openfl.utils.AssetLibrary;
	import openfl.display.SimpleButton;
	import openfl.display.Sprite;
#else
	import openfl.Assets;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.MovieClip;
#end
	
import lr.tool.IconBase;

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
			var swfLib = AssetLibrary.loadFromFile("swf/ui/icons/" + _icon + ".bundle");
			swfLib.onComplete(this.attachClips);
			swfLib.onError(this.iconFailed);
		#else
			this.attachFlashClips(_icon);
		#end
	}
	#if (!flash)
		function iconFailed(lib:AssetLibrary) 
		{
			trace("failed Icon");
		}
		function attachClips(lib:AssetLibrary) 
		{
			this.upState = lib.getMovieClip("up");
			this.hitTestState = lib.getMovieClip("up");
			this.overState = lib.getMovieClip("over");
			this.downState = lib.getMovieClip("down");
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