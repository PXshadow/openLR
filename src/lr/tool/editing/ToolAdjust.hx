package lr.tool.editing;

import openfl.events.MouseEvent;

import lr.lines.LineBase;
import lr.tool.ToolBase;

/**
 * ...
 * @author Kaelan Evans
 */
class ToolAdjust extends ToolBase
{

	private var suspendedLines:Array<LineBase>;
	private var suspendedLine:LineBase;
	private var rightClickRequired:Bool = false;
	public function new() 
	{
		super();
		
		this.suspendedLines = new Array();
	}
	override public function mouseDown(e:MouseEvent):Void 
	{
		var _locLine = this.locateLine(e);
		if (e.ctrlKey) {
			if (_locLine == null) {
				return;
			}
			this.suspendedLines.push(_locLine);
			trace(this.suspendedLines);
			if (this.suspendedLines.length >= 2) {
				this.rightClickRequired = true;
			}
		} else {
			if (this.rightClickRequired) {
				return;
			} else {
				this.suspendedLines = new Array();
				if (_locLine == null) {
					if (this.suspendedLine == null) {
						return;
					} else {
						this.suspendedLine = null;
					}
				} else {
					this.suspendedLine = _locLine;
					this.suspendedLines.push(_locLine);
				}
			}
		}
	}
	override public function rMouseDown(e:MouseEvent):Void 
	{
		if (this.rightClickRequired) {
			for (a in this.suspendedLines) {
				//deselect lines;
			}
			this.suspendedLines = new Array();
			this.rightClickRequired = false;
		}
	}
}