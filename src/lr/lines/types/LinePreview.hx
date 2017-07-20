package lr.lines.types;
import lr.lines.LineBase;

/**
 * ...
 * @author Kaelan Evans
 */
class LinePreview extends LineBase
{

	public inline function new(_x1:Float, _y1:Float, _x2:Float, _y2:Float, _inv:Bool, _type:Int) 
	{
		super();
		this.type = _type;
		x1 = _x1;
		y1 = _y1;
		x2 = _x2;
		y2 = _y2;
		inv = _inv;
		this.calculateConstants();
	}
}