package platform.file.browser;

import global.Common;
import platform.file.BrowserBase;

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
	override public function add_title_interface() 
	{
		
	}
	override public function parseDirectory() 
	{
		super.parseDirectory();
		
		this.displayDirectory();
	}
	override public function display_info(_fileName:String, _fileType:Int, _filePath:String) 
	{
		switch (_fileType) {
			case FileType.unknown :
				
			case FileType.JSON :
				
			case FileType.TRK :
				
			case FileType.SOL :
				
			case FileType.Directory :
			
			case FileType.New :
				this.init_env();
			case FileType.cancel :
				Common.gCode.toggle_Loader();
		}
	}
}