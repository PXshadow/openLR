package lr.line;

import openfl.geom.Point;


/**
 * ...
 * @author Kaelan Evans
 */
class LineFloor extends LineBase
{

	public function new(_a:Point, _b:Point, _inv:Bool, _lim = -1) 
	{
		super();
		this.type = 0;
		a = _a;
		b = _b;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	public function render(con:String)
	{
		if (con == "edit") {
			var _loc_3:Float;
			var _loc_4:Float;
			this.graphics.clear();
			_loc_3 = n.x > 0 ? (Math.ceil(n.x)) : (Math.floor(n.x));
			_loc_4 = n.y > 0 ? (Math.ceil(n.y)) : (Math.floor(n.y));
			this.graphics.lineStyle(2, 26367, 1, true, "normal", "round");
			this.graphics.moveTo(a.x + _loc_3, a.y + _loc_4);
			this.graphics.lineTo(b.x + _loc_3, b.y + _loc_4);
		}
        this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
        this.graphics.moveTo(a.x, a.y);
        this.graphics.lineTo(b.x, b.y);
	}
}