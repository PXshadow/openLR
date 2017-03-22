package ui.inter;

import openfl.Lib;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Kaelan Evans
 * 
 */
class SingleButton extends Sprite
{
	var textContainer:Sprite;
	var msg:TextField;
	var vis_box:Sprite;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	var action:Dynamic;
	public function new(_msg:String, _action:Dynamic = null) 
	{
		super();
		this.vis_box = new Sprite();
		this.textContainer = new Sprite();
		this.msg = new TextField();
		this.msg.selectable = false;
		this.msg.defaultTextFormat = font;
		this.msg.text = _msg;
		this.msg.height = 25;
		this.msg.width = (_msg.length * 11.5);
		this.textContainer.addChild(this.msg);
		this.textContainer.x = this.textContainer.y = 4;
		
		this.addChild(this.vis_box);
		this.vis_box.graphics.clear();
		this.vis_box.graphics.lineStyle(2, 0, 1);
		this.vis_box.graphics.beginFill(0xFFFFFF, 1);
		this.vis_box.graphics.moveTo(0, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, 0);
		
		this.addChild(this.textContainer);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
		this.addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
		if (_action != null) {
			this.action = _action;
			this.addEventListener(MouseEvent.CLICK, mouse_click);
		}
	}
	
	private function mouse_click(e:MouseEvent):Void 
	{
		this.action();
	}
	
	private function mouse_out(e:MouseEvent):Void 
	{
		this.vis_box.graphics.clear();
		this.vis_box.graphics.lineStyle(2, 0, 1);
		this.vis_box.graphics.beginFill(0xFFFFFF, 1);
		this.vis_box.graphics.moveTo(0, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, 0);
	}
	
	private function mouse_over(e:MouseEvent):Void 
	{
		this.vis_box.graphics.clear();
		this.vis_box.graphics.lineStyle(2, 0, 1);
		this.vis_box.graphics.beginFill(0xDDDDDD, 1);
		this.vis_box.graphics.moveTo(0, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, 0);
	}
}