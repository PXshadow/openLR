package lr.tool.editing;

import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.geom.Point;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolZoom extends ToolAction 
{

	public function new() 
	{
		super();
	}
	var relativePoint:Point;
	var mouseDownPoint:Point;
	override public function leftMouseDown(event:MouseEvent) 
	{
		this.leftMouseIsDown = true;
		this.relativePoint = new Point(Lib.current.stage.stageWidth / 2, Lib.current.stage.stageHeight  / 2);
		this.mouseDownPoint = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
	}
	override public function leftMouseMove(event:MouseEvent) 
	{
		if (!leftMouseIsDown || rightMouseIsDown) return;
		this.zoom(event);
	}
	override public function leftMouseUp(event:MouseEvent) 
	{
		this.leftMouseIsDown = false;
	}
	override public function rightMouseDown(event:MouseEvent) 
	{
		this.rightMouseIsDown = true;
		this.relativePoint = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
		this.mouseDownPoint = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
	}
	override public function rightMouseMove(event:MouseEvent) 
	{
		if (!rightMouseIsDown || leftMouseIsDown) return;
		this.zoom(event);
	}
	override public function rightMouseUp(event:MouseEvent) 
	{
		this.rightMouseIsDown = false;
	}
	function zoom(e:MouseEvent) {
		var trkLoc:Point = new Point(Common.gTrack.x, Common.gTrack.y);
		var trkScale:Float = Common.gTrack.scaleX;
		var scaleToSet = Math.min(Math.max(trkScale + ((this.mouseDownPoint.y - Lib.current.stage.mouseY) / 10), Common.track_scale_min), Common.track_scale_max);
		Common.gTrack.x = (this.relativePoint.x) + ((trkLoc.x - this.relativePoint.x) * (scaleToSet / trkScale));
		Common.gTrack.y = (this.relativePoint.y) + ((trkLoc.y - this.relativePoint.y) * (scaleToSet / trkScale));
		Common.gTrack.scaleX = Common.gTrack.scaleY = scaleToSet;
		Common.gTrack.check_visibility();
		this.mouseDownPoint = new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY);
	}
}