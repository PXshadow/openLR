package file.ui;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;
import openfl.display.Bitmap;

import global.Common;

/**
 * ...
 * @author ...
 */
class FileItem extends Sprite
{
	public var ID:Int = 0;
	public var hitBox:FileButton;
	var filePath:String;
	var msg:TextField;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	public function new(_id:Int, _path:String) 
	{
		super();
		this.ID = _id;
		this.filePath = _path;
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(380, 0);
		this.graphics.lineTo(380, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
		
		this.msg = new TextField();
		this.msg.defaultTextFormat = font;
		this.addChild(msg);
		this.msg.x = 5;
		this.msg.y = 4;
		this.msg.width = 370;
		this.msg.text = this.filePath;
		this.msg.selectable = false;
		this.msg.mouseEnabled = false;
		
		this.hitBox = new FileButton(ID, _path, this);
		this.hitBox.hitTestState = new Bitmap(Assets.getBitmapData("img/fileitem_hitzone.png"));
		this.addChild(this.hitBox);
	}
	public function selected() {
		this.graphics.clear();
		this.graphics.beginFill(0xCCCCCC, 1);
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(380, 0);
		this.graphics.lineTo(380, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
	}
	public function deselect() {
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(380, 0);
		this.graphics.lineTo(380, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
	}
	
}