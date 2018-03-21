package lr.rider.objects;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;
import openfl.events.MouseEvent;

#if (flash)
	import openfl.Assets;
#end

#if sys
	import global.Common;
#end

import lr.menus.StartpointMenu;
/**
 * ...
 * @author Kaelan Evans
 */
class StartPointVis extends Sprite
{
	public static var menuAlreadyOpen:Bool = false;
	var start_a:Sprite;
	var start_b:Sprite;
	var start_outline:Sprite;
	var rider_index:Int = -1;
	public function new(_index:Int) 
	{
		super();
		
		this.rider_index = _index;
		
		var innerClip_a:Sprite;
		var innerClip_b:Sprite;
		var innerClip_c:Sprite;
			
		#if (!flash)
			innerClip_a = Common.OLR_Assets.getMovieClip("start_a");
			innerClip_b = Common.OLR_Assets.getMovieClip("start_b");
			innerClip_c = Common.OLR_Assets.getMovieClip("start_outline");
		#elseif (flash)
			innerClip_a = Assets.getMovieClip ("swf-library:start_a");
			innerClip_b = Assets.getMovieClip ("swf-library:start_b");
			innerClip_c = Assets.getMovieClip ("swf-library:start_outline");
		#end
		
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
		
		this.mouseChildren = false;
		this.doubleClickEnabled = true;
		this.addEventListener(MouseEvent.DOUBLE_CLICK, this.edit_properties);
		
		this.menu = new StartpointMenu(this.rider_index, this.exit_properties);
	}
	public function set_color(a:Int, b:Int) {
		this.start_a.transform.colorTransform = new ColorTransform(((a >> 16) & 0xff) / 255, ((a >> 8) & 0xff) / 255, ((a & 0xff) / 255));
		this.start_b.transform.colorTransform = new ColorTransform(((b >> 16) & 0xff) / 255, ((b >> 8) & 0xff) / 255, ((b & 0xff) / 255));
	}
	var menu:StartpointMenu;
	function edit_properties(e:MouseEvent):Void 
	{
		this.removeEventListener(MouseEvent.DOUBLE_CLICK, this.edit_properties);
		this.doubleClickEnabled = false;
		this.mouseChildren = true;
		
		Lib.current.stage.addChild(this.menu);
		this.menu.x = 20;
		this.menu.y = 25;
	}
	function exit_properties(e:MouseEvent) {
		this.mouseChildren = false;
		this.doubleClickEnabled = true;
		this.addEventListener(MouseEvent.DOUBLE_CLICK, this.edit_properties);
		
		Lib.current.stage.removeChild(this.menu);
	}
}