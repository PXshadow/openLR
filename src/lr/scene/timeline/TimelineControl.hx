package lr.scene.timeline;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import lr.scene.timeline.Ticker;
import lr.tool.Toolbar;
import lr.tool.ToolBase;
import global.Common;
import global.SVar;

/**
 * ...
 * @author Kaelan Evans
 */
class TimelineControl extends Sprite
{
	var ticker:Ticker;
	var ticker_pause:Bool = false;
	var isOver:Bool = false;
	public function new() 
	{
		super();
		Common.gTimeline = this;
		
		this.graphics.clear();
		this.graphics.beginFill(0xAAAAAA, 0.75);
		this.graphics.moveTo( -15, -15);
		this.graphics.lineTo(1295, -15);
		this.graphics.lineTo(1295, 35);
		this.graphics.lineTo(-15, 35);
		
		this.ticker = new Ticker();
		this.addChild(this.ticker);
		this.ticker.mouseEnabled = false;
		
		this.addEventListener(MouseEvent.MOUSE_OVER, this.hover);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.resume);
	}
	function hover(e:MouseEvent):Void 
	{
		if (Common.gToolBase.currentTool.leftMouseIsDown) return;
		this.addEventListener(MouseEvent.MOUSE_DOWN, this.downAction);
		this.disableTool();
	}
	function resume(e:MouseEvent):Void 
	{
		if (Common.gToolBase.currentTool.leftMouseIsDown) return;
		this.removeEventListener(MouseEvent.MOUSE_DOWN, this.downAction);
		this.reenableTool();
	}
	function downAction(e:MouseEvent):Void 
	{
		this.isOver = true;
		this.removeEventListener(MouseEvent.MOUSE_OUT, this.resume);
		this.addEventListener(MouseEvent.MOUSE_OVER, this.enterDown);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.leaveDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, this.release);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.scrub);
	}
	function leaveDown(e:MouseEvent):Void 
	{
		this.isOver = false;
	}
	function enterDown(e:MouseEvent):Void 
	{
		this.isOver = true;
	}
	function release(e:MouseEvent):Void 
	{
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.scrub);
		this.removeEventListener(MouseEvent.MOUSE_OVER, this.enterDown);
		this.removeEventListener(MouseEvent.MOUSE_OUT, this.leaveDown);
		this.addEventListener(MouseEvent.MOUSE_OVER, this.hover);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.resume);
		if (this.isOver) {
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.downAction);
		} else {
			this.reenableTool();
		}
	}
	function reenableTool() {
		Toolbar.tool.set_tool(ToolBase.lastTool); 
	}
	function disableTool() {
		Toolbar.tool.set_tool("None"); 
	}
	private var prevX:Float = 0; 
	function scrub(e:MouseEvent):Void 
	{
		var curX:Float = this.mouseX; 
		if (curX - prevX < -4) { 
			Common.gSimManager.scrubberStepForward(); 
			this.prevX = this.mouseX; 
		} else if (curX - prevX > 4) { 
			Common.gSimManager.scrubberStepBack(); 
			this.prevX = this.mouseX; 
		} 
		this.update(); 
		Common.gTextInfo.update_sim(); 
	}
	public function update() {
		this.ticker.update();
	}
}