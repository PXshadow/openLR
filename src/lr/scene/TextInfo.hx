package lr.scene;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import global.Common;
import global.CVar;
import global.SVar;

/**
 * ...
 * @author Kaelan Evans
 * 
 * This class controls the text seen on the top right. When sim mode is added, it'll display time. Might switch it to use the color indicators instead of "Floor, Accel, Scene"
 * 
 */
class TextInfo extends Sprite
{
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 12, 0, null, null, null, null, null, TextFormatAlign.RIGHT);
	public var textInfo_A:TextField;
	public var textInfo_B:TextField;
	public var textInfo_C:TextField;
	public var textInfo_D:TextField;
	public var textInfo_E:TextField;
	public var textInfo_F:TextField;
	public var mode:Int = 0; //0 = lines, 1 = playback
	public function new() 
	{
		super();
		Common.gTextInfo = this;
		
		textInfo_A = new TextField();
		textInfo_B = new TextField();
		textInfo_C = new TextField();
		textInfo_D = new TextField();
		textInfo_F = new TextField();
		
		this.graphics.clear();
		this.graphics.beginFill(0xCCCCCC, 0.75);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(100, 0);
		this.graphics.lineTo(100, 80);
		this.graphics.lineTo(0, 80);
		this.graphics.lineTo(0, 0);
		
		textInfo_A.selectable = false;
		textInfo_B.selectable = false;
		textInfo_C.selectable = false;
		textInfo_D.selectable = false;
		textInfo_F.selectable = false;
		textInfo_A.defaultTextFormat = this.font;
		textInfo_B.defaultTextFormat = this.font;
		textInfo_C.defaultTextFormat = this.font;
		textInfo_D.defaultTextFormat = this.font;
		textInfo_F.defaultTextFormat = this.font;
		
		this.addChild(this.textInfo_A);
		this.addChild(this.textInfo_B);
		this.addChild(this.textInfo_C);
		this.addChild(this.textInfo_D);
		this.addChild(this.textInfo_F);
		
		
		this.textInfo_B.y = 15;
		this.textInfo_C.y = 30;
		this.textInfo_D.y = 45;
		this.textInfo_F.y = 75;
		
		this.update();
	}
	public function update() {
		if (mode == 0)
		{
			textInfo_A.text = SVar.lineCount + " Lines";
			textInfo_B.text = SVar.lineCount_blue + " Floor";
			textInfo_C.text = SVar.lineCount_red + " Accel";
			textInfo_D.text = SVar.lineCount_green + " Scene";
		}
	}
	public function update_sim() {
		var _locTime:String = Common.time(SVar.frames);
		
		textInfo_A.text = CVar.track_name;
		textInfo_B.text = _locTime;
		textInfo_C.text = SVar.rider_speed + " P/F";
		textInfo_D.text = SVar.rider_speed_top + " Top";
	}
}