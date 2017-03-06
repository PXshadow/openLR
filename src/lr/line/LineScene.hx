package lr.line;

import openfl.geom.Point;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Default lines
 * 
 * 
 */
class LineScene extends LineBase
{

	public function new(_a:Point, _b:Point, _inv:Bool, _lim = -1) 
	{
		super();
		this.type = 2;
		a = _a;
		b = _b;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	public function render(con:String)
	{
        this.graphics.clear();
		if (con == "edit") {
			this.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round");
		} else {
			this.graphics.lineStyle(2, 0x000000, 1, true, "normal", "round");
		}
        this.graphics.moveTo(a.x, a.y);
        this.graphics.lineTo(b.x, b.y);
	}
}