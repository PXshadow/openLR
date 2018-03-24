package lr.rider.objects;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;

import global.Common;
import global.SVar;

import lr.menus.StartpointMenu;
/**
 * ...
 * @author Kaelan Evans
 */
class StartPointVis extends Sprite
{
	public static var menuAlreadyOpen:Bool = false;
	public static var current:StartPointVis;
	
	var start_a:Sprite;
	var start_b:Sprite;
	var color_a:Int;
	var color_b:Int;
	var start_outline:Sprite;
	var rider_index:Int = -1;
	var rider_name:String;
	var label:TextField;
	
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 4, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.RIGHT);
	
	var riderNames:Array<String> = ["Bosh", "Coco", "Fin", "Essi", "Chaz", "Blake", "Noah"];
	var riderColors:Array<Array<Int>> = [[13763074, 0xFFFFFF], [0xD977E6, 0xFFCDFF], [0x108000, 0xFFFFFF], [0x65ECFF, 0xFBCCE3], [0x1e373b, 0xb3ea44], [0x0094b4, 0xD5DDDD], [0xD20202, 0xff6464]];
	
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
		
		this.label = new TextField();
		this.addChild(this.label);
		this.label.width = 200;
		this.label.height = 35;
		this.label.defaultTextFormat = this.font;
		this.label.x = 0 - this.label.width - 2;
		this.label.y = -22;
		this.label.text = "Dummy";
		this.label.selectable = false;
		this.label.mouseEnabled = false;
	}
	public function set_rider_name(_name:String) {
		this.rider_name = _name;
		this.label.text = _name;
	}
	public function set_base_properties() {
		if (this.rider_index <= this.riderNames.length - 1) {
			this.rider_name = this.riderNames[rider_index];
			Common.gRiderManager.set_rider_colors(rider_index, this.riderColors[rider_index][0], this.riderColors[rider_index][1]);
		} else {
			this.rider_name = "New Rider #" + (rider_index + 1);
			Common.gRiderManager.set_rider_colors(rider_index, Common.randomRange(0, 0xFFFFFF), Common.randomRange(0, 0xFFFFFF));
		}
		this.label.text = this.rider_name;
		
		this.mouseChildren = false;
		this.doubleClickEnabled = true;
		this.addEventListener(MouseEvent.DOUBLE_CLICK, this.edit_properties);
		
		this.menu = new StartpointMenu(this.rider_index, this.rider_name, this.exit_properties, [color_a, color_b]);
	}
	public function set_color(a:Int, b:Int) {
		this.start_a.transform.colorTransform = new ColorTransform(((a >> 16) & 0xff) / 255, ((a >> 8) & 0xff) / 255, ((a & 0xff) / 255));
		this.start_b.transform.colorTransform = new ColorTransform(((b >> 16) & 0xff) / 255, ((b >> 8) & 0xff) / 255, ((b & 0xff) / 255));
		this.color_a = a;
		this.color_b = b;
	}
	var menu:StartpointMenu;
	function edit_properties(e:MouseEvent):Void 
	{
		if (StartPointVis.menuAlreadyOpen) {
			trace("Herp");
			StartPointVis.current.exit_properties(null);
		}
		
		SVar.game_mode = GameState.inmenu;
		
		StartPointVis.menuAlreadyOpen = true;
		StartPointVis.current = this;
		
		this.removeEventListener(MouseEvent.DOUBLE_CLICK, this.edit_properties);
		this.doubleClickEnabled = false;
		this.mouseChildren = true;
		
		Lib.current.stage.addChild(this.menu);
		this.menu.x = 20;
		this.menu.y = 25;
	}
	public function exit_properties(e:MouseEvent) {
		SVar.game_mode = GameState.edit;
		
		StartPointVis.menuAlreadyOpen = false;
		
		this.mouseChildren = false;
		this.doubleClickEnabled = true;
		this.addEventListener(MouseEvent.DOUBLE_CLICK, this.edit_properties);
		
		Lib.current.stage.removeChild(this.menu);
	}
}