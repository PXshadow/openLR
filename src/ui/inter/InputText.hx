package ui.inter;

import openfl.Assets;
import openfl.display.MovieClip;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import global.Common;

/**
 * ...
 * @author ...
 */
class InputText extends MovieClip
{
	public var input_field:TextField;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	public function new(_msg:String = "") 
	{
		super();
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(200, 0);
		this.graphics.lineTo(200, 25);
		this.graphics.lineTo(0, 25);
		this.graphics.lineTo(0, 0);
		
		this.input_field = new TextField();
		this.addChild(this.input_field);
		this.input_field.type = TextFieldType.INPUT;
		this.input_field.defaultTextFormat = font;
		this.input_field.text = _msg;
		this.input_field.width = 195;
		this.input_field.height = 24;
	}
	
}