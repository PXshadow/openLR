package platform.titlecards;

//primary
import flash.text.Font;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.utils.Assets;

//secondary
import platform.TitleCardBase;
import global.Common;
import global.Language;

//third party
import haxe.ui.Toolkit;
import haxe.ui.components.Button;
import haxe.ui.core.MouseEvent;

/**
 * ...
 * @author Kaelan Evans
 */

@:font("assets/fonts/Verdana.ttf") class VerdanaNormal extends Font { }
class FontsFL {
	public static var VERDANA;
}
class TitleCardFL extends TitleCardBase
{
	var title:TextField;
	var title_info:TextField;
	var splash:TextField;
	
	var new_track:Button;
	
	public function new() 
	{
		super();
		
		Font.registerFont(VerdanaNormal);
		FontsFL.VERDANA = new VerdanaNormal().fontName;
		
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
		this.title.width = 120;
		this.title.text = "OpenLR";
		this.title.defaultTextFormat = new TextFormat(FontsFL.VERDANA, 24, 0xCC00CC);
		
		trace(FontsFL.VERDANA);
		
		this.title_info = new TextField();
		this.addChild(this.title_info);
		this.title_info.selectable = false;
		this.title_info.x = 120;
		this.title_info.y = 16;
		this.title_info.width = 500;
		this.title_info.text = Language.Title;
		
		this.graphics.lineStyle(3, 0, 1);
		this.graphics.moveTo(8, 44);
		this.graphics.lineTo(592, 44);
		
		this.splash = new TextField();
		this.addChild(this.splash);
		this.splash.x = 8;
		this.splash.y = 54;
		this.splash.wordWrap = true;
		this.splash.width = 592;
		this.splash.height = 246;
		this.splash.text = Language.Splash_a + "\n\n" + "https://github.com/kevansevans/openLR" + "\n\n" + Language.Splash_b;
		
		this.new_track  = new Button();
		this.new_track .text = "New Track";
		this.new_track .fontSize = 16;
		this.addChild(this.new_track);
		this.new_track.x = 8;
		this.new_track.y = 200;
		this.new_track.onClick = function(e:MouseEvent) { 
			this.new_track_func();
		}
		
		super.add_version_specs();
	}
	private function load_track_func(e:MouseEvent):Void 
	{
		Common.gCode.start(true);
	}
	private function new_track_func():Void 
	{
		Common.gCode.start();
	}
}