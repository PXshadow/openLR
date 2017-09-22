package lr.lines.collision;

import lr.lines.Collision;
import lr.rider.phys.frames.anchors.CPoint;

/**
 * ...
 * @author ...
 */
class Decceleration extends Collision 
{
	var slowby:Float = 0.3;
	public function new(_line:LineBase) 
	{
		super();
		this.parent = _line;
	}
	override public function collide(dot:CPoint) 
	{
		var _loc5:Float = dot.x - parent.x1;
        var _loc6:Float = dot.y - parent.y1;
        var _loc4:Float = parent.nx * _loc5 + parent.ny * _loc6;
        var _loc7:Float = (_loc5 * parent.dx + _loc6 * parent.dy) * parent.invSqrDis;
        if (dot.dx * parent.nx + dot.dy * parent.ny > 0)
        {
            if (_loc4 > 0 && _loc4 < LineBase.zone && _loc7 >= parent._lim1 && _loc7 <= parent._lim2)
            {
				parent.render_collide();
                dot.x = dot.x - _loc4 * parent.nx;
                dot.y = dot.y - _loc4 * parent.ny;
				dot.vx = dot.vx - slowby * parent.ny * parent.acc * (dot.vx > dot.x ? (1) : (-1));
				dot.vy = dot.vy + slowby * parent.nx * parent.acc * (dot.vy > dot.y ? (-1) : (1));
                return;
            } // end if
        } // end if
	}
}