package platform.file.browser;

import flash.net.SharedObject;
import flash.net.ObjectEncoding;
import flash.utils.Object;

import global.Common;
import platform.file.BrowserBase;
import ui.inter.TextButton;

/**
 * ...
 * @author ...
 */
class BrowserFL extends BrowserBase 
{

	public function new() 
	{
		super();
	}
	override public function parseDirectory() 
	{
		super.parseDirectory();
		
		SharedObject.defaultObjectEncoding = ObjectEncoding.AMF0;
		var solObject:SharedObject = SharedObject.getLocal("savedLines", "/");
		var itemCount = 1;
		if (solObject.data.trackList) {
			if (solObject.data.trackList.length == 0) {
				this.init_env();
			} else {
				for (a in 0...(Std.int(solObject.data.trackList.length))) {
					if (solObject.data.trackList[a].label == null) continue;
					var b:String;
					#if air
						b = "com.kevansevans.openLR/Local Store/#SharedObjects/" + solObject.data.trackList[a].label;
					#else
						b = "localhost/" + solObject.data.trackList[a].label;
					#end
					switch (solObject.data.trackList[a].version) {
						case "6" :
							this.iconArray.push(new FileItemIcon(itemCount, FileType.SOL6_0, solObject.data.trackList[a].label, b));
						case "6.1" :
							this.iconArray.push(new FileItemIcon(itemCount, FileType.SOL6_1, solObject.data.trackList[a].label, b));
						case "6.2" :
							this.iconArray.push(new FileItemIcon(itemCount, FileType.SOL6_2, solObject.data.trackList[a].label, b));
						default :
							this.iconArray.push(new FileItemIcon(itemCount, FileType.SOL, solObject.data.trackList[a].label, b));
					}
					
					++itemCount;
				}
			}
		} else {
			this.init_env();
		}
		this.displayDirectory();
	}
	override public function add_title_interface() {
		super.add_title_interface();
	}
	override public function display_info(_fileName:String, _fileType:Int, _filePath:String) 
	{
		this.textField_fileName.text = _fileName;
		this.textField_filePath.text = _filePath;
		this.currentSelectedPath = _filePath;
		switch (_fileType) {
			case FileType.SOL :
				this.load_file.visible = true;
			case FileType.SOL6_0 :
				this.load_file.visible = true;
			case FileType.SOL6_1 :
				this.load_file.visible = true;
			case FileType.SOL6_2 :
				this.load_file.visible = true;
			case FileType.New :
				this.init_env();
			case FileType.cancel :
				Common.gCode.toggle_Loader();
		}
	}
}