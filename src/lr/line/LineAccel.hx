package lr.line;

import openfl.geom.Point;

/**
 * ...
 * @author Kaelan Evans
 * 
 *  Speedy lines
 * 
 */
class LineAccel extends LineBase
{

	public function new(_x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _lim = -1) 
	{
		super();
		this.type = 0;
		x1 = _x1;
		y1 = _y1;
		x2 = _x2;
		y2 = _y2;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	public function render(con:String)
	{
		this.graphics.clear();
		if (con == "edit") {
			var _loc_3:Float;
			var _loc_4:Float;
			_loc_3 = nx > 0 ? (Math.ceil(nx)) : (Math.floor(nx));
			_loc_4 = ny > 0 ? (Math.ceil(ny)) : (Math.floor(ny));
			this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
			this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4);
			this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4);
			this.graphics.lineTo(x2 + (nx * 4 - dx * invDst * 5), y2 + (ny * 4 - dy * invDst * 5));
            this.graphics.lineTo(x2 - dx * invDst * 5, y2 - dy * invDst * 5);
		}
        this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
        this.graphics.moveTo(x1, y1);
        this.graphics.lineTo(x2, y2);
		this.graphics.lineStyle(2, 0xCC00CC, 1);
	}
}