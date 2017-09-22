package lr.lines;

import lr.lines.collision.Acceleration;
import lr.lines.collision.Floor;
import lr.lines.collision.NoCollision;
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
	public var None:Int = -1;
	public var Floor:Int = 0;
	public var Accel:Int = 1;
	public var Scene:Int = 2;
}
class LineBase extends Shape
{
	public static var zone = 10;
	public var x1:Float;
	public var y1:Float;
	public var x2:Float;
	public var y2:Float;
	public var dx:Float;
	public var dy:Float;
	public var hx:Float;
	public var hy:Float;
	public var C:Float;
	public var invSqrDis:Float;
	public var dst:Float;
	public var invDst:Float;
	public var nx:Float;
	public var ny:Float;
	public var LIM:Float;
	public var _lim:Float;
	public var _lim1:Float;
	public var _lim2:Float;
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
	public var accx:Float;
	public var accy:Float;
	public var acc:Float = 0.1;
	public var phys:Collision;
	
	public function new(_type:Int, _x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _lim = -1)
	{
		super();
		this.gridList = new Array();
		this.gridVisList = new Array();
		this.type = _type;
		x1 = _x1;
		y1 = _y1;
		x2 = _x2;
		y2 = _y2;
		inv = _inv;
		this.calculateConstants();
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
		this.graphics.clear();
		if (con != "edit") {
			this.graphics.lineStyle(1, 0, 1);
			this.graphics.lineStyle(2, 0, 1, true, "normal", "round"); 
			this.graphics.moveTo(this.x1, this.y1); 
			this.graphics.lineTo(this.x2, this.y2);
			return;
		}
		var _loc_3:Float; 
		var _loc_4:Float; 
		_loc_3 = nx > 0 ? (Math.ceil(nx)) : (Math.floor(nx)); 
		_loc_4 = ny > 0 ? (Math.ceil(ny)) : (Math.floor(ny)); 
		switch (this.type) {
			case LineType.None :
				this.graphics.lineStyle(1, 0xFF0000, 1);
				this.graphics.moveTo(this.x1, this.y1); 
				this.graphics.lineTo(this.x2, this.y2);
				return;
			case LineType.Floor :
				this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round"); 
				this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4); 
				this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4); 
			case LineType.Accel :
				this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round"); 
				this.graphics.beginFill(0xCC0000, 1); 
				this.graphics.moveTo(x1 + _loc_3, y1 + _loc_4); 
				this.graphics.lineTo(x2 + _loc_3, y2 + _loc_4); 
				this.graphics.lineTo(x2 + (nx * 5 - dx * invDst * 5), y2 + (ny * 5 - dy * invDst * 5)); 
				this.graphics.lineTo(x2 - dx * invDst * 5, y2 - dy * invDst * 5); 
				this.graphics.endFill(); 
			case LineType.Scene :
				this.graphics.lineStyle(1, 0x00CC00, 1);
				this.graphics.moveTo(this.x1, this.y1); 
				this.graphics.lineTo(this.x2, this.y2);
				return;
		}
		this.graphics.lineStyle(2, 0, 1, true, "normal", "round"); 
		this.graphics.moveTo(x1, y1); 
		this.graphics.lineTo(x2, y2);
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
        this.accy = nx * this.acc * (this.inv ? ( -1) : (1));
		
		switch(this.type) {
			case LineType.None :
				this.phys = new NoCollision();
			case LineType.Floor :
				this.phys = new Floor(this);
			case LineType.Accel :
				this.phys = new Acceleration(this);
			case LineType.Scene :
				return;
			default :
				this.phys = new NoCollision();
		}
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	public function set_lim(input:Float)
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
		this.phys.collide(dot);
	}
	public function render_collide() {
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
class LinePreview extends LineBase
{

	public inline function new(_x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _type:Int) 
	{
		super(_type, _x1, _y1, _x2, _y2, _inv);
	}
}