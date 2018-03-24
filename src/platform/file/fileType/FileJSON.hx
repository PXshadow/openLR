package platform.file.fileType;

import haxe.Json;
import openfl.Lib;
import openfl.utils.Function;
import openfl.utils.Object;
import openfl.events.Event;

import global.Common;
import global.CVar;
import global.SVar;

import lr.lines.LineBase;

/**
 * ...
 * @author Kaelan Evans
 */
class FileJSON extends FileBase
{
	@:extern @:native("__hxcpp_set_float_format") //Credit to !Billy for finding this obscure solution to a problem that plagued me since April 2017
	static function changeFloat(format:String) {} //This has officially been fixed March 2018
	
	var chunk_lines:Array<Object>;
	var step:Int = 0;
	var chunk_size:Int = 100;
	public function new() {
		super();
	}
	override public function encode(_name:String = "Untitled", _author:String = "Anonymous", _description:String = "This is the water. And this is the well. Drink full and descend. The horse is the white of the eyes and dark within.") {
		if (_name != null) this.name = _name;
		if (_author != null) this.author = _author;
		if (_description != null) this.description = _description;
		changeFloat("%.16f"); //set exact precision to 16 digits past decimal
		this.exportString = Json.stringify(this.parse_json(), null, "\t");
		changeFloat("%.15g"); //set back to default behavior
	}
	public function parse_json():Object //top object. Gets name, author, etc.
	{
		var _locArray = this.json_line_aray_parse();
		var _locOLRMetaData = this.json_OLRMetaData();
		var json_object:Object = {
			"label": this.name,
			"creator": this.author,
			"description": this.description,
			"version": "6.2",
			"startPosition": {
				"x": Common.track_start_x,
				"y": Common.track_start_y
			},
			"duration": SVar.max_frames,
			"lines": _locArray,
			"extra": _locOLRMetaData,
		}
		return(json_object);
	}
	
	function json_OLRMetaData() 
	{
		var _loc1 = this.get_rider_info();
		var _locReturn:Object = {
			"settings" : {
				"angle_snap" : CVar.angle_snap,
				"line_snap" : CVar.line_snap,
				"color_play" : CVar.color_play,
				"preview_mode" : CVar.preview_mode,
				"hit_test" : CVar.hit_test,
			},
			"rider_info" : _loc1,
		}
		return (_locReturn);
	}
	
	function get_rider_info():Array<Object>
	{
		var _locArray:Array<Object> = new Array();
		var _indexCount:Int = 0;
		for (a in Common.gRiderManager.riderArray) {
			_locArray[_indexCount] = new Object();
			_locArray[_indexCount].pos_x = a.rider_pos_x;
			_locArray[_indexCount].pos_y = a.rider_pos_y;
			_locArray[_indexCount].color_a = a.color_a;
			_locArray[_indexCount].color_b = a.color_b;
			_locArray[_indexCount].name = a.rider_name;
			_locArray[_indexCount].velx = a.rider_x_velocity;
			_locArray[_indexCount].vely = a.rider_y_velocity;
			_locArray[_indexCount].angle = a.rider_angle;
			_locArray[_indexCount].scale = a.rider_scale;
			++_indexCount;
		}
		return (_locArray);
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
		var a:Array<Object> = new Array();
		var line_Place_Override:Int = 0;
		for (i in lines) {
			if (i == null) {
				continue;
			}
			a[line_Place_Override] = new Object();
			a[line_Place_Override] = {
				"id": i.ID,
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
		}
	}
	function cache_lines_array(_trackData:Object) {
		
	}
	function cache_lines(_trackData:Object) {
		_trackData.lines.reverse();
		if (_trackData.lines.length >= 5000) {
			this.step = _trackData.lines.length;
			this.chunk_lines = _trackData.lines;
			Lib.current.stage.addEventListener(Event.ENTER_FRAME, chunk_load);
		} else {
			if (_trackData.lines[0].id < _trackData.lines[1].id) _trackData.lines.reverse();
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