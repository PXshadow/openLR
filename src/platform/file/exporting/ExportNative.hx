package platform.file.exporting;

import global.Common;
import openfl.utils.ByteArray;
import platform.file.fileType.FileBase;
import sys.FileSystem;
import sys.io.File;
import lime.system.System;

import platform.file.ExportBase;
import platform.file.fileType.*;
import global.SVar;
import global.CVar;
import ui.inter.AlertBox;
import ui.inter.TextButton;

//import haxe.ui.components.DropDown;
import haxe.ui.components.Label;
import haxe.ui.components.TextField;
import haxe.ui.components.TextArea;
import haxe.ui.components.CheckBox;
import haxe.ui.components.OptionBox;
import haxe.ui.core.UIEvent;
import haxe.ui.core.MouseEvent;
//import haxe.ui.data.DataSource;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Placeholders commented out as HaxeUI is still indev and these were causing issues
 */
class ExportNative extends ExportBase 
{
	//var dropdown_SaveType:DropDown;
	//var dataType_saveTypes:DataSource<String>;
	
	var label_trackName:Label;
	var label_AuthorName:Label;
	var label_TrackDescription:Label;
	var textfield_trackName:TextField;
	var textfield_authorName:TextField;
	var textarea_trackDescription:TextArea;
	
	var checkbox_legacySave:CheckBox;
	var checkbox_includeScenery:CheckBox;
	var checkbox_newDirectory:CheckBox;
	var label_extraSettings:Label;
	
	var option_saveType_LRPK:OptionBox;
	var option_saveType_JSON:OptionBox;
	var option_saveType_TRK:OptionBox;
	var option_saveType_SOL:OptionBox;
	
	var alertbox_legacyInformed:Bool = false;
	var alertbox_legacyWarning:AlertBox;
	
	var selectedSaveType:String = "LRPK";
	var saveTypeLegacy:Bool = false;
	
	var textButton_cancel:TextButton;
	var textButton_save:TextButton;
	
	var track:FileBase;
	
