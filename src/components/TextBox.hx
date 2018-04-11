package components;

import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import flash.text.TextFieldType;
import openfl.events.MouseEvent;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class TextBox extends Sprite
{
	private var corner_tl:Sprite;
	private var corner_tr:Sprite;
	private var corner_bl:Sprite;
	private var corner_br:Sprite;
	private var edge_top:Sprite;
	private var edge_bot:Sprite;
	private var edge_left:Sprite;
	private var edge_right:Sprite;
	private var fill:Sprite;
	private var fontA:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	private var fontB:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0xAAAAAA, null, null, null, null, null, TextFormatAlign.LEFT);
	
	public var field:TextField;
	
	private var textHeight:Int = 30;
	private var textWidth:Int = 250;
	
	public var preview:String = "";
	public var isPreview:Bool = false;
	public var focus:Bool = false;
	
	public function new(_width:Int = 250, _height:Int = 30, _msg:String = "", _preview:String = "") 
	{
		super();
		
		this.fill = Common.OLR_Assets.getMovieClip("TextFill");
		this.addChild(this.fill);
		this.fill.height = _height;
		this.fill.width = _width;
		
		this.preview = _preview;
		
		this.field = new TextField();
		this.addChild(this.field);
		this.field.width = _width -2;
		this.field.height = _height -2;
		this.field.x = this.field.y = 2;
		this.field.text = _msg;
		this.field.type = TextFieldType.INPUT;
		this.addEventListener(MouseEvent.MOUSE_DOWN, this.updateField);
		this.addEventListener(MouseEvent.MOUSE_OVER, this.toggleCaseOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.toggleCaseOut);
		
		this.update();
	}
	
	function toggleCaseOver(e:MouseEvent):Void 
	{
		trace("halp");
		if (focus) {
			Lib.current.stage.removeEventListener(MouseEvent.CLICK, this.clickOffUpdate);
		}
	}
	function toggleCaseOut(e:MouseEvent):Void 
	{
		trace("COUGH");
		if (focus) {
			Lib.current.stage.addEventListener(MouseEvent.CLICK, this.clickOffUpdate);
		}
	}
	function updateField(e:MouseEvent):Void 
	{
		this.focus = true;
		this.update();
	}
	function clickOffUpdate(e:MouseEvent) {
		this.focus = false;
		this.update();
	}
	function update() 
	{
		if (focus) {
			if (this.field.text == "" || this.isPreview) {
				if (this.isPreview) {
					this.field.text = "";
					this.field.setTextFormat(fontA);
					this.isPreview = false;
				} else {
					this.field.text = this.preview;
					this.field.setTextFormat(fontB);
				}
			}
		} else if (!focus) {
			if (this.field.text == "" || !this.isPreview) {
				if (!this.isPreview) {
					this.field.text = this.preview;
					this.field.setTextFormat(fontB);
					this.isPreview = true;
				} else {
					this.field.setTextFormat(fontA);
				}
			}
		}
	}
}