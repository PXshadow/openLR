package lr.rider.objects;

import openfl.display.Sprite;
import openfl.geom.ColorTransform;

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
	
	var start_a:Sprite;
	var start_b:Sprite;
	var start_outline:Sprite;
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
			var innerClip_a:Sprite;
			var innerClip_b:Sprite;
			var innerClip_c:Sprite;
			innerClip_a = Common.OLR_Assets.getMovieClip("start_a");
			innerClip_b = Common.OLR_Assets.getMovieClip("start_b");
			innerClip_c = Common.OLR_Assets.getMovieClip("start_outline");
			
			innerClip_b.y = -11;
			innerClip_c.x = -1;
			
			this.start_outline = new Sprite();
			this.start_outline.addChild(innerClip_c);
			this.addChild(this.start_outline);
			
			this.start_b = new Sprite();
			this.start_b.addChild(innerClip_b);
			this.addChild(this.start_b);
			
			this.start_a = new Sprite();
			this.start_a.addChild(innerClip_a);
			this.addChild(this.start_a);
			
			this.scaleX = this.scaleY = 0.75;
			this.alpha = 0.75;
		}
	#elseif (flash)
		function grabFLClip() 
		{
			var innerClip_a:Sprite;
			var innerClip_b:Sprite;
			var innerClip_c:Sprite;
			innerClip_a = Assets.getMovieClip ("swf-library:start_a");
			innerClip_b = Assets.getMovieClip ("swf-library:start_b");
			innerClip_c = Assets.getMovieClip ("swf-library:start_outline");
			
			innerClip_b.y = -11;
			innerClip_c.x = -1;
			
			this.start_outline = new Sprite();
			this.start_outline.addChild(innerClip_c);
			this.addChild(this.start_outline);
			
			this.start_b = new Sprite();
			this.start_b.addChild(innerClip_b);
			this.addChild(this.start_b);
			
			this.start_a = new Sprite();
			this.start_a.addChild(innerClip_a);
			this.addChild(this.start_a);
			
			this.scaleX = this.scaleY = 0.75;
			this.alpha = 0.75;
		}
	#end
		public function set_color(a:Int, b:Int) {
			this.start_a.transform.colorTransform = new ColorTransform(((a >> 16) & 0xff) / 255, ((a >> 8) & 0xff) / 255, ((a & 0xff) / 255));
			this.start_b.transform.colorTransform = new ColorTransform(((b >> 16) & 0xff) / 255, ((b >> 8) & 0xff) / 255, ((b & 0xff) / 255));
		}
}