package platform.file;

import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;

#if (cpp)
	import sys.io.FileOutput;
	import sys.io.File;
#end

import global.Common;
/**
 * ...
 * @author Kaelan Evans
 */
class Screenshot 
{
	var container:Sprite;
	var bitmap:BitmapData;
	var data:ByteArray;
	var timestamp:String = "" + "Y" + Date.now().getFullYear() + "M" + Date.now().getMonth() + "D" + Date.now().getDay() + "H" + Date.now().getHours() + "m" + Date.now().getMinutes() + "S" + Date.now().getSeconds();
	public inline function new(_container:Sprite) 
	{
		#if (cpp)
		this.container = _container;
		this.bitmap = new BitmapData(Std.int(Common.stage_width), Std.int(Common.stage_height));
		this.bitmap.draw(container);
		this.data = bitmap.encode(bitmap.rect, new PNGEncoderOptions());
		var file = File.write("./export/" + timestamp + ".png", true);
		file.writeBytes(data, 0, data.length);
		file.close();
		Common.gCode.end_screencap();
		#end
	}
}