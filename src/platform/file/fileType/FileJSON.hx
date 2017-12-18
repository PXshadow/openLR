package platform.file.fileType;

import openfl.utils.Object;

import global.Common;
import global.CVar;

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
		this.flush();
	}
	public function parse_json():Object //top object. Gets name, author, etc.
	{
		var _locArray = this.json_line_aray_parse();
		var _locMetaData = this.grabNonVanillaData();
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
	
	function grabNonVanillaData() 
	{
		var _locObject:Object = new Object();
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
}