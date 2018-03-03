package lr.rider.phys.bones;

/**
 * ...
 * @author Kaelan Evans
 */
class ScarfStick
{
	public var a:Dynamic;
	public var b:Dynamic;
	public var rest:Float;
	public function new(_a:Dynamic, _b:Dynamic) 
	{
		this.a = _a;
		this.b = _b;
		var _loc2 = a.x - b.x;
        var _loc3 = a.y - b.y;
        rest = Math.sqrt(_loc2 * _loc2 + _loc3 * _loc3);
	}
	public function constrain():Bool {
		var _loc2:Float = a.x - b.x;
        var _loc3:Float = a.y - b.y;
        var _loc4:Float = Math.sqrt(_loc2 * _loc2 + _loc3 * _loc3);
		var _loc5:Float = 0;
		if (_loc4 != 0) { _loc5 = (_loc4 - this.rest) / _loc4 * 0.5; } //divide by zero catch. Prevents NaN soft lock. Yes I copy and pasted this function just so I can remind myself what this does.
        var _loc6:Float = _loc2 * _loc5;
        var _loc7:Float = _loc3 * _loc5;
        b.x = b.x + _loc6;
        b.y = b.y + _loc7; //deliberately excludes "A" contact point to avoid scarf from causing chaos theory phsyics
		return(false);
	}
}