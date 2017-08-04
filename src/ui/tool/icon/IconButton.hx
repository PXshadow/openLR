package ui.tool.icon;

import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.utils.AssetLibrary;
import ui.tool.IconBase;

/**
 * ...
 * @author Kaelan Evans
 */
class IconButton extends SimpleButton
{
	var selected:Dynamic;
	public function new(_icon = Icon.undefined) 
	{
		super();
		
		var swfLib = AssetLibrary.loadFromFile("swf/ui/icons/" + _icon + ".bundle");
		swfLib.onComplete(this.attachClips);
		swfLib.onError(this.iconFailed);
	}
	
	function iconFailed(lib:AssetLibrary) 
	{
		trace("failed Icon");
	}
	
	function attachClips(lib:AssetLibrary) 
	{
		this.upState = lib.getMovieClip("up");
		this.hitTestState = lib.getMovieClip("up");
		this.overState = lib.getMovieClip("over");
		this.downState = lib.getMovieClip("down");
	}
}