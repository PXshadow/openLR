package ui.tool;

import openfl.utils.AssetLibrary;

#if (!flash)
	import openfl.display.SimpleButton;
	import openfl.display.Sprite;
#else
	import openfl.Assets;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import platform.fl.ClipGrabber;
#end
	
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
		
		#if (!flash)
			var swfLib = AssetLibrary.loadFromFile("swf/ui/icons/" + _icon + ".bundle");
			swfLib.onComplete(this.attachClips);
			swfLib.onError(this.iconFailed);
		#else
			this.attachFlashClips(_icon);
		#end
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
	function attachFlashClips(object:String) 
	{
		var _locClips = new ClipGrabber(object);
		this.upState = _locClips.clipArray[0];
		this.hitTestState = _locClips.clipArray[0];
		this.overState = _locClips.clipArray[1];
		this.downState = _locClips.clipArray[2];
	}
}