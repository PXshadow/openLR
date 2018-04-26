package platform.file.exporting;

import global.Common;
import openfl.utils.ByteArray;
import platform.file.fileType.FileBase;
import sys.FileSystem;
import sys.io.File;
import lime.system.System;

import components.WindowBox;
import global.SVar;
import global.CVar;
import platform.file.ExportBase;
import platform.file.fileType.*;
import ui.inter.TextButton;
import components.Label;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Placeholders commented out as HaxeUI is still indev and these were causing issues
 */
class ExportSys extends ExportBase 
{
	//var dropdown_SaveType:DropDown;
	//var dataType_saveTypes:DataSource<String>;
	
	var label_trackName:Label;
	var label_AuthorName:Label;
	var label_TrackDescription:Label;
	var textfield_trackName:Label;
	var textfield_authorName:Label;
	var textarea_trackDescription:Label;
	
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
		
		this.label_trackName = new Label(LabelType.DYNAMIC, "Track name:");
		this.addChild(this.label_trackName);
		this.label_trackName.x = 5;
		this.label_trackName.y = 5;
		
		this.textfield_trackName = new Label(LabelType.INPUT, "Untitled");
		this.textfield_trackName.y = 5;
		this.textfield_trackName.x = 100;
		this.addChild(this.textfield_trackName);
		
		this.label_AuthorName = new Label(LabelType.DYNAMIC, "Author:");
		this.addChild(this.label_AuthorName);
		this.label_AuthorName.x = 5;
		this.label_AuthorName.y = 35;
		
		this.textfield_authorName = new Label(LabelType.INPUT, "Anonymous");
		this.textfield_authorName.y = 35;
		this.textfield_authorName.x = 100;
		this.addChild(this.textfield_authorName);
		
		this.label_TrackDescription = new Label(LabelType.DYNAMIC, "Comment:");
		this.label_TrackDescription.x = 5;
		this.label_TrackDescription.y = 65;
		this.addChild(this.label_TrackDescription);
		
		this.textarea_trackDescription = new Label(LabelType.INPUT_BOX, "This is the water. And this is the well. Drink full and descend. The horse is the white of the eyes and dark within.", 300, 150);
		this.textarea_trackDescription.y = 65;
		this.textarea_trackDescription.x = 100;
		this.addChild(this.textarea_trackDescription);
		
		this.textButton_cancel = new TextButton("Cancel", this.exit_save_menu);
		this.addChild(this.textButton_cancel);
		this.textButton_cancel.x = 380;
		this.textButton_cancel.y = 305;
		
		this.textButton_save = new TextButton("Save", this.save_track);
		this.addChild(this.textButton_save);
		this.textButton_save.x = 5;
		this.textButton_save.y = 305;
		
		if (!SVar.new_track) {
			this.textfield_trackName.set(CVar.track.name);
			this.textfield_authorName.set(CVar.track.author);
		}
	}
	function save_track() 
	{
		this.track = new FileJSON();
		this.track.encode(this.textfield_trackName.value, this.textfield_authorName.value, this.textarea_trackDescription.value);
		this.flush_json(track.exportString);
		
		
		CVar.track.name = this.textfield_trackName.value;
		CVar.track.author = this.textfield_authorName.value;
		SVar.new_track = false;
		this.exit_save_menu();
	}
	function flush_lrpk(_data:ByteArray) {
		var sameNameCount:Int = 0;
		if (!FileSystem.isDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value)) {
			FileSystem.createDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value);
		}
		while (FileSystem.exists(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value + "/" + sameNameCount + "." + this.textfield_trackName.value + ".lrpk")) {
			++sameNameCount;
		}
		var file = File.write((System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value + "/" + sameNameCount + "." + this.textfield_trackName.value + ".lrpk"), true);
		file.writeBytes(_data, 0, _data.length);
		file.close();
	}
	function flush_json(_data:String) //We're assuming json only for now
	{
		var sameNameCount:Int = 0;
		if (!FileSystem.isDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value)) {
			FileSystem.createDirectory(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value);
		}
		while (FileSystem.exists(System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value + "/" + sameNameCount + "." + this.textfield_trackName.value + ".openLR.json")) {
			++sameNameCount;
		}
		var file = File.write((System.documentsDirectory + "/openLR/saves/" + this.textfield_trackName.value + "/" + sameNameCount + "." + this.textfield_trackName.value + ".openLR.json"), true);
		file.writeString(_data);
		file.close();
	}
	private function exit_save_menu() {
		Common.gCode.toggle_save_menu();
	}
}