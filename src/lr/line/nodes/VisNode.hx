package lr.line.nodes;

import openfl.display.Sprite;

/**
 * ...
 * @author Kaelan Evans
 */
class VisNode extends Sprite
{
	var spriteLayer:Sprite;
	var lineCache:Array<LineBase>;
	public static var VisNodeArray:Array<VisNode> = new Array();
	public function new(_x:Int, _y:Int) 
	{
		super();
		VisNodeArray.push(this);
		this.spriteLayer = new Sprite();
		this.addChild(this.spriteLayer);
		this.lineCache = new Array();
	}
	public function inject(_line:LineBase)
	{
		this.lineCache[_line.ID] = _line;
		this.spriteLayer.addChild(this.lineCache[_line.ID]);
	}
	public function eject(_line:LineBase)
	{
		this.spriteLayer.removeChild(this.lineCache[_line.ID]);
		this.lineCache.remove(_line);
	}
}