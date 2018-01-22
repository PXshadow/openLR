package platform.file.fileType;

import lr.lines.LineBase;
import openfl.utils.ByteArray;

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
	override public function decode(_data:ByteArray) 
	{
		
	}
}