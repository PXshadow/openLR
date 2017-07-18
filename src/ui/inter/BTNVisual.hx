package ui.inter;

import openfl.display.SimpleButton;
import openfl.display.Bitmap;
import openfl.utils.Assets;

/**
 * ...
 * @author Kaelan Evans
 */
class BTNVisual extends SimpleButton
{

	public inline function new(_size) 
	{
		super();
		switch(_size) {
			default:
			case 0:
				this.upState = new Bitmap(Assets.getBitmapData("img/ui/230x40up.png"));
				this.overState = new Bitmap(Assets.getBitmapData("img/ui/230x40over.png"));
				this.downState = new Bitmap(Assets.getBitmapData("img/ui/230x40down.png"));
				this.hitTestState = new Bitmap(Assets.getBitmapData("img/ui/230x40up.png"));
			case 1:
				this.upState = new Bitmap(Assets.getBitmapData("img/ui/120x30up.png"));
				this.overState = new Bitmap(Assets.getBitmapData("img/ui/120x30over.png"));
				this.downState = new Bitmap(Assets.getBitmapData("img/ui/120x30down.png"));
				this.hitTestState = new Bitmap(Assets.getBitmapData("img/ui/120x30up.png"));
		}
	}
	
}