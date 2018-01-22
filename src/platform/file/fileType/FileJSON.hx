package platform.file.fileType;

import openfl.Lib;
import openfl.utils.Function;
import openfl.utils.Object;
import openfl.events.Event;

import global.Common;
import global.CVar;
import global.SVar;

import lr.lines.LineBase;
import lr.nodes.Grid;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract LRKeys(String) from String to String {
	public var ret = "\n";
	public var comma = ",\n";
	public var braceOpen = "{\n";
	public var braceClose = "},\n";
	public var bracketOpen = "[\n";
	public var bracketClose = "]\n";
	public var start = '"startPosition": ';
	public var xpos = '"x": ';
	public var ypos = '"y": ';
	public var lines = '"lines": ';
	public var id = '"id": ';
	public var type = '"type": ';
	public var linex1 = '"x1": ';
	public var linex2 = '"x2": ';
	public var liney1 = '"y1": ';
	public var liney2 = '"y2": ';
	public var inv = '"flipped": ';
	public var left = '"leftExtended": ';
	public var right = '"rightExtended": ';
}
class FileJSON extends FileBase
{
	private var tabLevel:Int = 0;
	var chunk_lines:Array<Object>;
	var step:Int = 0;
	var chunk_size:Int = 50;
	public function new() {
		super();
	}
	override public function encode(_name:String = "Untitled", _author:String = "Anonymous", _description:String = "This is the water. And this is the well. Drink full and descend. The horse is the white of the eyes and dark within.") {
		if (_name != null) this.name = _name;
		if (_author != null) this.author = _author;
		if (_description != null) this.description = _description;
		this.parse_json();
	}
	public function parse_json() { //top object. Gets name, author, etc.
		this.exportString += LRKeys.braceOpen;
		this.exportString += this.start_block();
		this.exportString += this.line_block();
	}
	function start_block():String {
		var _locString:String = "";
		_locString += LRKeys.start;
		_locString += LRKeys.braceOpen;
		_locString += LRKeys.xpos + this.fts(Common.track_start_x) + LRKeys.comma;
		_locString += LRKeys.ypos + this.fts(Common.track_start_y) + LRKeys.ret;
		_locString += LRKeys.braceClose;
		return _locString;
	}
	function line_block():String { //parses line array and organizes data
		var i = Common.gGrid.lines;
		i.reverse();
		var _locString:String = "";
		_locString += LRKeys.lines;
		_locString += LRKeys.bracketOpen;
		for (a in i) {
			if (a == null) {
				continue;
			}
			_locString += LRKeys.braceOpen;
			_locString += LRKeys.id + this.its(a.ID) + LRKeys.comma;
			_locString += LRKeys.type + this.its(a.type) + LRKeys.comma;
			_locString += LRKeys.linex1 + this.fts(a.x1) + LRKeys.comma;
			_locString += LRKeys.liney1 + this.fts(a.y1) + LRKeys.comma;
			_locString += LRKeys.linex2 + this.fts(a.x2) + LRKeys.comma;
			_locString += LRKeys.liney2 + this.fts(a.y2) + LRKeys.comma;
			_locString += LRKeys.inv + this.bts(a.inv) + LRKeys.comma;
			_locString += LRKeys.left + this.bts(a.lExt) + LRKeys.comma;
			_locString += LRKeys.right + this.bts(a.rExt) + LRKeys.ret;
			_locString += LRKeys.braceClose;
		}
		_locString += LRKeys.bracketClose;
		return _locString;
	}
	function grabNonVanillaData():String {
		return "";
	}
	function fts(_v:Float):String {
		return "";
	}
	function its(_v:Int) {
		return "" + _v;
	}
	function bts(_b:Bool) {
		if (_b) {
			return "true";
		} else {
			return "false";
		}
	}
	override public function json_decode(_trackData:Object) {
		CVar.track_name = _trackData.label;
		Common.track_start_x = _trackData.startPosition.x;
		Common.track_start_y = _trackData.startPosition.y;
		Common.gRiderManager.set_start(Common.track_start_x, Common.track_start_y, 0);
		if (_trackData.lines != null) {
			this.cache_lines(_trackData);
		} else if (_trackData.linesArray != null) {
			this.cache_lines_array(_trackData);
		} else if (_trackData.linesArrayCompressed != null) {
			var _locDecompressed:String = this.decompress(_trackData.linesArrayCompressed);
			
			trace(_locDecompressed);
		}
	}
	function cache_lines_array(_trackData:Object) {
		
	}
	function cache_lines(_trackData:Object) {
		if (_trackData.lines.length >= 5000) {
			this.step = _trackData.lines.length;
			this.chunk_lines = _trackData.lines;
			Lib.current.stage.addEventListener(Event.ENTER_FRAME, chunk_load);
		} else {
			_trackData.lines.reverse();
			for (i in 0..._trackData.lines.length) {
				var _loc1:LineBase;
				if (_trackData.lines[i] == null) {
					continue;
				}
				_loc1 = new LineBase(_trackData.lines[i].type, _trackData.lines[i].x1, _trackData.lines[i].y1, _trackData.lines[i].x2, _trackData.lines[i].y2, _trackData.lines[i].flipped);
				_loc1.ID = _trackData.lines[i].id;
				_loc1.set_lim(this.get_lim_to_set(_trackData.lines[i].leftExtended, _trackData.lines[i].rightExtended));
				Common.gGrid.cacheLine(_loc1);
				//SVar.lineID += 1;
			}
		}
	}
	function chunk_load(e:Event):Void {
		for (i in 0...chunk_size) {
			var _loc1:LineBase;
			if (chunk_lines[step] == null) {
				--step;
				continue;
			}
			_loc1 = new LineBase(chunk_lines[step].type, chunk_lines[step].x1, chunk_lines[step].y1, chunk_lines[step].x2, chunk_lines[step].y2, chunk_lines[step].flipped);
			_loc1.ID = chunk_lines[step].id;
			_loc1.set_lim(this.get_lim_to_set(chunk_lines[step].leftExtended, chunk_lines[step].rightExtended));
			Common.gGrid.cacheLine(_loc1);
			--step;
			if (step <= 0) {
				Lib.current.stage.removeEventListener(Event.ENTER_FRAME, chunk_load);
			}
		}
	}
	//LZ-String decompression
	var keyStrBase64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	var f = String.fromCharCode;
	function decompress(compressed:String):String {
		if (compressed == null) return "";
		if (compressed == "") return null;
		return _decompress(compressed.length, 32768, function(index) { return compressed.charAt(index); });
	}
	function _decompress(length:Int, resetValue:Int, getNextValue:Function):String {
		
		var dictionary:Array<String> = [];
		var next;
		var enlargeIn:Int = 4;
		var dictSize:Int = 4;
		var numBits:Int = 3;
		var entry:String = "";
		var result = [];
		var i;
		var w;
		var bits, resb, maxpower, power;
		var c:String = "";
		var data:Object = {"val" : getNextValue(0), "position" : resetValue, "index" : 1};
		
		for (i in 0...3) {
			dictionary[i] = "" + i;
		}
		
		bits = 0;
		maxpower = Math.pow(2, 2);
		power = 1;
		while (power != maxpower) {
			resb = data.val & data.position;
			data.position >>= 1;
			if (data.position == 0) {
				data.position = resetValue;
				data.val = getNextValue(data.index++);
			}
			bits |= (resb > 0 ? 1 : 0) * power;
			power <<= 1;
		}
		switch (next = bits) {
			case 0:
				bits = 0;
				maxpower = Math.pow(2, 8);
				power = 1;
				while (power != maxpower) {
					resb = data.val & data.position;
					data.position >>= 1;
					if (data.position == 0) {
						data.position = resetValue;
						data.val = getNextValue(data.index++);
					}
					bits |= (resb > 0 ? 1 : 0) * power;
					power <<= 1;
				}
				c = f(bits);
			case 1:
				bits = 0;
				maxpower = Math.pow(2,16);
				power = 1;
				while (power != maxpower) {
					resb = data.val & data.position;
					data.position >>= 1;
					if (data.position == 0) {
						data.position = resetValue;
						data.val = getNextValue(data.index++);
					}
					bits |= (resb > 0 ? 1 : 0) * power;
					power <<= 1;
				}
				c = f(bits);
			case 2:
				return "";
		}
		
		dictionary[3] = c;
		w = c;
		result.push(c);
		
		while (true) {
			if (data.index > length) return "";
			
		}
		return("blep");
	}
}