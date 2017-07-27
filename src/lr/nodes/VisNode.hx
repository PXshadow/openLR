package lr.nodes;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

import lr.lines.LineBase;

/**
 * ...
 * @author Kaelan Evans
 */
class VisNode extends Sprite
{
	var spriteLayer:Sprite;
	var bitmapData:BitmapData;
	var bitmapLayer:Bitmap;
	var lineCache:Array<LineBase>;
	public static var VisNodeArray:Array<VisNode> = new Array();
	public function new(_x:Int, _y:Int) 
	{
		super();
		VisNodeArray.push(this);
		this.spriteLayer = new Sprite();
		this.bitmapLayer = new Bitmap();
		this.addChild(this.spriteLayer);
		this.addChild(this.bitmapLayer);
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
	public function switchToBitmap() {
		this.bitmapData = new BitmapData(VisGrid.gridSize, VisGrid.gridSize, true, 0xFFFFFF00);
		this.bitmapData.draw(this.spriteLayer);
		this.bitmapLayer = new Bitmap(this.bitmapData);
		this.spriteLayer.visible = false;
	}
}