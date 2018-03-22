package lr.menus;

import flash.events.Event;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import global.Common;
import global.engine.RiderManager;
import lr.tool.IconButton;
import lr.tool.ToolBase;

import haxe.ui.Toolkit;
import haxe.ui.components.CheckBox;
import haxe.ui.components.HSlider;
import haxe.ui.components.Label;
import haxe.ui.core.UIEvent;

/**
 * ...
 * @author Kaelan Evans
 */
class StartpointMenu extends Sprite
{
	var index:Int = -1;
	
	var exit_button:IconButton;
	
	var label_rider:Label;
	
	var slider_ra:HSlider;
	var slider_ga:HSlider;
	var slider_ba:HSlider;
	
	var slider_rb:HSlider;
	var slider_gb:HSlider;
	var slider_bb:HSlider;
	
	var swatch_a:Swatch;
	var swatch_b:Swatch;
	
	var color_a:Int;
	var color_b:Int;
	
	var color_ra:Int;
	var color_ga:Int;
	var color_ba:Int;
	
	var color_rb:Int;
	var color_gb:Int;
	var color_bb:Int;
	
	public function new(_index:Int, _name:String, _exit:Dynamic, _colors:Array<Int>) 
	{
		super();
		
		this.index = _index;
		
		this.addEventListener(MouseEvent.MOUSE_OVER, this.temToolDis);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.temToolDisDis);
		
		this.color_a = _colors[0];
		this.color_b = _colors[1];
		
		this.swatch_a = new Swatch();
		this.swatch_b = new Swatch();
		
		this.color_ra = (this.color_a >> 16) & 0xff;
		this.color_ga = (this.color_a >> 8) & 0xff;
		this.color_ba = this.color_a & 0xff;
		
		this.color_rb = (this.color_b >> 16) & 0xff;
		this.color_gb = (this.color_b >> 8) & 0xff;
		this.color_bb = this.color_b & 0xff;
		
		//this.mouseChildren = false;
		
		Toolkit.init();
		
		this.exit_button = new IconButton("no");
		this.addChild(this.exit_button);
		this.exit_button.x = 365;
		this.exit_button.y = 5;
		this.exit_button.addEventListener(MouseEvent.CLICK, _exit);
		
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(400, 0);
		this.graphics.lineTo(400, 400);
		this.graphics.lineTo(0, 400);
		this.graphics.lineTo(0, 0);
		
		this.label_rider = new Label();
		this.addChild(this.label_rider);
		this.label_rider.x = 5;
		this.label_rider.y = 5;
		this.label_rider.text = "Rider Properties (#" + (index + 1) + ")";
		
		this.addChild(this.swatch_a);
		this.swatch_a.x = 10;
		this.swatch_a.y = 25;
		this.swatch_a.update(this.color_a);
		
		this.slider_ra = new HSlider();
		this.slider_ra.min = 0;
		this.slider_ra.max = 255;
		this.slider_ra.width = 255;
		this.addChild(this.slider_ra);
		this.slider_ra.x = 5;
		this.slider_ra.y = 55;
		this.slider_ra.value = this.color_ra;
		this.slider_ra.onChange = function(e:UIEvent):Void {
			this.set_color_ra(this.slider_ra.value);
		}
		
		this.slider_ga = new HSlider();
		this.slider_ga.min = 0;
		this.slider_ga.max = 255;
		this.slider_ga.width = 255;
		this.addChild(this.slider_ga);
		this.slider_ga.x = 5;
		this.slider_ga.y = 75;
		this.slider_ga.value = this.color_ga;
		this.slider_ga.onChange = function(e:UIEvent):Void {
			this.set_color_ga(this.slider_ga.value);
		}
		
		this.slider_ba = new HSlider();
		this.slider_ba.min = 0;
		this.slider_ba.max = 255;
		this.slider_ba.width = 255;
		this.addChild(this.slider_ba);
		this.slider_ba.x = 5;
		this.slider_ba.y = 95;
		this.slider_ba.value = this.color_ba;
		this.slider_ba.onChange = function(e:UIEvent):Void {
			this.set_color_ba(this.slider_ba.value);
		}
		
		this.addChild(this.swatch_b);
		this.swatch_b.x = 10;
		this.swatch_b.y = 115;
		this.swatch_b.update(this.color_b);
		
		this.slider_rb = new HSlider();
		this.slider_rb.min = 0;
		this.slider_rb.max = 255;
		this.slider_rb.width = 255;
		this.addChild(this.slider_rb);
		this.slider_rb.x = 5;
		this.slider_rb.y = 145;
		this.slider_rb.value = this.color_rb;
		this.slider_rb.onChange = function(e:UIEvent):Void {
			this.set_color_rb(this.slider_rb.value);
		}
		
		this.slider_gb = new HSlider();
		this.slider_gb.min = 0;
		this.slider_gb.max = 255;
		this.slider_gb.width = 255;
		this.addChild(this.slider_gb);
		this.slider_gb.x = 5;
		this.slider_gb.y = 165;
		this.slider_gb.value = this.color_gb;
		this.slider_gb.onChange = function(e:UIEvent):Void {
			this.set_color_gb(this.slider_gb.value);
		}
		
		this.slider_bb = new HSlider();
		this.slider_bb.min = 0;
		this.slider_bb.max = 255;
		this.slider_bb.width = 255;
		this.addChild(this.slider_bb);
		this.slider_bb.x = 5;
		this.slider_bb.y = 185;
		this.slider_bb.value = this.color_bb;
		this.slider_bb.onChange = function(e:UIEvent):Void {
			this.set_color_bb(this.slider_bb.value);
		}
	}
	
	function temToolDisDis(e:Event):Void 
	{
		Common.gToolBase.set_tool(ToolBase.lastTool);
	}
	
	function temToolDis(e:Event):Void 
	{
		Common.gToolBase.set_tool("None");
	}
	function set_color_ra(_v:Int) {
		this.update_color_a(_v, this.color_ga, this.color_ba);
		this.color_ra = _v;
	}
	function set_color_ga(_v:Int) {
		this.update_color_a(this.color_ra, _v, this.color_ba);
		color_ga = _v;
	}
	function set_color_ba(_v:Int) {
		this.update_color_a(this.color_ra, this.color_ga, _v);
		color_ba = _v;
	}
	function update_color_a(_r:Int, _g:Int, _b:Int) {
		color_a = Common.rgb_to_hex(_r, _g, _b);
		this.swatch_a.update(this.color_a);
		Common.gRiderManager.set_rider_colors(this.index, this.color_a, this.color_b);
	}
	function set_color_rb(_v:Int) {
		this.update_color_b(_v, this.color_gb, this.color_bb);
		this.color_rb = _v;
	}
	function set_color_gb(_v:Int) {
		this.update_color_b(this.color_rb, _v, this.color_bb);
		color_gb = _v;
	}
	function set_color_bb(_v:Int) {
		this.update_color_b(this.color_rb, this.color_gb, _v);
		color_bb = _v;
	}
	function update_color_b(_r:Int, _g:Int, _b:Int) {
		color_b = Common.rgb_to_hex(_r, _g, _b);
		this.swatch_b.update(this.color_b);
		Common.gRiderManager.set_rider_colors(this.index, this.color_a, this.color_b);
	}
}
class Swatch extends Sprite {
	public function new(_fill:Int = 0) {
		super();
		this.update(_fill);
	}
	public function update(_fill:Int) {
		this.graphics.clear();
		this.graphics.beginFill(_fill, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(25, 0);
		this.graphics.lineTo(25, 25);
		this.graphics.lineTo(0, 25);
		this.graphics.lineTo(0, 0);
	}
}