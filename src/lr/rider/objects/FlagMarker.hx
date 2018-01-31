package lr.rider.objects;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.display.LineScaleMode;
import openfl.display.CapsStyle;
import openfl.display.JointStyle;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class FlagMarker extends Sprite
{
	private var time:TextField;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 5, 0, null, null, null, null, null, TextFormatAlign.RIGHT);
	public function new(_frames:Int) 
	{
		super();
		
		this.graphics.clear();
		this.graphics.lineStyle(1, 0x333333, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
		this.graphics.beginFill(0x666666, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(0, -12);
		this.graphics.lineTo(8, -10);
		this.graphics.lineTo(0, -8);
		
		this.time = new TextField();
		this.addChild(this.time);
		this.time.x = -this.time.width;
		this.time.y = -16;
		this.time.defaultTextFormat = font;
		this.time.text = Common.time(_frames);
		this.time.selectable = false;
		
		this.mouseChildren = false;
	}
	
}