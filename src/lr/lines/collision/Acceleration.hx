package lr.lines.collision;

import lr.lines.LineBase;
import lr.lines.Collision;
import lr.rider.phys.anchors.CPoint;

/**
 * ...
 * @author Kaelan Evans
 */
class Acceleration extends Collision
{
	public function new(_line:LineBase) 
	{
		super();
		this.parent = _line;
	}
	override public function collide(dot:CPoint) {
		var _loc5:Float = dot.x - parent.x1;
        var _loc6:Float = dot.y - parent.y1;
        var _loc4:Float = parent.nx * _loc5 + parent.ny * _loc6;
        var _loc7:Float = (_loc5 * parent.dx + _loc6 * parent.dy) * parent.invSqrDis;
        if (dot.dx * parent.nx + dot.dy * parent.ny > 0)
        {
            if (_loc4 > 0 && _loc4 < LineBase.zone && _loc7 >= parent._lim1 && _loc7 <= parent._lim2)
            {
				if (!this.parent.grind) {
					
				} else {
					if (!this.checkIntersection(dot)) {
						if (_loc4 > LineBase.zone * 0.1) {
							return;
						}
					}
				}
				parent.render_collide();
                dot.x = dot.x - _loc4 * parent.nx;
                dot.y = dot.y - _loc4 * parent.ny;
                dot.vx = dot.vx + parent.ny * dot.fr * _loc4 * (dot.vx < dot.x ? (1) : (-1)) + parent.accx;
                dot.vy = dot.vy - parent.nx * dot.fr * _loc4 * (dot.vy < dot.y ? ( -1) : (1)) + parent.accy;
                return;
            } // end if
        } // end if
	}
}