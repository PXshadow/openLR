package platform.titlecards;

//primary
import flash.text.Font;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;
import ui.inter.TextButton;

//secondary
import platform.TitleCardBase;
import global.Common;
import global.Language;

//third party

/**
 * ...
 * @author Kaelan Evans
 */
class TitleCardFL extends TitleCardBase
{
	var title:TextField;
	var title_info:TextField;
	var splash:TextField;
	
	var new_track:TextButton;
	
	private var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 24, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	private var font_b:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	
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
		this.title.defaultTextFormat = font_a;
		this.addChild(this.title);
		this.title.selectable = false;
		this.title.x = this.title.y = 6;
		this.title.width = 120;
		this.title.text = "OpenLR";
		
		this.title_info = new TextField();
		this.addChild(this.title_info);
		this.title_info.defaultTextFormat = font_b;
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
		this.splash.defaultTextFormat = font_b;
		this.splash.x = 8;
		this.splash.y = 54;
		this.splash.wordWrap = true;
		this.splash.width = 592;
		this.splash.height = 246;
		this.splash.text = Language.Splash_a + "\n\n" + "https://github.com/kevansevans/openLR" + "\n\n" + Language.Splash_b;
		
		this.new_track = new TextButton(Language.New_track, this.new_track_func, 1);
		this.addChild(this.new_track);
		this.new_track.x = 8;
		this.new_track.y = 200;
		
		super.add_version_specs();
	}
	private function load_track_func():Void 
	{
		Common.gCode.start(true);
	}
	private function new_track_func():Void 
	{
		Common.gCode.start();
	}
}