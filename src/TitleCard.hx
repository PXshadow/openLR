package;

#if (cpp || js)
	import openfl.display.Sprite;
#elseif (flash)
	import flash.display.Sprite;
#end
import openfl.text.TextField;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.MouseEvent;
import openfl.Assets;

import global.Common;
import global.Language;
import ui.inter.TextButton;

/**
 * ...
 * @author Kaelan Evans
 */
class TitleCard extends Sprite
{
	private var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 24, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	private var font_b:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	
	var title:TextField;
	var title_info:TextField;
	var splash:TextField;
	var version_info:TextField;
	
	var new_track:TextButton;
	var load_track:TextButton;
	
	public function new() 
	{
		super();
		
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.lineStyle(3, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(600, 0);
		this.graphics.lineTo(600, 300);
		this.graphics.lineTo(0, 300);
		this.graphics.lineTo(0, 0);
		this.graphics.endFill();
		
		this.title = new TextField();
		this.addChild(this.title);
		this.title.selectable = false;
		this.title.x = this.title.y = 6;
		this.title.defaultTextFormat = this.font_a;
		this.title.width = 120;
		this.title.text = "OpenLR";
		
		this.title_info = new TextField();
		this.addChild(this.title_info);
		this.title_info.selectable = false;
		this.title_info.defaultTextFormat = this.font_b;
		this.title_info.x = 120;
		this.title_info.y = 16;
		this.title_info.width = 500;
		this.title_info.text = Language.Title;
		
		this.graphics.moveTo(8, 44);
		this.graphics.lineTo(592, 44);
		
		this.splash = new TextField();
		this.addChild(this.splash);
		this.splash.x = 8;
		this.splash.y = 54;
		this.splash.defaultTextFormat = this.font_b;
		this.splash.wordWrap = true;
		this.splash.width = 592;
		this.splash.height = 246;
		this.splash.text = Language.Splash_a + "\n\n" + "https://github.com/kevansevans/openLR" + "\n\n" + Language.Splash_b;
		
		this.new_track = new TextButton(Language.New_track, this.new_track_func, ButtonSize.b120x30);
		this.addChild(this.new_track);
		this.new_track.x = 8;
		this.new_track.y = 200;
		
		this.load_track = new TextButton(Language.Load_track, this.load_track_func, ButtonSize.b120x30);
		this.addChild(this.load_track);
		this.load_track.x = 8;
		this.load_track.y = 245;
		
		this.version_info = new TextField();
		this.addChild (this.version_info);
		this.version_info.width = 584;
		this.version_info.selectable = false;
		var _locString0:String = "Version " + Common.version;
		var _locString1:String = "";
		#if (cpp)
			_locString1= Sys.systemName();
		#end
		#if (cpp)
			_locString0 = _locString0 + " C++ " + _locString1;
		#elseif (flash)
			_locString0 = _locString0 + " Flash " + _locString1;
		#elseif (js) 
			_locString0 = _locString0 + " JavaScript/HTML5 " + _locString1;
		#else
			_locString0 = _locString0 + " NaKP " + _locString1;
		#end
		#if (debug)
			_locString0 = _locString0 + " Debug";
		#else
			_locString0 = _locString0 + " Release";
		#end
		this.version_info.text = _locString0;
		this.version_info.x = 8;
		this.version_info.y = 280;
	}
	private function load_track_func(e:MouseEvent):Void 
	{
		Common.gCode.start(true);
	}
	private function new_track_func(e:MouseEvent):Void 
	{
		Common.gCode.start();
	}
}