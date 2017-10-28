package lr.rider.objects;

import openfl.display.Sprite;

#if (!flash)
	import openfl.utils.AssetLibrary;
#elseif (flash)
	import openfl.Assets;
#end

import lr.rider.RiderBase;

/**
 * ...
 * @author Kaelan Evans
 */
class StartPointVis extends Sprite
{
	
	var clip:Sprite;
	var rider:RiderBase;
	public function new() 
	{
		super();
		#if (!flash)
			this.loadAsset();
		#elseif (flash)
			this.grabFLClip();
		#end
	}
	#if (!flash)
		function loadAsset() 
		{
			var swfclip = AssetLibrary.loadFromFile("swf/start.bundle");
			swfclip.onComplete(this.attach);
		}
		function attach(lib:AssetLibrary) 
		{
			var innerClip:Sprite;
			innerClip = lib.getMovieClip("");
			innerClip.scaleX = innerClip.scaleY *= 0.5;
			innerClip.x = innerClip.y = ( -9.2 / 2);
			this.clip = new Sprite();
			this.clip.addChild(innerClip);
			this.addChild(this.clip);
		}
	#elseif (flash)
		function grabFLClip() 
		{
			var innerClip:Sprite;
			innerClip = Assets.getMovieClip ("swf-library:start_olr");
			innerClip.scaleX = innerClip.scaleY *= 0.5;
			innerClip.x = innerClip.y = ( -9.2 / 2);
			this.clip = new Sprite();
			this.clip.addChild(innerClip);
			this.addChild(this.clip);
			this.addChild(clip);
		}
	#end
}