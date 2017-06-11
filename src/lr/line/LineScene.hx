package lr.line;

import lr.rider.phys.CPoint;
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

	public function new(_x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _lim = -1) 
	{
		super();
		this.type = 2;
		x1 = _x1;
		y1 = _y1;
		x2 = _x2;
		y2 = _y2;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	override public function render(con:String)
	{
		this.graphics.clear();
		if (con == "edit")
		{
			this.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round");
		} else if (con == "play") {
			this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
		}
        this.graphics.moveTo(x1, y1);
        this.graphics.lineTo(x2, y2);
	}
	override public function collide(dot:CPoint) 
	{
		
	}
}