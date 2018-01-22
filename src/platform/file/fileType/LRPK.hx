package platform.file.fileType;

import lr.lines.LineBase;
import openfl.utils.ByteArray;
import haxe.io.BytesData;
import haxe.io.Bytes;

import global.Common;
import global.CVar;
import global.SVar;
/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract BlockKeys(String) from String to String {
	public var version:String = "V005";
	public var start:String = "STRT";
	public var lines:String = "LINE";
	public var EOF:String = "0EOF";
}
@:enum abstract PosKeys(Int) from Int to Int {
	public var keyStr:Int = 4;
	public var keyInt:Int = 4;
	public var keyFloat:Int = 4;
}
class LRPK extends FileBase
{

	public function new() 
	{
		super();
		
		this.exportBytes = new ByteArray();
	}
	override public function encode(_name:String = "Untitled", _author:String = "Anonymous", _description:String = "This is the water. And this is the well. Drink full and descend. The horse is the white of the eyes and dark within.")
	{
		if (_name != null) this.name = _name;
		if (_author != null) this.author = _author;
		if (_description != null) this.description = _description;
		this.parse_bytes();
	}
	function parse_bytes() 
	{
		this.exportBytes.writeUTFBytes(BlockKeys.version);
		this.writeStartBlock();
		this.writeLineBlock();
		this.exportBytes.writeUTFBytes(BlockKeys.EOF);
	}
	function writeStartBlock() 
	{
		this.exportBytes.writeUTFBytes(BlockKeys.start);
		this.exportBytes.writeFloat(Common.track_start_x);
		this.exportBytes.writeFloat(Common.track_start_y);
	}
	function writeLineBlock() 
	{
		this.exportBytes.writeUTFBytes(BlockKeys.lines);
		var i = Common.gGrid.lines;
		i.reverse();
		var b:Array<LineBase> = new Array();
		for (a in i) {
			if (a == null) {
				continue;
			}
			b.push(a);
		}
		this.exportBytes.writeInt(b.length);
		for (c in b) {
			this.exportBytes.writeInt(c.ID);
			this.exportBytes.writeInt(c.type);
			this.exportBytes.writeFloat(c.x1);
			this.exportBytes.writeFloat(c.y1);
			this.exportBytes.writeFloat(c.x2);
			this.exportBytes.writeFloat(c.y2);
			this.exportBytes.writeBoolean(c.inv);
			this.exportBytes.writeBoolean(c.lExt);
			this.exportBytes.writeBoolean(c.rExt);
		}
	}
	override public function lrpk_decode(_data:Bytes) 
	{
		var _locBlockSafe:Bool = true;
		var pos:Int = 0;
		var _locVer:String = _data.getString(pos, PosKeys.keyStr);
		pos += PosKeys.keyStr;
		var _locBlock:String = "";
		var _locLoop:Int = -1;
		while (true) {
			if (_locBlockSafe) {
				_locBlock = _data.getString(pos, PosKeys.keyStr);
				pos += PosKeys.keyStr;
				_locBlockSafe = false;
				continue;
			} else {
				switch (_locBlock) {
					case BlockKeys.EOF :
						break;
					case BlockKeys.start :
						Common.track_start_x = _data.getFloat(pos);
						pos += PosKeys.keyFloat;
						Common.track_start_x = _data.getFloat(pos);
						pos += PosKeys.keyFloat;
						_locBlockSafe = true;
						continue;
					case BlockKeys.lines :
						if (_locLoop == -1) {
							_locLoop = _data.getInt32(pos);
						}
						trace(_locLoop);
				}
			}
			break;
		}
	}
}