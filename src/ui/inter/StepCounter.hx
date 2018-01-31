package ui.inter;

import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class StepCounter extends Sprite
{
	private var min:Float;
	private var max:Float;
	private var step:Float;
	private var count:Float;
	public var stepUp:StepButton;
	public var stepDown:StepButton;
	var label:TextField;
	public var unit:String = "";
	public function new() 
	{
		super();
		
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(120, 0);
		this.graphics.lineTo(120, 24);
		this.graphics.lineTo(0, 24);
		this.graphics.lineTo(0, 0);
		
		this.stepUp = new StepButton(0);
		this.addChild(stepUp);
		this.stepUp.x = 94;
		this.stepUp.y = 0;
		
		this.stepDown = new StepButton(1);
		this.addChild(stepDown);
		stepDown.x = 94;
		stepDown.y = 12;
		
		this.label = new TextField();
		this.label.defaultTextFormat = Common.font_vb_right(16);
		this.label.width = 94;
		this.label.height = 24;
		this.label.selectable = false;
		this.addChild(this.label);
	}
	public function set_numeric_mode(_min:Float, _max:Float, _step:Float, _default:Float, _unit:String)
	{
		this.min = _min;
		this.max = _max;
		this.step = _step;
		this.count = _default;
		unit = _unit;
		this.label.text = _default + unit;
	}
	public function inc():Float
	{
		if (this.count < this.max) {
			this.count += this.step;
		}
		if (count > this.max) {
			this.count = this.max;
		}
		this.label.text = this.count + unit;
		return(this.count);
	}
	public function dec():Float
	{
		if (this.count > this.min) {
			this.count -= this.step;
		}
		if (count < this.min) {
			this.count = this.min;
		}
		this.label.text = this.count + unit;
		return(this.count);
	}
}
class StepButton extends Sprite
{
	private var dir:Int = 0;
	public function new (_dir:Int)
	{
		super();
		dir = _dir;
		
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(26, 0);
		this.graphics.lineTo(26, 12);
		this.graphics.lineTo(0, 12);
		this.graphics.lineTo(0, 0);
		this.graphics.endFill();
		
		if (dir == 0) {
			this.graphics.moveTo(10, 7);
			this.graphics.lineTo(13, 3);
			this.graphics.lineTo(16, 7);
		} else if (dir == 1) {
			this.graphics.moveTo(10, 5);
			this.graphics.lineTo(13, 9);
			this.graphics.lineTo(16, 5);
		}
		
		this.addEventListener(MouseEvent.MOUSE_OVER, highlight);
		this.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
	}
	
	private function dehighlight(e:MouseEvent):Void 
	{
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(26, 0);
		this.graphics.lineTo(26, 12);
		this.graphics.lineTo(0, 12);
		this.graphics.lineTo(0, 0);
		this.graphics.endFill();
		
		if (dir == 0) {
			this.graphics.moveTo(10, 7);
			this.graphics.lineTo(13, 3);
			this.graphics.lineTo(16, 7);
		} else if (dir == 1) {
			this.graphics.moveTo(10, 5);
			this.graphics.lineTo(13, 9);
			this.graphics.lineTo(16, 5);
		}
		Mouse.cursor = MouseCursor.AUTO;
	}
	
	private function highlight(e:MouseEvent):Void 
	{
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xCCCCCCC, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(26, 0);
		this.graphics.lineTo(26, 12);
		this.graphics.lineTo(0, 12);
		this.graphics.lineTo(0, 0);
		this.graphics.endFill();
		
		if (dir == 0) {
			this.graphics.moveTo(10, 7);
			this.graphics.lineTo(13, 3);
			this.graphics.lineTo(16, 7);
		} else if (dir == 1) {
			this.graphics.moveTo(10, 5);
			this.graphics.lineTo(13, 9);
			this.graphics.lineTo(16, 5);
		}
		
		Mouse.cursor = MouseCursor.BUTTON;
	}
}