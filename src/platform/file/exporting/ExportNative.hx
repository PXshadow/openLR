package platform.file.exporting;

import platform.file.ExportBase;
import platform.file.fileType.FileBase;
import platform.file.fileType.LRPK;
import platform.file.fileType.JSON;
import platform.file.fileType.TRK;
import platform.file.fileType.SOL;

/**
 * ...
 * @author Kaelan Evans
 */
class ExportNative extends ExportBase 
{

	public function new() 
	{
		super();
	}
	private var _file:FileBase;
	private var _fileExtension:String;
	override function getNameSpace(_type:Int) 
	{
		switch(_type) {
			case SaveType.LRPK :
				this._fileExtension = ".lrpk";
			case SaveType.JSON :
				this._fileExtension = ".json";
			case SaveType.TRK :
				this._fileExtension = ".trk";
			case SaveType.SOL :
				this._fileExtension = ".sol";
		}
		this.getData(_type);
	}
	override public function getData(_type:Int) 
	{
		
		switch(_type) {
			case SaveType.LRPK :
				this._file = new LRPK();
			case SaveType.JSON :
				this._file = new JSON();
			case SaveType.TRK :
				this._file = new TRK();
			case SaveType.SOL :
				this._file = new SOL();
		}
		this._file.encode();
	}
	override public function flushData() 
	{
		
	}
}