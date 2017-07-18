package ui.inter;

import openfl.display.MovieClip;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;

import global.Language;
import ui.inter.TextButton;

/**
 * ...
 * @author Kaelan Evans
 */
class AlertBox extends MovieClip
{

	private var alert_message:TextField;
	private var confirm_button:TextButton;
	private var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.CENTER);
	public function new(_msg:String, _action:Dynamic = null, _confMSG:String = null) 
	{
		super();
		
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(400, 0);
		this.graphics.lineTo(400, 200);
		this.graphics.lineTo(0, 200);
		this.graphics.lineTo(0, 0);
		
		this.alert_message = new TextField();
		this.addChild(this.alert_message);
		this.alert_message.width = 400;
		this.alert_message.height = 200;
		this.alert_message.wordWrap = true;
		this.alert_message.defaultTextFormat = font;
		this.alert_message.text = _msg;
		
		var _msg = _confMSG;
		if (_msg == null) {
			_msg = Language.Okay;
		}
		this.confirm_button = new TextButton(_msg, ButtonSize.b120x30);
		this.addChild(this.confirm_button);
		this.confirm_button.x = (this.width * 0.5) - (this.confirm_button.width * 0.5);
		this.confirm_button.y = 180;
	}
	
}