package platform.fl;

import flash.display.MovieClip;

import ui.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class ClipGrabber 
{
	public var clipArray:Array<MovieClip>;
	public function new(_nameSpace:String)
	{
		this.clipArray = new Array();
		switch(_nameSpace) {
			case Icon.pencil :
				this.clipArray.push(new Up_pencil());
				this.clipArray.push(new Over_pencil());
				this.clipArray.push(new Down_pencil());
			case Icon.line :
				this.clipArray.push(new Up_line());
				this.clipArray.push(new Over_line());
				this.clipArray.push(new Down_line());
			case Icon.eraser :
				this.clipArray.push(new Up_eraser());
				this.clipArray.push(new Over_eraser());
				this.clipArray.push(new Down_eraser());
			default :
				this.clipArray.push(new Up_pencil());
				this.clipArray.push(new Over_pencil());
				this.clipArray.push(new Down_pencil());
		}
		trace(this.clipArray);
	}
	
}