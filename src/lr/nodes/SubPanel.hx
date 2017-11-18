package lr.nodes;

import lr.lines.LineBase;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract LayerMode(Int) from Int to Int {
	public var color:Int = 0;
	public var black:Int = 1;
	public var hitTest_black:Int = 2;
	public var hitTest_color:Int = 3;
}
class SubPanel extends Sprite
{
	private var layer_gwell:Shape;
	private var layer_color:Shape;
	private var layer_black:Shape;
	private var layer_scene:Shape;
	private var layer_hitTest:Shape;
	private var array_hitTest:Array<Sprite>;
	
	private var offset_x:Int = 0;
	private var offset_y:Int = 0;
	
	public var gwelZoneVisible:Bool = false;
	
	public function new(_x:Int, _y:Int) 
	{
		super();
		
		this.offset_x = _x;
		this.offset_y = _y;
		
		this.layer_gwell = new Shape();
		this.layer_color = new Shape();
		this.layer_black = new Shape();
		this.layer_scene = new Shape();
		this.layer_hitTest = new Shape();
		
		this.addChild(this.layer_gwell);
		this.addChild(this.layer_color);
		this.addChild(this.layer_scene);
		this.addChild(this.layer_black);
		this.addChild(this.layer_hitTest);
		
		this.layer_scene.visible = false;
	}
	public function setMode(mode:Int) {

	}
	public function drawLines(_lines:Array<LineBase>) {
		this.layer_black.graphics.clear();
		this.layer_color.graphics.clear();
		for (a in _lines) {
			var _loc_3:Float = a.nx > 0 ? (Math.ceil(a.nx)) : (Math.floor(a.nx));
			var _loc_4:Float = a.ny > 0 ? (Math.ceil(a.ny)) : (Math.floor(a.ny)); 
			switch(a.type) {
				case (LineType.Floor) :
					this.layer_color.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
					this.layer_color.graphics.moveTo((a.x1 + _loc_3) - this.offset_x, (a.y1 + _loc_4) - this.offset_y);
					this.layer_color.graphics.lineTo((a.x2 + _loc_3) - this.offset_x, (a.y2 + _loc_4) - this.offset_y);
					this.layer_black.graphics.lineStyle(2, 0, 1, true, "normal", "round");
					this.layer_black.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
					this.layer_black.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
				case (LineType.Accel) :
					this.layer_color.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
					this.layer_color.graphics.moveTo((a.x1 + _loc_3) - this.offset_x, (a.y1 + _loc_4) - this.offset_y);
					this.layer_color.graphics.lineTo((a.x2 + _loc_3) - this.offset_x, (a.y2 + _loc_4) - this.offset_y);
					this.graphics.beginFill(0xCC0000, 1); 
					this.graphics.moveTo((a.x1 + _loc_3) - this.offset_x, (a.y1 + _loc_4) - this.offset_y); 
					this.graphics.lineTo((a.x2 + _loc_3) - this.offset_x, (a.y2 + _loc_4) - this.offset_y); 
					this.graphics.lineTo(a.x2 + (a.nx * 5 - a.dx * a.invDst * 5) - this.offset_x, (a.y2 - this.offset_y) + (a.ny * 5 - a.dy * a.invDst * 5)); 
					this.graphics.lineTo(a.x2 - (a.dx * a.invDst * 5) - this.offset_x, (a.y2 - this.offset_y) - (a.dy * a.invDst * 5)); 
					this.graphics.endFill();
					this.layer_black.graphics.lineStyle(2, 0, 1, true, "normal", "round");
					this.layer_black.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
					this.layer_black.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
				case (LineType.Scene) :
					this.layer_color.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round");
					this.layer_color.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
					this.layer_color.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
					this.layer_scene.graphics.lineStyle(2, 0, 1, true, "normal", "round");
					this.layer_scene.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
					this.layer_scene.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
			}
		}
	}
	public function quickLineUpdate(a:LineBase) {
		var _loc_3:Float = a.nx > 0 ? (Math.ceil(a.nx)) : (Math.floor(a.nx));
		var _loc_4:Float = a.ny > 0 ? (Math.ceil(a.ny)) : (Math.floor(a.ny)); 
		switch(a.type) {
			case (LineType.Floor) :
				this.layer_color.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
				this.layer_color.graphics.moveTo((a.x1 + _loc_3) - this.offset_x, (a.y1 + _loc_4) - this.offset_y);
				this.layer_color.graphics.lineTo((a.x2 + _loc_3) - this.offset_x, (a.y2 + _loc_4) - this.offset_y);
				this.layer_black.graphics.lineStyle(2, 0, 1, true, "normal", "round");
				this.layer_black.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
				this.layer_black.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
			case (LineType.Accel) :
				this.layer_color.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
				this.layer_color.graphics.moveTo((a.x1 + _loc_3) - this.offset_x, (a.y1 + _loc_4) - this.offset_y);
				this.layer_color.graphics.lineTo((a.x2 + _loc_3) - this.offset_x, (a.y2 + _loc_4) - this.offset_y);
				this.graphics.beginFill(0xCC0000, 1); 
				this.graphics.moveTo((a.x1 + _loc_3) - this.offset_x, (a.y1 + _loc_4) - this.offset_y); 
				this.graphics.lineTo((a.x2 + _loc_3) - this.offset_x, (a.y2 + _loc_4) - this.offset_y); 
				this.graphics.lineTo(a.x2 + (a.nx * 5 - a.dx * a.invDst * 5) - this.offset_x, (a.y2 - this.offset_y) + (a.ny * 5 - a.dy * a.invDst * 5)); 
				this.graphics.lineTo(a.x2 - (a.dx * a.invDst * 5) - this.offset_x, (a.y2 - this.offset_y) - (a.dy * a.invDst * 5)); 
				this.graphics.endFill();
				this.layer_black.graphics.lineStyle(2, 0, 1, true, "normal", "round");
				this.layer_black.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
				this.layer_black.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
			case (LineType.Scene) :
				this.layer_color.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round");
				this.layer_color.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
				this.layer_color.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
				this.layer_scene.graphics.lineStyle(2, 0, 1, true, "normal", "round");
				this.layer_scene.graphics.moveTo((a.x1) - this.offset_x, (a.y1) - this.offset_y);
				this.layer_scene.graphics.lineTo((a.x2) - this.offset_x, (a.y2) - this.offset_y);
		}
	}
	public function set_rendermode_playback() {
		this.layer_color.visible = false;
		this.layer_scene.visible = true;
	}
	public function set_rendermode_edit() {
		this.layer_color.visible = true;
		this.layer_scene.visible = false;
	}
}
class SubPanelLine extends Sprite
{
	public function new()
	{
		super();
	}
}