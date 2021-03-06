package lr.rider.objects;

import openfl.display.Sprite;

#if (flash)
	import openfl.Assets;
#end

import lr.rider.RiderBase;

import global.Common;

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
			var innerClip:Sprite;
			innerClip = Common.OLR_Assets.getMovieClip("start_olr");
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