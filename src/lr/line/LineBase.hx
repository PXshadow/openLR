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
	public function new(_a:Point, _b:Point) 
	{
		super();
		a = _a;
		b = _b;
	}
	public function render()
	{
		this.graphics.clear();
		this.graphics.lineStyle(4, 0x000000, 1);
		this.graphics.moveTo(a.x, a.y);
		this.graphics.lineTo(b.x, b.y);
	}
}