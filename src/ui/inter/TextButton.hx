package ui.inter;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import ui.inter.BTNVisual;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract ButtonSize(Int) from Int to Int {
	public var b230x40:Int = 0;
}
class TextButton extends Sprite
{
	public var btn:BTNVisual;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.CENTER);
	var msg:String;
	var label:TextField;
	public function new(_msg:String, _size:Int = -1) 
	{
		super();
		
		this.btn = new BTNVisual(_size);
		this.addChild(this.btn);
		
		this.label = new TextField();
		this.addChild(this.label);
		this.setSize(_size);
		this.label.defaultTextFormat = this.font;
		this.label.text = _msg;
		this.label.selectable = false;
		this.label.mouseEnabled = false;
	}
	
	function setSize(_size:Int) 
	{
		switch(_size) {
			default:
			case 0:
				this.label.width = 230;
				this.label.y = 10;
		}
	}
}