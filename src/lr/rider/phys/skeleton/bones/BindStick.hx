package lr.rider.phys.skeleton.bones;
import lr.rider.phys.contacts.anchors.CPoint;
import lr.rider.phys.skeleton.bones.Stick;

/**
 * ...
 * @author ...
 */
class BindStick extends Stick
{
	private var endurance:Float;
	public function new(_a:CPoint, _b:CPoint) 
	{
		super(_a, _b);
		this.endurance = 0.057 * this.rest * 0.5;
	}
	override public function constrain():Bool {
		var _loc2:Float = a.x - b.x;
        var _loc3:Float = a.y - b.y;
        var _loc4:Float = Math.sqrt(_loc2 * _loc2 + _loc3 * _loc3);
		var _loc5:Float = 0;
		if (_loc4 != 0) { _loc5 = (_loc4 - rest) / _loc4 * 0.5; } //divide by zero catch. Prevents NaN soft lock.
		if (_loc5 >= this.endurance || Stick.crash) {
			Stick.crash = true;
			return(true);
		}
        var _loc6:Float = _loc2 * _loc5;
        var _loc7:Float = _loc3 * _loc5;
        a.x = a.x - _loc6;
        a.y = a.y - _loc7;
        b.x = b.x + _loc6;
        b.y = b.y + _loc7;
		return(false);
	}
}