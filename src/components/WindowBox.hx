package components;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;

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
	public var PROGRESS:Int = 5;
}
class WindowBox extends Sprite
{
	private var fontA:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 16, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.LEFT);
	private var fontB:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 12, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	
	private var type:Int = -1;
	
	private var windowBar:Sprite;
	private var barLabel:TextField;
	public var positive:IconButton;
	public var negative:IconButton;
	public var frowny:IconButton;
	
	private var wWidth:Int;
	private var wHeight:Int;
	private var fill:Int = 0xFFFFFF;
	
	var widthTracker:Float = 10;
	var heightTracker:Float = 40;
	
	private var message:TextField;
	
	public var drag(default, set):Bool = false;
	
	public function new(_title:String, _type:Int, _width:Int = 255, _height:Int = 255) 
	{
		super();
		
		this.wWidth = _width;
		this.wHeight = _height;
		this.type = _type;
		
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
		
		switch(_type) {
			case WindowMode.CONFIRM :
				this.set_confirm();
			case WindowMode.ACKNOWLEDGE :
				this.set_acknowledge();
			case WindowMode.ERROR :
				this.set_error();
			case WindowMode.MENU :
				this.set_menu();
		}
		
		this.graphics.clear();
		this.graphics.beginFill(this.fill, 1);
		this.graphics.moveTo(0, 30);
		this.graphics.lineTo(0, _height + 30);
		this.graphics.lineTo(_width, _height + 30);
		this.graphics.lineTo(_width, 30);
		this.graphics.lineTo(0, 30);
	}
	function set_error() 
	{
		this.fill = 0xFFAAAA;
		
		this.frowny = new IconButton("error");
		
		this.addChild(this.frowny);
		
		this.frowny.y = this.wHeight - 15;
		this.frowny.x = (this.wWidth / 2) - (this.frowny.width / 2);
		
		this.enable_message();
		
		this.message.selectable = true;
	}
	function set_acknowledge() 
	{
		this.fill = 0xFFFF99;
		
		this.positive = new IconButton("yes");
		
		this.addChild(this.positive);
		
		this.positive.y = this.wHeight - 40;
		this.positive.x = (this.wWidth / 2) - (this.positive.width / 2);
		
		this.enable_message();
	}
	function set_confirm() 
	{
		this.positive = new IconButton("yes");
		this.negative = new IconButton("no");
		
		this.addChild(this.positive);
		this.addChild(this.negative);
		
		this.positive.y = this.wHeight - 40;
		this.positive.x = (this.wWidth / 2) - 40;
		
		this.negative.y = this.wHeight - 40;
		this.negative.x = (this.wWidth / 2) + 10;
		
		this.enable_message();
	}
	function set_menu() {
		this.negative = new IconButton("no");
		
		this.addChild(this.negative);
		
		this.negative.x = this.wWidth - 32;
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
		this.message.autoSize = TextFieldAutoSize.LEFT;
	}
	public function set_message_string(_input:String, _resizeBox:Bool = false) {
		if (this.message == null) return;
		
		this.message.text = _input;
		
		this.message.height = this.message.textHeight;
		
		this.heightTracker += this.message.textHeight + 15;
		
		if (_resizeBox) {
			this.wHeight = Std.int(this.message.textHeight + 105);
			this.render();
		}
	}
	function set_drag(_bool) {
		if (_bool) {
			this.windowBar.addEventListener(MouseEvent.MOUSE_DOWN, this.drag_window);
			this.windowBar.addEventListener(MouseEvent.MOUSE_UP, this.stop_drag);
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, this.stop_drag);
		} else {
			this.windowBar.removeEventListener(MouseEvent.MOUSE_DOWN, this.drag_window);
			this.windowBar.removeEventListener(MouseEvent.MOUSE_UP, this.stop_drag);
			Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, this.stop_drag);
		}
		return this.drag = _bool;
	}
	function render() {
		this.windowBar.width = this.wWidth;
		
		this.graphics.clear();
		this.graphics.beginFill(this.fill, 1);
		this.graphics.moveTo(0, 30);
		this.graphics.lineTo(0, this.wHeight + 30);
		this.graphics.lineTo(this.wWidth, this.wHeight + 30);
		this.graphics.lineTo(this.wWidth, 30);
		this.graphics.lineTo(0, 30);
		
		switch (this.type) {
			case WindowMode.ACKNOWLEDGE :
				this.positive.y = this.wHeight - 40;
				this.positive.x = (this.wWidth / 2) - (this.positive.width / 2);
			case WindowMode.CONFIRM :
				this.positive.y = this.wHeight - 40;
				this.positive.x = (this.wWidth / 2) - 40;
				this.negative.y = this.wHeight - 40;
				this.negative.x = (this.wWidth / 2) + 10;
			case WindowMode.ERROR :
				this.frowny.y = this.wHeight - 15;
				this.frowny.x = (this.wWidth / 2) - (this.frowny.width / 2);
			case WindowMode.MENU :
				this.negative.x = this.wWidth - 32;
				this.negative.y = 2;
			default :
				return;
		}
	}
	function stop_drag(e:MouseEvent):Void 
	{
		this.stopDrag();
		if (this.x + this.wWidth < 0) {
			this.x = (this.wWidth * -1) + 50;
		} else if (this.x > Lib.current.stage.stageWidth) {
			this.x = Lib.current.stage.stageWidth - 50;
		}
		if (this.y < 35) {
			this.y = 35;
		} else if (this.y > Lib.current.stage.stageHeight) {
			this.y = Lib.current.stage.stageHeight - 95;
		}
	}
	function drag_window(e:MouseEvent):Void 
	{
		this.startDrag();
	}
	var hasToReturnB:Bool = false;
	public function add_item(_item:Sprite, _return:Bool = false, _returAgain:Bool = false, _ovx:Int = 0, _ovy:Int = 0) {
		var hasToResize:Bool = false;
		this.addChild(_item);
		var hasReturned:Bool = false;
		if (_return) {
			this.widthTracker = 10;
			this.heightTracker += 15 + _item.height;
			hasReturned = true;
		}
		if (_item.width + this.widthTracker > this.wWidth + 5 && !hasReturned && !hasToReturnB) {
			this.widthTracker = 10;
			this.heightTracker += 15 + _item.height;
			if (_item.width + this.widthTracker > this.wWidth + 5) {
				this.wWidth = Std.int(_item.width + 15);
				hasToResize = true;
			}
		} else if (hasToReturnB) {
			hasToReturnB = false;
		}
		if (_item.height + this.heightTracker > this.wHeight - 10) {
			this.wHeight += Std.int(_item.height + 15);
			hasToResize = true;
		}
		
		this.heightTracker += _ovy;
		this.heightTracker += _ovx;
		
		_item.x = this.widthTracker;
		_item.y = this.heightTracker;
		
		this.widthTracker += _item.width + 5;
		if (_returAgain) {
			this.widthTracker = 10;
			this.heightTracker += 15 + _item.height;
			hasToReturnB = true;
		}
		if (hasToResize) {
			this.render();
		}
	}
}