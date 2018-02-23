package ui.inter;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.utils.Assets;
import openfl.events.MouseEvent;
import openfl.utils.Function;

import lr.tool.IconBase;
import lr.tool.IconButton;

/**
 * ...
 * @author Kaelan Evans
 */
class TextButton extends Sprite
{
	public var button:IconButton;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.CENTER);
	var msg:String;
	var label:TextField;
	var action:Dynamic;
	public function new(_msg:String, _action:Function = null)
	{
		super();
		
		this.button = new IconButton(Icon.generic);
		this.addChild(this.button);
		
		this.label = new TextField();
		this.addChild(this.label);
		this.label.width = 200;
		this.label.height = 35;
		this.label.y = 2;
		this.label.defaultTextFormat = this.font;
		this.label.text = _msg;
		this.label.selectable = false;
		this.label.mouseEnabled = false;
		
		if (_action != null) {
			this.button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
				_action();
			});
		}
	}
}