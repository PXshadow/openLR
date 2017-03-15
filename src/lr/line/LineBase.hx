package lr.line;

import init.Defaults;
import lr.rider.phys.CPoint;
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
	static var zone = 10;
	public var x1:Float;
	public var y1:Float;
	public var x2:Float;
	public var y2:Float;
	private var dx:Float;
	private var dy:Float;
	private var hx:Float;
	private var hy:Float;
	private var C:Float;
	private var invSqrDis:Float;
	private var dst:Float;
	private var invDst:Float;
	private var nx:Float;
	private var ny:Float;
	private var LIM:Float;
	private var _lim:Float;
	private var _lim1:Float;
	private var _lim2:Float;
	public var inv:Bool = false;
	public var type:Int = -1;
	public var ID:Int;
	public var gridList:Array<Array<Int>>;
	
	public function new() 
	{
		super();
		this.gridList = new Array();
	}
	public function inject_grid_loc(a:Array<Int>)
	{
		this.gridList.push(a);
	}
	function calculateConstants() 
	{
		dx = x2 - x1;
        dy = y2 - y1;
        C = dy * x1 - dx * y1;
        var _loc2 = Math.pow(dx, 2) + Math.pow(dy, 2);
        invSqrDis = 1 / _loc2;
        dst = Math.sqrt(_loc2);
        invDst = 1 / dst;
        nx = dy * invDst * (inv ? (1) : (-1));
        ny = dx * invDst * (inv ? ( -1) : (1));
        hx = Math.abs(dx) * 0.500000;
        hy = Math.abs(dy) * 0.500000;
        LIM = Math.min(0.250000, LineBase.zone / dst);
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
	public function collide(dot:CPoint) {
		
	}
}