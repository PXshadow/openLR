package ui.inter;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.SimpleButton;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract ButtonSize(Int) from Int to Int {
	public var b230x40:Int = 0;
	public var b120x30:Int = 1;
}
class TextButton extends Sprite
{
	public var btn:BTNVisual;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.CENTER);
	var msg:String;
	var label:TextField;
	var action:Dynamic;
	public function new(_msg:String, _action:Dynamic, _size:Int = -1) 
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
		
		this.btn.addEventListener(MouseEvent.CLICK, _action);
	}
	
	function setSize(_size:Int) 
	{
		switch(_size) {
			default:
			case 0:
				this.label.width = 230;
				this.label.height = 30;
				this.label.y = 10;
			case 1:
				this.label.width = 120;
				this.label.height = 25;
				this.label.y = 5;
		}
	}
}

class BTNVisual extends SimpleButton
{

	public inline function new(_size) 
	{
		super();
		switch(_size) {
			default:
			case 0:
				this.upState = new Bitmap(Assets.getBitmapData("img/ui/230x40up.png"));
				this.overState = new Bitmap(Assets.getBitmapData("img/ui/230x40over.png"));
				this.downState = new Bitmap(Assets.getBitmapData("img/ui/230x40down.png"));
				this.hitTestState = new Bitmap(Assets.getBitmapData("img/ui/230x40up.png"));
			case 1:
				this.upState = new Bitmap(Assets.getBitmapData("img/ui/120x30up.png"));
				this.overState = new Bitmap(Assets.getBitmapData("img/ui/120x30over.png"));
				this.downState = new Bitmap(Assets.getBitmapData("img/ui/120x30down.png"));
				this.hitTestState = new Bitmap(Assets.getBitmapData("img/ui/120x30up.png"));
		}
	}
	
}