	public function new() 
	{
		super();
		
		if (!FileSystem.isDirectory(System.documentsDirectory + "/openLR/saves")) {
			FileSystem.createDirectory(System.documentsDirectory + "/openLR/saves");
		}
		
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(500, 0);
		this.graphics.lineTo(500, 300);
		this.graphics.lineTo(0, 300);
		this.graphics.lineTo(0, 0);
		
		/*
		this.dataType_saveTypes = new DataSource();
		this.dataType_saveTypes.add("LRPK");
		this.dataType_saveTypes.add("JSON");
		this.dataType_saveTypes.add("TRK");
		this.dataType_saveTypes.add("SOL");
		
		this.dropdown_SaveType = new DropDown();
		this.dropdown_SaveType.dataSource = this.dataType_saveTypes;
		this.addChild(this.dropdown_SaveType); */
		
		this.label_trackName = new Label();
		this.label_trackName.text = "Track name:";
		this.addChild(this.label_trackName);
		this.label_trackName.x = 5;
		this.label_trackName.y = 5;
		
		this.textfield_trackName = new TextField();
		this.textfield_trackName.placeholder = "Untitled";
		this.textfield_trackName.y = 5;
		this.textfield_trackName.x = 80;
		this.addChild(this.textfield_trackName);
		
		this.label_AuthorName = new Label();
		this.label_AuthorName.text = "Author:";
		this.addChild(this.label_AuthorName);
		this.label_AuthorName.x = 5;
		this.label_AuthorName.y = 35;
		
		this.textfield_authorName = new TextField();
		this.textfield_authorName.placeholder = "Anonymous";
		this.textfield_authorName.y = 35;
		this.textfield_authorName.x = 80;
		this.addChild(this.textfield_authorName);
		
		this.label_TrackDescription = new Label();
		this.label_TrackDescription.text = "Comment:";
		this.label_TrackDescription.x = 5;
		this.label_TrackDescription.y = 65;
		this.addChild(this.label_TrackDescription);
		
		this.textarea_trackDescription = new TextArea();
		this.textarea_trackDescription.y = 65;
		this.textarea_trackDescription.x = 80;
		this.textarea_trackDescription.width = 300;
		this.textarea_trackDescription.height = 150;
		this.textarea_trackDescription.wrap = true;
		this.textarea_trackDescription.placeholder = "This is the water. And this is the well. Drink full and descend. The horse is the white of the eyes and dark within.";
		this.addChild(this.textarea_trackDescription);
		
		this.label_extraSettings = new Label();
		this.label_extraSettings.x = 5;
		this.label_extraSettings.y = 220;
		//this.label_extraSettings.text = "Config:";
		this.addChild(this.label_extraSettings);
		
		this.option_saveType_LRPK = new OptionBox();
		this.option_saveType_LRPK.groupName = "saveType";
		this.option_saveType_LRPK.text = "LRPK";
		this.option_saveType_LRPK.x = 80;
		this.option_saveType_LRPK.y = 220;
		this.option_saveType_LRPK.selected = true;
		this.option_saveType_LRPK.onChange = function(e:UIEvent) {
			this.checkbox_legacySave.visible = false;
			this.selectedSaveType = SaveType.LRPK;
		}
		//this.addChild(this.option_saveType_LRPK);
		
		this.option_saveType_JSON = new OptionBox();
		this.option_saveType_JSON.groupName = "saveType";
		this.option_saveType_JSON.text = "JSON";
		this.option_saveType_JSON.x = 140;
		this.option_saveType_JSON.y = 220;
		//this.addChild(this.option_saveType_JSON);
		
		this.option_saveType_TRK = new OptionBox();
		this.option_saveType_TRK.groupName = "saveType";
		this.option_saveType_TRK.text = "TRK";
		this.option_saveType_TRK.x = 80;
		this.option_saveType_TRK.y = 240;
		this.option_saveType_TRK.onChange = function(e:UIEvent) {
			this.checkbox_legacySave.visible = false;
			this.selectedSaveType = SaveType.TRK;
		}
		//this.addChild(this.option_saveType_TRK);
		
		this.option_saveType_SOL = new OptionBox();
		this.option_saveType_SOL.groupName = "saveType";
		this.option_saveType_SOL.text = "SOL";
		this.option_saveType_SOL.x = 140;
		this.option_saveType_SOL.y = 240;
		//this.addChild(this.option_saveType_SOL);
		
		this.checkbox_legacySave = new CheckBox();
		this.checkbox_legacySave.visible = false;
		this.checkbox_legacySave.text = "Legacy save";
		this.checkbox_legacySave.x = 80;
		this.checkbox_legacySave.y = 260;
		this.checkbox_legacySave.onClick = function (e:MouseEvent) {
			if (!this.alertbox_legacyInformed && this.checkbox_legacySave.value == true) {
				this.alertbox_legacyWarning = new AlertBox("Legacy saves will not save any features that are exclusive to openLR. If you are familiar with Beta 2, that is the sort of information that will be kept.", this.acknowledge_warning, "Okay");
				this.addChild(this.alertbox_legacyWarning);
				this.alertbox_legacyInformed = true;
			}
			this.saveTypeLegacy = this.checkbox_legacySave.value;
		}
		//this.addChild(this.checkbox_legacySave);
		
		this.textButton_cancel = new TextButton("Cancel", this.exit_save_menu, ButtonSize.b120x30);
		this.addChild(this.textButton_cancel);
		this.textButton_cancel.x = 380;
		this.textButton_cancel.y = 305;
		
		this.textButton_save = new TextButton("Save", this.save_track, ButtonSize.b120x30);
		this.addChild(this.textButton_save);
		this.textButton_save.x = 5;
		this.textButton_save.y = 305;
		
		if (!SVar.new_track) {
			this.textfield_trackName.text = CVar.track_name;
			this.textfield_authorName.text = CVar.track_author;
		}
	}
	function save_track() 
	{
		this.track = new FileJSON();
		this.track.encode(this.textfield_trackName.text, this.textfield_authorName.text, this.textarea_trackDescription.text);
		this.flush_json(track.exportString);
		
		//this.track = new LRPK();
		//this.track.encode(this.textfield_trackName.text, this.textfield_authorName.text, this.textarea_trackDescription.text);
		//this.flush_lrpk(track.exportBytes);
		
		CVar.track_name = this.textfield_trackName.text;
		CVar.track_author = this.textfield_authorName.text;
		SVar.new_track = false;
		this.exit_save_menu();
	}
	function flush_lrpk(_data:ByteArray) {
		var sameNameCount:Int = 0;
		if (!FileSystem.isDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text)) {
			FileSystem.createDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text);
		}
		while (FileSystem.exists(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text + "/" + sameNameCount + "." + this.textfield_trackName.text + ".lrpk")) {
			++sameNameCount;
		}
		var file = File.write((System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text + "/" + sameNameCount + "." + this.textfield_trackName.text + ".lrpk"), true);
		file.writeBytes(_data, 0, _data.length);
		file.close();
	}
	function flush_json(_data:String) //We're assuming json only for now
	{
		var sameNameCount:Int = 0;
		if (!FileSystem.isDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text)) {
			FileSystem.createDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text);
		}
		while (FileSystem.exists(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text + "/" + sameNameCount + "." + this.textfield_trackName.text + ".openLR.json")) {
			++sameNameCount;
		}
		var file = File.write((System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.text + "/" + sameNameCount + "." + this.textfield_trackName.text + ".openLR.json"), true);
		file.writeString(_data);
		file.close();
	}
	private function acknowledge_warning() {
		this.removeChild(this.alertbox_legacyWarning);
	}
	private function exit_save_menu() {
		Common.gCode.toggle_save_menu();
	}
}