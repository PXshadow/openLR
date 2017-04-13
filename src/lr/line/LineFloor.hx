package lr.line;

import lr.rider.phys.CPoint;
import global.Common;


/**
 * ...
 * @author Kaelan Evans
 */
class LineFloor extends LineBase
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
			this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
			this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4);
			this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4);
		}
        this.graphics.lineStyle(2, 0, 1, true, "normal", "round");
        this.graphics.moveTo(x1, y1);
        this.graphics.lineTo(x2, y2);
	}
	override public function collide(dot:CPoint) {
		var _loc5:Float = dot.x - x1;
        var _loc6:Float = dot.y - y1;
        var _loc4:Float = nx * _loc5 + ny * _loc6;
        var _loc7:Float = (_loc5 * dx + _loc6 * dy) * invSqrDis;
        if (dot.dx * nx + dot.dy * ny > 0)
        {
            if (_loc4 > 0 && _loc4 < LineBase.zone && _loc7 >= _lim1 && _loc7 <= _lim2)
            {
                dot.x = dot.x - _loc4 * nx;
                dot.y = dot.y - _loc4 * ny;
                dot.vx = dot.vx + ny * dot.fr * _loc4 * (dot.vx < dot.x ? (1) : (-1));
                dot.vy = dot.vy - nx * dot.fr * _loc4 * (dot.vy < dot.y ? ( -1) : (1));
				if (Common.cvar_hit_test) {
					this.graphics.clear();
					this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
					this.graphics.moveTo(x1, y1);
					this.graphics.lineTo(x2, y2);
				}
                return;
            } // end if
        } // end if
	}
}