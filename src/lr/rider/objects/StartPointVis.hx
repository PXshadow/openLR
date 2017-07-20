package lr.rider.objects;

import openfl.display.Sprite;
import openfl.utils.AssetLibrary;

import lr.rider.RiderBase;

/**
 * ...
 * @author Kaelan Evans
 */
class StartPointVis extends Sprite
{
	
	var clip:Sprite;
	var rider:RiderBase;
	public function new() 
	{
		super();
		this.loadAsset();
	}
	function loadAsset() 
	{
		trace("Asset loading");
		var swfclip = AssetLibrary.loadFromFile("swf/start.bundle");
		swfclip.onComplete(this.attach);
	}
	function attach(lib:AssetLibrary) 
	{
		var innerClip:Sprite;
		innerClip = lib.getMovieClip("");
		innerClip.scaleX = innerClip.scaleY *= 0.5;
		innerClip.x = innerClip.y = ( -9.2 / 2);
		this.clip = new Sprite();
		this.clip.addChild(innerClip);
		this.addChild(this.clip);
	}
}