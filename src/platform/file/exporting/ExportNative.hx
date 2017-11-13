package platform.file.exporting;

import haxe.ui.core.UIEvent;
import platform.file.ExportBase;
import platform.file.fileType.FileBase;
import platform.file.fileType.LRPK;
import platform.file.fileType.JSON;
import platform.file.fileType.TRK;
import platform.file.fileType.SOL;
import ui.inter.AlertBox;

import haxe.ui.Toolkit;
import haxe.ui.components.DropDown;
import haxe.ui.components.Label;
import haxe.ui.components.TextField;
import haxe.ui.components.TextArea;
import haxe.ui.components.CheckBox;
import haxe.ui.components.OptionBox;
import haxe.ui.core.MouseEvent;
import haxe.ui.data.ArrayDataSource;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Placeholders commented out as HaxeUI is still indev and these were causing issues
 */
class ExportNative extends ExportBase 
{
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
	
	public function new() 
	{
		super();
		
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(500, 0);
		this.graphics.lineTo(500, 300);
		this.graphics.lineTo(0, 300);
		this.graphics.lineTo(0, 0);
		
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
		this.label_TrackDescription.text = "Description:";
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
		this.label_extraSettings.text = "Config:";
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
		this.addChild(this.option_saveType_LRPK);
		
		this.option_saveType_JSON = new OptionBox();
		this.option_saveType_JSON.groupName = "saveType";
		this.option_saveType_JSON.text = "JSON";
		this.option_saveType_JSON.x = 140;
		this.option_saveType_JSON.y = 220;
		this.addChild(this.option_saveType_JSON);
		
		this.option_saveType_TRK = new OptionBox();
		this.option_saveType_TRK.groupName = "saveType";
		this.option_saveType_TRK.text = "TRK";
		this.option_saveType_TRK.x = 80;
		this.option_saveType_TRK.y = 240;
		this.option_saveType_TRK.onChange = function(e:UIEvent) {
			this.checkbox_legacySave.visible = false;
			this.selectedSaveType = SaveType.TRK;
		}
		this.addChild(this.option_saveType_TRK);
		
		this.option_saveType_SOL = new OptionBox();
		this.option_saveType_SOL.groupName = "saveType";
		this.option_saveType_SOL.text = "SOL";
		this.option_saveType_SOL.x = 140;
		this.option_saveType_SOL.y = 240;
		this.addChild(this.option_saveType_SOL);
		
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
		this.addChild(this.checkbox_legacySave);
	}
	private function acknowledge_warning() {
		this.removeChild(this.alertbox_legacyWarning);
	}
}