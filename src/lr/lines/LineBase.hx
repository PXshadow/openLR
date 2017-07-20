package lr.lines;

import lr.rider.phys.frames.anchors.CPoint;
import openfl.display.Shape;
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
@:enum abstract LineType(Int) from Int to Int {
	public var Floor:Int = 0;
	public var Accel:Int = 1;
	public var Scene:Int = 2;
}
class LineBase extends Shape
{
	static var zone = 10;
	public var x1:Float;
	public var y1:Float;
	public var x2:Float;
	public var y2:Float;
	public var dx:Float;
	public var dy:Float;
	private var hx:Float;
	private var hy:Float;
	private var C:Float;
	public var invSqrDis:Float;
	private var dst:Float;
	public var invDst:Float;
	public var nx:Float;
	public var ny:Float;
	private var LIM:Float;
	private var _lim:Float;
	private var _lim1:Float;
	private var _lim2:Float;
	public var inv:Bool = false;
	public var type:Int = -1;
	public var ID:Int;
	public var gridList:Array<Array<Int>>;
	public var gridVisList:Array<Array<Int>>;
	public var prevLine:Int;
	public var nextLine:Int;
	public var lExt:Bool = false;
	public var rExt:Bool = false;
	public var lowest_collided_frame:Int = 0;
	private var accx:Float;
	private var accy:Float;
	private var acc:Float = 0.1;
	
	public function new() 
	{
		super();
		this.gridList = new Array();
		this.gridVisList = new Array();
	}
	public function inject_grid_loc(a:Array<Int>)
	{
		this.gridList.push(a);
	}
	public function inject_grid_vis_loc(a:Array<Int>)
	{
		this.gridVisList.push(a);
	}
	public function render(con:String)
	{
		
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
		this.accx = ny * this.acc * (this.inv ? (1) : (-1));
        this.accy = nx * this.acc * (this.inv ? (-1) : (1));
	}
	public function set_lim(input)
	{
		switch (input)
        {
            case 0:
            {
                _lim1 = 0;
                _lim2 = 1;
				lExt = false;
				rExt = false;
            } 
            case 1:
            {
                _lim1 = -LIM;
                _lim2 = 1;
				lExt = true;
				rExt = false;
            } 
            case 2:
            {
                _lim1 = 0;
                _lim2 = 1 + LIM;
				lExt = false;
				rExt = true;
            } 
            case 3:
            {
                _lim1 = -LIM;
                _lim2 = 1 + LIM;
				lExt = true;
				rExt = true;
            } 
        }
        _lim = input;
	}
	function addPrevLine(line, extend)
    {
        if (extend)
        {
            switch (this.get_lim())
            {
                case 0:
                {
                    this.set_lim(1);
                } 
                case 2:
                {
                    this.set_lim(3);
                } 
            }
        }
        prevLine = line.ID;
    }
    function addNextLine(line, extend)
    {
        if (extend)
        {
            switch (this.get_lim())
            {
                case 0:
                {
                    this.set_lim(2);
                } 
                case 1:
                {
                    this.set_lim(3);
                }
            }
        }
        nextLine = line.ID;
    }
	function get_lim()
    {
        return (_lim);
    } 
	public function collide(dot:CPoint) {
		if (Common.sim_frames == 0 || Common.sim_frames < this.lowest_collided_frame) {
			this.lowest_collided_frame = Common.sim_frames;
		}
		if (Common.cvar_hit_test) {
			this.graphics.clear();
			if (this.type == 0) {
				this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
			} else if (this.type == 1) {
				this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
			}
			this.graphics.moveTo(x1, y1);
			this.graphics.lineTo(x2, y2);
		}
	}
}