package lr.line;

import openfl.geom.Point;

/**
 * ...
 * @author Kaelan Evans
 */
class LineScene extends LineBase
{

	public function new(_a:Point, _b:Point, _inv:Bool, _lim = -1) 
	{
		super();
		a = _a;
		b = _b;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	public function render()
	{
        this.graphics.clear();
        this.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round");
        this.graphics.moveTo(a.x, a.y);
        this.graphics.lineTo(b.x, b.y);
	}
}