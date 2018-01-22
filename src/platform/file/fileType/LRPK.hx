package platform.file.fileType;

import lr.lines.LineBase;
import openfl.utils.ByteArray;
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
		var _locVer:String = _data.getString(pos, 4);
		pos += 4;
		var _locBlock:String = "";
		var _locLoop:Int = -2;
		while (true) {
			if (_locBlockSafe) {
				_locBlock = _data.getString(pos, 4);
				pos += 4;
				_locBlockSafe = false;
				continue;
			} else {
				switch (_locBlock) {
					case BlockKeys.EOF :
						break;
					case BlockKeys.start :
						Common.track_start_x = _data.getFloat(pos);
						pos += 4;
						Common.track_start_x = _data.getFloat(pos);
						pos += 4;
						_locBlockSafe = true;
						continue;
					case BlockKeys.lines :
						if (_locLoop == -2) {
							_locLoop = _data.getInt32(pos);
							pos += 4;
						}
						if (_locLoop >= 0) {
							//trace(_data.getInt32(pos)); //id
							//trace(_data.getInt32(pos + 4)); //type
							//trace(_data.getFloat(pos + 8)); //x1
							//trace(_data.getFloat(pos + 12)); //y1
							//trace(_data.getFloat(pos + 16)); //x2
							//trace(_data.getFloat(pos + 20)); //y2
							//trace(_data.get(pos + 24)); //side
							//trace(int_lim_to_set(_data.get(pos + 28), _data.get(pos + 32))); //extension
							pos += 36;
							--_locLoop;
							trace(_locLoop);
							continue;
						} else {
							_locBlockSafe = true;
							continue;
						}
						
				}
			}
			break;
		}
	}
}