package platform.file.fileType;

import openfl.utils.Function;
import openfl.utils.Object;

import global.Common;
import global.CVar;
import global.SVar;

import lr.lines.LineBase;
import lr.nodes.Grid;

/**
 * ...
 * @author Kaelan Evans
 */
class FileJSON extends FileBase
{
	public function new() 
	{
		super();
	}
	override public function encode(_name:String = "Untitled", _author:String = "Anonymous", _description:String = "This is the water. And this is the well. Drink full and descend. The horse is the white of the eyes and dark within.")
	{
		if (_name != null) this.name = _name;
		if (_author != null) this.author = _author;
		if (_description != null) this.description = _description;
		this.data = this.parse_json();
	}
	public function parse_json():Object //top object. Gets name, author, etc.
	{
		var _locArray = this.json_line_aray_parse();
		var _locMetaData:Object = this.grabNonVanillaData();
		var json_object:Object = {
			"label": this.name,
			"creator": this.author,
			"description": this.description,
			"version": "openLR",
			"startPosition": {
				"x": Common.track_start_x,
				"y": Common.track_start_y
			},
			"duration": 0,
			"lines": _locArray,
			"metadata" : _locMetaData
		}
		return(json_object);
	}
	
	function grabNonVanillaData():Object
	{
		var _locObject:Object = new Object();
		var _locSettings = this.json_settings_array();
		_locObject = {
			"olr_settings" : _locSettings,
		}
		return _locObject;
	}
	
	function json_settings_array():Object
	{
		var settings:Object = new Object();
		
		settings.angle_snap = CVar.angle_snap;
		settings.line_snap = CVar.line_snap;
		settings.color_play = CVar.color_play;
		settings.preview_mode = CVar.preview_mode;
		settings.hit_test = CVar.hit_test;
		
		return(settings);
	}
	private function json_line_aray_parse():Array<Object> //parses line array and organizes data
	{
		var lines = Common.gGrid.lines;
		lines.reverse();
		var a:Array<Object> = new Array();
		var line_Place_Override:Int = 0;
		for (i in lines) {
			if (i == null) {
				continue;
			}
			a[line_Place_Override] = new Object();
			a[line_Place_Override] = {
				"id": line_Place_Override,
				"type": i.type,
				"x1": i.x1,
				"y1": i.y1,
				"x2": i.x2,
				"y2": i.y2,
				"flipped": i.inv,
				"leftExtended":  i.lExt,
				"rightExtended":  i.rExt
			};
			++line_Place_Override;
		}
		return(a);
	}
	override public function decode(_trackData:Object) 
	{
		CVar.track_name = _trackData.label;
		Common.track_start_x = _trackData.startPosition.x;
		Common.track_start_y = _trackData.startPosition.y;
		if (_trackData.lines != null) {
			this.cache_lines(_trackData);
		} else if (_trackData.linesArray != null) {
			this.cache_lines_array(_trackData);
		} else if (_trackData.linesArrayCompressed != null) {
			var _locDecompressed:String = this.decompress(_trackData.linesArrayCompressed);
			
			trace(_locDecompressed);
		}
	}
	function cache_lines_array(_trackData:Object) 
	{
		
	}
	function cache_lines(_trackData:Object)
	{
		_trackData.lines.reverse();
		for (i in 0..._trackData.lines.length) {
			var _loc1:LineBase;
			if (_trackData.lines[i] == null) {
				continue;
			}
			_loc1 = new LineBase(_trackData.lines[i].type, _trackData.lines[i].x1, _trackData.lines[i].y1, _trackData.lines[i].x2, _trackData.lines[i].y2, _trackData.lines[i].flipped);
			_loc1.ID = SVar.lineID;
			_loc1.set_lim(this.get_lim_to_set(_trackData.lines[i].leftExtended, _trackData.lines[i].rightExtended));
			Common.gGrid.cacheLine(_loc1);
			SVar.lineID += 1;
		}
	}
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