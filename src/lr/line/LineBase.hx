package lr.line;

import init.Defaults;
import openfl.display.MovieClip;
import openfl.geom.Point;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * 
 * Base variables for all lines
 * 
 */
class LineBase extends MovieClip
{
	public var a:Point;
	public var b:Point;
	private var d:Point;
	private var C:Float;
	private var invSqrDis:Float;
	private var dst:Float;
	private var invDst:Float;
	private var n:Point;
	private var LIM:Float;
	private var _lim:Float;
	private var _lim1:Float;
	private var _lim2:Float;
	public var inv:Bool = false;
	public var type:Int = -1;
	public var ID:Int;
	
	public function new() 
	{
		super();
	}
	
	function calculateConstants() 
	{
		d = Common.get_distance_point(a, b);
		C = d.y * a.x - d.x * a.y;
		var sqrDis = d.x * d.x + d.y * d.y;
		invSqrDis = 1 / sqrDis;
        dst = Math.sqrt(sqrDis);
        invDst = 1 / dst;
		n = new Point(d.y * invDst * (inv ? (1) : ( -1)), d.x * invDst * (inv ? ( -1) : (1)));
		LIM = Math.min(0.25, 10 / dst);
	}
	function set_lim(input)
	{
		switch (input)
        {
            case 0:
            {
                _lim1 = 0;
                _lim2 = 1;
            } 
            case 1:
            {
                _lim1 = -LIM;
                _lim2 = 1;
            } 
            case 2:
            {
                _lim1 = 0;
                _lim2 = 1 + LIM;
            } 
            case 3:
            {
                _lim1 = -LIM;
                _lim2 = 1 + LIM;
            } 
        }
        _lim = input;
	}
}