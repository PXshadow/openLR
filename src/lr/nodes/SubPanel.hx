package lr.nodes;

import openfl.display.Shape;
import openfl.display.Sprite;

import lr.lines.LineBase;
import global.Common;
import lr.nodes.Grid;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract LayerMode(Int) to Int {
	public var color:Int = 0;
	public var black:Int = 1;
	public var hitTest_black = 2;
	public var hitTest_color = 3;
}
class SubPanel extends Sprite
{
	private var line_list:Array:Int;
	
	private var layer_gwell:Shape;
	private var layer_color:Shape;
	private var layer_black:Shape;
	private var layer_hitTest:Shape;
	
	private var offset_x:Int = 0;
	private var offset_y:Int = 0;
	
	public var gwelZoneVisible:Bool = false;
	
	public function new(_x:Int, _y:Int) 
	{
		this.layer_gwell = new Shape();
		this.layer_color = new Shape();
		this.layer_black = new Shape();
		this.layer_hitTest = new Shape();
		
		this.addChild(this.layer_gwell);
		this.addChild(this.layer_color);
		this.addChild(this.layer_black);
		this.addChild(this.layer_hitTest);
	}
	public function addLine(id:Int) {
		this.line_list.push(id);
	}
	public function removeLine(id:Int) {
		this.line_list.remove(id);
	}
	public function setMode(mode:Int) {
		switch (mode) {
			case LayerMode.black :
				this.layer_color.visible = false;
				this.layer_black.visible = true;
				this.layer_hitTest.visible = false;
			case LayerMode.color :
				this.layer_color.visible = true;
				this.layer_black.visible = true;
				this.layer_hitTest.visible = false;
			case LayerMode.hitTest_black :
				this.layer_color.visible = false;
				this.layer_black.visible = true;
				this.layer_hitTest.visible = true;
			case LayerMode.hitTest_color :
				this.layer_color.visible = true;
				this.layer_black.visible = true;
				this.layer_hitTest.visible = true;
		}
	}
	public function drawLines() {
		this.layer_gwell.graphics.clear();
		this.layer_color.graphics.clear();
		this.layer_black.graphics.clear();
		this.layer_hitTest.graphics.clear();
		for (a in this.line_list) {
			switch (Common.gGrid.lines[a].type) {
				case LineType.Floor :
					
				case LineType.Accel :
					
				case LineType.Scene :
				
				default :
					
			}
		}
	}
}