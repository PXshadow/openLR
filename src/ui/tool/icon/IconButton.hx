package ui.tool.icon;

import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.utils.AssetLibrary;

/**
 * ...
 * @author Kaelan Evans
 */
class IconButton extends SimpleButton
{
	var selected:Dynamic;
	public function new() 
	{
		super();
		
		var swfUp = AssetLibrary.loadFromFile("swf/ui/IconUp.bundle");
		swfUp.onComplete(this.attachUpAndHit);
		
		var swfOver = AssetLibrary.loadFromFile("swf/ui/IconOver.bundle");
		swfOver.onComplete(this.attachOver);
		
		var swfDown = AssetLibrary.loadFromFile("swf/ui/IconDown.bundle");
		swfDown.onComplete(this.attachDown);
		
		selected = AssetLibrary.loadFromFile("swf/ui/IconSelected.bundle");
	}
	function fail(lib:AssetLibrary) 
	{
		trace("fail");
	}
	function attachDown(lib:AssetLibrary) 
	{
		this.downState = lib.getMovieClip("");
	}
	function attachOver(lib:AssetLibrary) 
	{
		this.overState = lib.getMovieClip("");
	}
	function attachUpAndHit(lib:AssetLibrary) 
	{
		this.upState = lib.getMovieClip("");
		this.hitTestState = lib.getMovieClip("");
	}
}