package lr.lines;

import openfl.display.Shape;

import lr.lines.LineBase;

/**
 * ...
 * @author Kaelan Evans
 */
class LineVis extends Shape
{
	public var x1:Float;
	public var y1:Float;
	public var x2:Float;
	public var y2:Float;
	public var inv:Bool = false;
	public var grind:Bool = false;
	public var type:Int = -1;
	public var dx:Float;
	public var dy:Float;
	public var nx:Float;
	public var ny:Float;
	public var invDst:Float;
	public function new(_type:Int, _x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _invDst:Float, _nx:Float, _ny:Float, _dx:Float, _dy:Float, _grind:Bool) 
	{
		super();
		
		this.type = _type;
		x1 = _x1;
		y1 = _y1;
		x2 = _x2;
		y2 = _y2;
		nx = _nx;
		ny = _ny;
		dx = _dx;
		dy = _dy;
		inv = _inv;
		invDst = _invDst;
		grind = _grind;
	}
	public function render(con:String) {
		this.graphics.clear();
		if (con != "edit") {
			if (grind) {
				this.graphics.lineStyle(1, 0, 1, true, "normal", "round");
			} else {
				this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
			}
			this.graphics.moveTo(this.x1, this.y1); 
			this.graphics.lineTo(this.x2, this.y2);
			return;
		}
		var _loc_3:Float; 
		var _loc_4:Float; 
		_loc_3 = nx > 0 ? (Math.ceil(nx)) : (Math.floor(nx)); 
		_loc_4 = ny > 0 ? (Math.ceil(ny)) : (Math.floor(ny)); 
		switch (this.type) {
			case LineType.None :
				this.graphics.lineStyle(1, 0xFF0000, 1);
				this.graphics.moveTo(this.x1, this.y1); 
				this.graphics.lineTo(this.x2, this.y2);
				return;
			case LineType.Floor :
				this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round"); 
				this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4); 
				this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4); 
			case LineType.Accel :
				this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round"); 
				this.graphics.beginFill(0xCC0000, 1); 
				this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4); 
				this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4); 
				this.graphics.lineTo(x2 + (nx * 5 - dx * invDst * 5), y2 + (ny * 5 - dy * invDst * 5)); 
				this.graphics.lineTo(x2 - dx * invDst * 5, y2 - dy * invDst * 5); 
				this.graphics.endFill();
			case LineType.Deccel :
				this.graphics.lineStyle(2, 0x663300, 1, true, "normal", "round"); 
				this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4); 
				this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4);
			case LineType.Scene :
				this.graphics.lineStyle(2, 0x00CC00, 1);
				this.graphics.moveTo(this.x1, this.y1); 
				this.graphics.lineTo(this.x2, this.y2);
				return;
		}
		if (grind) {
			this.graphics.lineStyle(1, 0, 1, true, "normal", "round");
		} else {
			this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
		}
		this.graphics.moveTo(x1, y1); 
		this.graphics.lineTo(x2, y2);
	}
	public function renderCollision() {
		this.graphics.clear();
		if (this.type == 0) {
			this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
		} else if (this.type == 1) {
			this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
		}
		this.graphics.moveTo(x1, y1);
		this.graphics.lineTo(x2, y2);
	}
}