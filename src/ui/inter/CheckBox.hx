package ui.inter;

import openfl.display.MovieClip;
import openfl.Lib;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Kaelan Evans
 */
class CheckBox extends MovieClip
{
	var status:Bool = false;
	public var box:MovieClip;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 12, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	var label:TextField;
	public function new(_label:String = "Check Box", _status:Bool = false) {
		super();
		status = _status;
		box = new MovieClip();
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