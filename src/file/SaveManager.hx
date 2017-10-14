package file;

import openfl.utils.Object;
import openfl.geom.Point;
import openfl.Lib;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldType;
import openfl.events.MouseEvent;
import ui.inter.CheckBox;
import ui.inter.ConfirmDialog;

#if (cpp)
	import sys.FileSystem;
	import sys.io.File;
	import haxe.Json;
#end

import global.Common;
import global.CVar;
import global.SVar;
import ui.inter.TextButton;
import global.Language;

/**
 * ...
 * @author Kaelan Evans
 * 
 */
class SaveManager extends Sprite
{
	public static var new_track:Bool = true; //only ever gets set to false when track is saved initially, or if track is loaded. Always set to true on new track
	
	#if (cpp)
		var directory:File;
	#end
	
	var trackData:Object;
	var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	var font_b:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	var author_input:TextField;
	var name_input:TextField;
	var description_input:TextField;
	var save_button:TextButton;
	var cancel_button:TextButton;
	var save_date:String = Date.now().getFullYear() + Date.now().getDate() + Date.now().getHours() + "";
	var add_timestamp:CheckBox;
	var fileName:String;
	var confirm_box:ConfirmDialog;
	public function new() 
	{
		super();
		
		Common.gSaveManager = this;
		
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(600, 0); 
		this.graphics.lineTo(600, 300); 
		this.graphics.lineTo(0, 300); 
		this.graphics.lineTo(0, 0);
		this.graphics.endFill();
		
		this.name_input = new TextField();
		this.name_input.type = TextFieldType.INPUT;
		this.name_input.defaultTextFormat = font_a;
		this.addChild(this.name_input);
		this.name_input.text = CVar.track_name;
		this.name_input.x = 5;
		this.name_input.y = 5;
		this.name_input.width = 400;
		this.name_input.height = 20;
		
		this.graphics.moveTo(5, 30);
		this.graphics.lineTo(400, 30);
		
		this.author_input = new TextField();
		this.author_input.type = TextFieldType.INPUT;
		this.author_input.defaultTextFormat = font_a;
		this.addChild(this.author_input);
		if (SaveManager.new_track) {
			this.author_input.text = CVar.universal_author_name;
		} else {
			this.author_input.text = CVar.track_author;
		}
		this.author_input.x = 5;
		this.author_input.y = 35;
		this.author_input.width = 400;
		this.author_input.height = 20;
		
		this.graphics.moveTo(5, 65);
		this.graphics.lineTo(400, 65);
		
		this.description_input = new TextField();
		this.description_input.type = TextFieldType.INPUT;
		this.description_input.defaultTextFormat = font_b;
		this.addChild(this.description_input);
		this.description_input.wordWrap = true;
		this.description_input.text = CVar.author_comment;
		this.description_input.x = 5;
		this.description_input.y = 70;
		this.description_input.width = 590;
		this.description_input.height = 200;
		
		this.save_button = new TextButton(Language.Save, this.save_track_pre, ButtonSize.b120x30);
		this.addChild(this.save_button);
		this.save_button.x = 10;
		this.save_button.y = 260;
		
		this.add_timestamp = new CheckBox("Add time stamp", CVar.add_time_stamp);
		this.addChild(this.add_timestamp);
		this.add_timestamp.x = 140;
		this.add_timestamp.y = 270;
		this.add_timestamp.hitBox.addEventListener(MouseEvent.CLICK, this.toggle_time_stamp);
		
		this.cancel_button = new TextButton(Language.Cancel, Common.gCode.toggle_save_menu, ButtonSize.b120x30);
		this.addChild(this.cancel_button);
		this.cancel_button.x = 475;
		this.cancel_button.y = 260;
	}
	private function save_track_pre() {
		#if (cpp)
		this.fileName = this.name_input.text + ".json";
		this.removeChild(this.save_button);
		this.removeChild(this.cancel_button);
		if (CVar.add_time_stamp) {
			this.generate_save_json();
			this.addChild(this.save_button);
			this.addChild(this.cancel_button);
		} else {
			if (FileSystem.exists("./saves/" + this.fileName)) {
				if (!SaveManager.new_track) { //check if new track. If not then compare date stamp is necesary
					if (this.save_date == SVar.track_date_stamp) {
						this.generate_save_json();
						this.addChild(this.save_button);
						this.addChild(this.cancel_button);
					} else {
						//Alert the user that time has passed since last save
						this.confirm_box = new ConfirmDialog("It seems you haven't saved in awhile. Are you sure you want to overwrite the current save and lose the data from the previous save?", this.save_override, this.confirm_no);
						this.addChild(confirm_box);
					}
				} else {
					//Alert the user that a file already exists
					this.confirm_box = new ConfirmDialog("There's a file with the name \"" + this.fileName + "\". Most likely the current track you are trying to save is not the same as this file. Are you sure you want to overwrite?", this.save_override, this.confirm_no);
					this.addChild(confirm_box);
				}
			} else {
				this.generate_save_json();
				this.addChild(this.save_button);
				this.addChild(this.cancel_button);
			}
		}
		#else
			this.generate_save_json();
		#end
	}
	function save_override() {
		this.addChild(this.save_button);
		this.addChild(this.cancel_button);
		this.removeChild(this.confirm_box);
		this.generate_save_json();
	}
	function confirm_no() {
		this.addChild(this.save_button);
		this.addChild(this.cancel_button);
		this.removeChild(this.confirm_box);
	}
	function toggle_time_stamp(e:MouseEvent) 
	{
		CVar.add_time_stamp = this.add_timestamp.toggle();
	}
	public function update() {
		this.save_date = Date.now().getDate() + Date.now().getHours() + "";
		if (!SaveManager.new_track) {
			this.name_input.text = CVar.track_name;
			if (SaveManager.new_track) {
				this.author_input.text = CVar.universal_author_name;
			} else {
				this.author_input.text = CVar.track_author;
			}
			this.description_input.text = CVar.author_comment;
		}
	}
	public function generate_save_json() //Top function for generating JSON legacy file
	{
		#if (cpp)
		//This function should only be called if confirmed to be okay to save
		
		CVar.track_name = this.name_input.text;
		CVar.track_author = this.author_input.text;
		CVar.author_comment = this.description_input.text;
		
		if (SaveManager.new_track) {
			SaveManager.new_track = false;
			CVar.universal_author_name = this.author_input.text;
		}
		var fileNameFinal:String = this.name_input.text;
		if (CVar.add_time_stamp) {
			fileNameFinal = fileNameFinal + "_Y" + Date.now().getFullYear() + "M" + Date.now().getMonth() + "D" + Date.now().getDay() + "H" + Date.now().getHours() + "m" + Date.now().getMinutes();
		}
		var track:Object = parse_json();
		var file = File.write("./saves/" + fileNameFinal + ".json", true); //.json = legacy format
		file.writeString(Json.stringify(track, null, "\t"));
		file.close();
		#end
		
		Common.gCode.toggle_save_menu();
	}
	public function parse_json():Object //top object. Gets name, author, etc.
	{
		var _locArray = this.json_line_aray_parse();
		var _locSettings = this.json_settings_array();
		var json_object:Object = {
			"label": this.name_input.text,
			"creator": this.author_input.text,
			"description": this.description_input.text,
			"version": "openLR",
			"startPosition": {
				"x": Common.track_start_x,
				"y": Common.track_start_y
			},
			"duration": 0,
			"lines": _locArray,
		}
		return(json_object);
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
		var _locLoopCount = 0;
		var lines = Common.gGrid.lines;
		lines.reverse();
		var a:Array<Object> = new Array();
		for (i in lines) {
			if (i == null) {
				continue;
			}
			a[_locLoopCount] = new Object();
			a[_locLoopCount] = {
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
			_locLoopCount += 1;
		}
		return(a);
	}
}