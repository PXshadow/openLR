package lr.lines;

import lr.lines.collision.Acceleration;
import lr.lines.collision.Decceleration;
import lr.lines.collision.Floor;
import lr.lines.collision.NoCollision;
import lr.rider.phys.frames.anchors.CPoint;
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
	public var Deccel:Int = 3;
}
@:enum abstract SwapType(Int) from Int to Int {
	public var CollisionCycle:Int = 0;
	public var SceneryToggle:Int = 1;
	public var InverseToggle:Int = 2;
	public var DirectionToggle:Int = 3;
}
class LineBase extends Shape
{
	public static var zone = 10;
	public var mov:Int = 0;
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
	public var prevType:Int = -1;
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
	public var hit:Bool = false;
	public var grind:Bool = false;
	
	public function new(_type:Int, _x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _lim = -1)
	{
		super();
		this.gridList = new Array();
		this.gridVisList = new Array();
		this.type = _type;
		this.prevType = _type;
		x1 = _x1;
		y1 = _y1;
		x2 = _x2;
		y2 = _y2;
		inv = _inv;
		this.calculateConstants();
		this.set_lim(_lim == -1 ? (0) : (_lim));
	}
	public function inject_grid_loc(a:Array<Int>)
	{
		this.gridList.push(a);
	}
	public function inject_grid_vis_loc(a:Array<Int>)
	{
		this.gridVisList.push(a);
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
		
		if (this.phys != null) {
			return;
		}
		switch(this.type) {
			case LineType.None :
				this.phys = new NoCollision();
			case LineType.Floor :
				this.phys = new Floor(this);
			case LineType.Accel :
				this.phys = new Acceleration(this);
			case LineType.Deccel :
				this.phys = new Decceleration(this);
			case LineType.Scene :
				return;
			default :
				this.phys = new NoCollision();
		}
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
	public function collide(dot:CPoint) 
	{
		this.phys.collide(dot);
	}
	public function render_collide() 
	{

	}
	public function unrender_collide()
	{

	}
	public function changeBehavior(_mode:Int) {
		switch (_mode) {
			case SwapType.CollisionCycle : //cycles through all line types
				trace("performed swap");
				switch (this.type) {
					case 0 :
						this.type = 1;
						this.prevType = 1;
						this.phys = new Acceleration(this);
					case 1 :
						this.type = 3;
						this.prevType = 3;
						this.phys = new Decceleration(this);
					case 2 :
						return;
					case 3 :
						this.type = 0;
						this.prevType = 0;
						this.phys = new Floor(this);
					default :
						return;
				}
			case SwapType.DirectionToggle : //changes direction behavior
				switch (this.type) {
					case 1 :
						this.quickDirectionFlip();
						this.phys = new Acceleration(this);
					default :
						return;
				}
			case SwapType.InverseToggle : //flips collision side
				switch (this.type) {
					case 0 :
						this.inv = !this.inv;
					case 1 :
						this.inv = !this.inv;
					case 2 :
						return;
					default :
						return;
				}
			case SwapType.SceneryToggle :
				if (this.type != 2) {
					this.type = 2;
					this.phys = new NoCollision();
				} else {
					switch (this.prevType) {
					case -1 :
						this.type = 0;
						this.phys = new Floor(this);
					case 0 :
						this.type = 0;
						this.phys = new Floor(this);
					case 1 :
						this.type = 1;
						this.phys = new Acceleration(this);
					case 3 :
						this.type = 3;
						this.phys = new Decceleration(this);
					default :
						this.type = 0;
						this.phys = new Floor(this);
					}
				}
				Common.gGrid.updateRegistry(this);
		}
		this.calculateConstants();
	}
	function quickDirectionFlip() 
	{
		var tempX1 = this.x1;
		var tempY1 = this.y1;
		var tempX2 = this.x2;
		var tempY2 = this.y2;
			
		this.x1 = tempX2;
		this.x2 = tempX1;
		this.y1 = tempY2;
		this.y2 = tempY1;
		this.inv = !this.inv;
	}
}
class LinePreview extends LineBase
{

	public inline function new(_x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _type:Int) 
	{
		super(_type, _x1, _y1, _x2, _y2, _inv);
	}
}