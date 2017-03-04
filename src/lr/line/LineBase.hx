package lr.line;

import openfl.display.MovieClip;
import openfl.geom.Point;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
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
	
	public function new(_a:Point, _b:Point, _inv:Bool, _lim = -1) 
	{
		super();
		a = _a;
		b = _b;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	
	function calculateConstants() 
	{
		d = Common.get_distance_point(a, b);
		C = d.y * a.x - d.x * a.y;
		var sqrDis = Math.pow(d.x, 2) + Math.pow(d.y, 2);
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
	public function render()
	{
		this.graphics.clear();
		this.graphics.lineStyle(4, 0x000000, 1);
		this.graphics.moveTo(a.x, a.y);
		this.graphics.lineTo(b.x, b.y);
	}
}