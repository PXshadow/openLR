package lr.rider.phys.skeleton.bones;
import lr.rider.phys.frames.anchors.CPoint;
import lr.rider.phys.skeleton.bones.Stick;

/**
 * ...
 * @author ...
 */
class RepellStick extends Stick
{

	public function new(_a:CPoint, _b:CPoint) 
	{
		super(_a, _b);
	}
	override public function constrain():Bool 
	{
		var _loc3:Float = a.x - b.x;
        var _loc4:Float = a.y - b.y;
        var _loc2:Float = Math.sqrt(_loc3 * _loc3 + _loc4 * _loc4);
        if (_loc2 < this.rest)
        {
			var _loc5:Float = 0;
			if (_loc2 != 0){ _loc5 = (_loc2 - this.rest) / _loc2 * 0.5;} //divide by zero catch. Prevents NaN soft lock.
            var _loc6:Float = _loc3 * _loc5;
            var _loc7:Float = _loc4 * _loc5;
            a.x = a.x - _loc6;
            a.y = a.y - _loc7;
            b.x = b.x + _loc6;
            b.y = b.y + _loc7;
			return(false);
        } // end if
		return(true);
	}
}