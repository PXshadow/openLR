package components;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import global.Common;
import lr.tool.IconButton;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract WindowMode(Int) from Int {
	public var CONFIRM:Int = 0;
	public var ACKNOWLEDGE:Int = 1;
	public var ERROR:Int = 2;
	public var MENU:Int = 3;
	public var CUSTOM:Int = 4;
	public var PROGRESS:Int = 4;
}
class WindowBox extends Sprite
{
	private var fontA:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 16, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.LEFT);
	private var fontB:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 12, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	
	private var windowBar:Sprite;
	private var barLabel:TextField;
	private var positive:IconButton;
	private var negative:IconButton;
	private var frowny:IconButton;
	
	private var wWidth:Int;
	private var wHeight:Int;
	
	private var message:TextField;
	
	public var drag(default, set):Bool = false;
	
	public function new(_title:String, _type:Int, _width:Int = 255, _height:Int = 255) 
	{
		super();
		
		this.wWidth = _width;
		this.wHeight = _height;
		
		this.windowBar = Common.OLR_Assets.getMovieClip("WindowBar");
		this.addChild(this.windowBar);
		this.windowBar.width = _width;
		
		this.barLabel = new TextField();
		this.barLabel.setTextFormat(this.fontA);
		this.addChild(this.barLabel);
		this.barLabel.x = 2;
		this.barLabel.y = 4;
		this.barLabel.width = this.windowBar.width - 30;
		this.barLabel.text = _title;
		this.barLabel.selectable = false;
		this.barLabel.mouseEnabled = false;
		
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 30);
		this.graphics.lineTo(0, _height + 30);
		this.graphics.lineTo(_width, _height + 30);
		this.graphics.lineTo(_width, 30);
		this.graphics.lineTo(0, 30);
		
		switch(_type) {
			case WindowMode.CONFIRM :
				this.set_confirm();
			case WindowMode.ACKNOWLEDGE :
				this.set_acknowledge();
			case WindowMode.ERROR :
				this.set_error();
		}
	}
	function set_error() 
	{
		this.frowny = new IconButton("error");
		
		this.addChild(this.frowny);
		
		this.frowny.y = this.height - 40;
		this.frowny.x = (this.width / 2) - (this.frowny.width / 2);
		
		this.enable_message();
		
		this.message.selectable = true;
	}
	function set_acknowledge() 
	{
		this.positive = new IconButton("yes");
		
		this.addChild(this.positive);
		
		this.positive.y = this.height - 40;
		this.positive.x = (this.width / 2) - (this.positive.width / 2);
		
		this.enable_message();
	}
	function set_confirm() 
	{
		this.positive = new IconButton("yes");
		this.negative = new IconButton("no");
		
		this.addChild(this.positive);
		this.addChild(this.negative);
		
		this.positive.y = this.height - 40;
		this.positive.x = (this.width / 2) - 40;
		
		this.negative.y = this.height - 40;
		this.negative.x = (this.width / 2) + 10;
		
		this.enable_message();
	}
	
	function enable_message() 
	{
		this.message = new TextField();
		this.message.setTextFormat(this.fontB);
		this.addChild(this.message);
		this.message.x = 2;
		this.message.y = 32;
		this.message.width = this.wWidth - 2;
		this.message.height = this.wHeight - 50;
		this.message.selectable = false;
		this.message.wordWrap = true;
	}
	public function set_message_string(_input:String) {
		this.message.text = _input;
	}
	function set_drag(_bool) {
		if (_bool) {
			this.windowBar.addEventListener(MouseEvent.MOUSE_DOWN, this.drag_window);
			this.windowBar.addEventListener(MouseEvent.MOUSE_UP, this.stop_drag);
		} else {
			this.windowBar.removeEventListener(MouseEvent.MOUSE_DOWN, this.drag_window);
			this.windowBar.removeEventListener(MouseEvent.MOUSE_UP, this.stop_drag);
		}
		return this.drag = _bool;
	}
	
	function stop_drag(e:MouseEvent):Void 
	{
		this.stopDrag();
	}
	
	function drag_window(e:MouseEvent):Void 
	{
		this.startDrag();
	}
}