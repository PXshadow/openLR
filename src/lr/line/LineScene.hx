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
		if (con == "edit")
		{
			this.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round");
		} else if (con == "play") {
			this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
		}
        this.graphics.moveTo(x1, y1);
        this.graphics.lineTo(x2, y2);
		this.graphics.lineStyle(2, 0xCC00CC, 1);
		for (i in 0...gridList.length) {
			this.graphics.drawCircle(gridList[i][0] * 14, gridList[i][1] * 14, 3);
			this.graphics.moveTo((gridList[i][0] * 14 - 7), (gridList[i][1] * 14 - 7));
			this.graphics.lineTo((gridList[i][0] * 14 + 7), (gridList[i][1] * 14 - 7));
			this.graphics.lineTo((gridList[i][0] * 14 + 7), (gridList[i][1] * 14 + 7));
			this.graphics.lineTo((gridList[i][0] * 14 - 7), (gridList[i][1] * 14 + 7));
			this.graphics.lineTo((gridList[i][0] * 14 - 7), (gridList[i][1] * 14 - 7));
		}
	}
}