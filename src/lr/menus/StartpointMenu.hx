package lr.menus;

import openfl.events.Event;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import global.Common;
import global.engine.RiderManager;
import global.SVar;
import lr.tool.IconButton;
import lr.tool.ToolBase;
import components.WindowBox;
import components.HSlider;

import haxe.ui.Toolkit;
import haxe.ui.components.TextField;
import haxe.ui.core.UIEvent;

/**
 * ...
 * @author Kaelan Evans
 */
class StartpointMenu extends Sprite
{
	var window:WindowBox;
	
	var index:Int = -1;
	
	var exit_button:IconButton;
	
	var input_name:TextField;
	
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
		
		Toolkit.init();
		
		this.window = new WindowBox("Rider properties #" + (_index + 1), WindowMode.MENU);
		this.window.negative.addEventListener(MouseEvent.CLICK, _exit);
		this.window.drag = true;
		this.addChild(this.window);
		
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
		
		this.input_name = new TextField();
		this.addChild(this.input_name);
		this.input_name.x = 5;
		this.input_name.y = 5;
		this.input_name.text = _name;
		this.input_name.onChange = function(e:UIEvent) {
			this.set_rider_name(this.input_name.text);
		}
		this.window.add_item(this.input_name, false, true);
		
		this.window.add_item(this.swatch_a, false, true, 0, 35);
		this.swatch_a.update(this.color_a);
		
		this.slider_ra = new HSlider(0, 255, this.color_ra);
		this.slider_ra.setColors(0xFF0000, 0xFFFFFF, 0);
		this.window.add_item(this.slider_ra);
		this.slider_ra.onChange = function() {
			this.set_color_ra(Std.int(this.slider_ra.value));
		}
		
		this.slider_ga = new HSlider(0, 255, this.color_ga);
		this.slider_ga.setColors(0x00FF00, 0xFFFFFF, 0);
		this.window.add_item(this.slider_ga);
		this.slider_ga.onChange = function():Void {
			this.set_color_ga(Std.int(this.slider_ga.value));
		}
		
		this.slider_ba = new HSlider(0, 255, this.color_ba);
		this.slider_ba.setColors(0x0000FF, 0xFFFFFF, 0);
		this.window.add_item(this.slider_ba, false, true);
		this.slider_ba.onChange = function():Void {
			this.set_color_ba(Std.int(this.slider_ba.value));
		}
		
		this.window.add_item(this.swatch_b, false, true);
		this.swatch_b.update(this.color_b);
		
		this.slider_rb = new HSlider(0, 255, this.color_rb);
		this.slider_rb.setColors(0xFF0000, 0xFFFFFF, 0);
		this.window.add_item(this.slider_rb);
		this.slider_rb.onChange = function():Void {
			this.set_color_rb(Std.int(this.slider_rb.value));
		}
		
		this.slider_gb = new HSlider(0, 255, this.color_gb);
		this.slider_gb.setColors(0x00FF00, 0xFFFFFF, 0);
		this.window.add_item(this.slider_gb);
		this.slider_gb.onChange = function():Void {
			this.set_color_gb(Std.int(this.slider_gb.value));
		}
		
		this.slider_bb = new HSlider(0, 255, this.color_bb);
		this.slider_bb.setColors(0x0000FF, 0xFFFFFF, 0);
		this.window.add_item(this.slider_bb);
		this.slider_bb.onChange = function():Void {
			this.set_color_bb(Std.int(this.slider_bb.value));
		}
	}
	function set_rider_name(_name:String) {
		Common.gRiderManager.set_rider_name(this.index, _name);
	}
	function temToolDisDis(e:Event):Void 
	{
		Common.gToolBase.set_tool(ToolBase.lastTool);
		SVar.game_mode = GameState.edit;
	}
	
	function temToolDis(e:Event):Void 
	{
		Common.gToolBase.set_tool("None");
		SVar.game_mode = GameState.inmenu;
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
		this.graphics.lineStyle(1, 0);
		this.graphics.beginFill(_fill, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(25, 0);
		this.graphics.lineTo(25, 25);
		this.graphics.lineTo(0, 25);
		this.graphics.lineTo(0, 0);
	}
}