package lr.scene;

import openfl.display.Sprite;
import openfl.geom.Point;

import lr.lines.LineBase;
import lr.nodes.GridBase;
import lr.nodes.B2Grid;
import lr.nodes.VisGrid;
import lr.scene.Canvas;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract GridType(Int) from Int to Int {
	public var Beta1:Int = 0;
	public var Beta2:Int = 1;
}
class TrackNew extends Sprite
{
	private var grid:GridBase;
	private var canvas:Canvas;
	
	public function new(_type:Int) 
	{
		switch(_type) {
			case 0 :
				//does nothing
			case 1 : 
				this.grid = new B2Grid;
		}
	}
	public function addLine(_line:LineBase) {
		
	}
	public function renderPreview(_line:LineBase)
	{
		this.graphics.clear();
		var _loc_3:Float = _line.nx > 0 ? (Math.ceil(_line.nx)) : (Math.floor(_line.nx));
		var _loc_4:Float = _line.ny > 0 ? (Math.ceil(_line.ny)) : (Math.floor(_line.ny));
		switch(_line.type) {
			case LineType.Floor: 
				this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
				this.graphics.moveTo(_line.x1 + _loc_3, _line.y1 + _loc_4);
				this.graphics.lineTo(_line.x2 + _loc_3, _line.y2 + _loc_4);
			case LineType.Accel: 
				this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
				this.graphics.beginFill(0xCC0000, 1);
				this.graphics.moveTo(_line.x1 + _loc_3, _line.y1 + _loc_4);
				this.graphics.lineTo(_line.x2 + _loc_3, _line.y2 + _loc_4);
				this.graphics.lineTo(_line.x2 + (_line.nx * 5 - _line.dx * _line.invDst * 5), _line.y2 + (_line.ny * 5 - _line.dy * _line.invDst * 5));
				this.graphics.lineTo(_line.x2 - _line.dx * _line.invDst * 5, _line.y2 - _line.dy * _line.invDst * 5);
				this.graphics.endFill();
			case LineType.Scene: 
				this.graphics.lineStyle(2, 0x00CC00, 1);
				this.graphics.moveTo(_line.x1, _line.y1);
				this.graphics.lineTo(_line.x2, _line.y2);
				return;
		}
		this.graphics.lineStyle(2, 0x000000, 1);
		this.graphics.moveTo(_line.x1, _line.y1);
		this.graphics.lineTo(_line.x2, _line.y2);
	}
}