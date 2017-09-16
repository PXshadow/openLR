package ui.inter;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.Assets;
import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Kaelan Evans
 */
class CheckBox extends Sprite
{
	var status:Bool = false;
	private var box:Sprite;
	public var hitBox:SimpleButton;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 12, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	var label:TextField;
	public function new(_label:String = "Check Box", _status:Bool = false) {
		super();
		status = _status;
		box = new Sprite();
		this.addChild(box);
		label = new TextField();
		label.defaultTextFormat = font;
		label.selectable = false;
		this.addChild(label);
		this.label.x = 16;
		this.label.y = -2;
		this.label.text = _label;
		this.label.height = 18;
		this.label.mouseEnabled = false;
		this.hitBox = new SimpleButton();
		this.hitBox.hitTestState = new Bitmap(Assets.getBitmapData("img/checkbox_hitzone.png"));
		this.addChild(this.hitBox);
		this.render();
	}
	public function toggle():Bool
	{
		if (status) {
			status = false;
		} else if (!status) {
			status = true;
		}
		this.render();
		return(status);
	}
	public function update(_stat:Bool) {
		this.status = _stat;
		this.render();
	}
	public function render() {
		this.box.graphics.clear();
		this.box.graphics.lineStyle(2, 0, 1);
		if (!status) {
			this.box.graphics.beginFill(0xFFFFFF, 1);
		} else if (status) {
			this.box.graphics.beginFill(0x00CC00, 1);
		}
		this.box.graphics.moveTo(0, 0);
		this.box.graphics.lineTo(15, 0);
		this.box.graphics.lineTo(15, 15);
		this.box.graphics.lineTo(0, 15);
		this.box.graphics.lineTo(0, 0);
	}
}