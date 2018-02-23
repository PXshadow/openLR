package lr.menus;

import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import ui.inter.TextButton;
import global.Common;
import global.CVar;

import haxe.ui.Toolkit;
import haxe.ui.components.CheckBox;
import haxe.ui.components.HSlider;
import haxe.ui.components.Label;
import haxe.ui.core.MouseEvent;
import haxe.ui.core.UIEvent;

/**
 * ...
 * @author Kaelan Evans
 */
class SettingsMenu extends Sprite
{
	private var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	
	var objectList:Array<DisplayObject>;
	var close:TextButton;
	var list:Sprite;
	var listMask:Sprite;
	
	var dividerTrackSettings:TextField;
	var dividerEditorSettings:TextField;
	
	var forceReturn:Shape;
	
	var checkBox_colorPlay:CheckBox;
	var checkBox_hitTest:CheckBox;
	var checkBox_hitTestLive:CheckBox;
	var checkBox_forceZoom:CheckBox;
	var checkBox_forceInverse:CheckBox;
	var checkBox_autoSlow:CheckBox;
	var slider_autoSlowRate:HSlider;
	var slider_forceZoom:HSlider;
	var label_zoomValue:Label;
	var label_slowRate:Label;
	
	var checkBox_angleSnap:CheckBox;
	var checkBox_jointSnap:CheckBox;
	var checkBox_skeleton:CheckBox;
	var checkBox_previewMode:CheckBox;
	var slider_RiderAlpha:HSlider;
	var slider_guiScale:HSlider;
	var label_riderAlpha:Label;
	var label_guiScale:Label;
	
	public function new() 
	{
		super();
		
		Toolkit.init();
		
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(350, 0);
		this.graphics.lineTo(350, 400);
		this.graphics.lineTo(0, 400);
		this.graphics.lineTo(0, 0);
		
		this.objectList = new Array();
		
		this.forceReturn = new Shape();
		
		//Track settings
		this.dividerTrackSettings = new TextField();
		this.dividerTrackSettings.defaultTextFormat = font_a;
		this.dividerTrackSettings.width = 300;
		this.dividerTrackSettings.selectable = false;
		this.dividerTrackSettings.text = "Track Settings";
		this.objectList.push(this.dividerTrackSettings);
		
		this.checkBox_colorPlay = new CheckBox();
		this.checkBox_colorPlay.text = "Color Play";
		this.checkBox_colorPlay.onClick = function (e:MouseEvent):Void {
			CVar.color_play = this.checkBox_colorPlay.value;
		}
		this.objectList.push(this.checkBox_colorPlay);
		
		this.checkBox_hitTest = new CheckBox();
		this.checkBox_hitTest.text = "Hit Test";
		this.checkBox_hitTest.onClick = function(e:MouseEvent) {
			CVar.hit_test = this.checkBox_hitTestLive.visible = this.checkBox_hitTest.value;
		}
		this.objectList.push(this.checkBox_hitTest);
		
		this.checkBox_hitTestLive = new CheckBox();
		this.checkBox_hitTestLive.text = "Live Hit Test";
		this.checkBox_hitTestLive.visible = false;
		this.checkBox_hitTestLive.onClick = function(e:MouseEvent) {
			CVar.hit_test_live = this.checkBox_hitTestLive.value;
		}
		this.objectList.push(this.checkBox_hitTestLive);
		
		this.checkBox_forceZoom = new CheckBox();
		this.checkBox_forceZoom.text = "Force Zoom";
		this.checkBox_forceZoom.onClick = function(e:MouseEvent) {
			CVar.force_zoom = this.label_zoomValue.visible = this.slider_forceZoom.visible = this.checkBox_forceZoom.value;
		}
		this.objectList.push(this.checkBox_forceZoom);
		
		this.checkBox_forceInverse = new CheckBox();
		this.checkBox_forceInverse.text = "Inverse";
		this.checkBox_forceInverse.onClick = function(e:MouseEvent) {
			CVar.force_zoom_inverse = this.checkBox_forceInverse.value;
		}
		this.objectList.push(this.checkBox_forceInverse);
		
		this.objectList.push(this.forceReturn);
		
		this.label_zoomValue = new Label();
		this.label_zoomValue.text = "Zoom: " + CVar.force_zoom_ammount;
		this.label_zoomValue.visible = false;
		this.objectList.push(this.label_zoomValue);
		
		this.slider_forceZoom = new HSlider();
		this.slider_forceZoom.value = 4;
		this.slider_forceZoom.min = Common.track_scale_min;
		this.slider_forceZoom.max = Common.track_scale_max;
		this.slider_forceZoom.onChange = function(e:UIEvent):Void {
			CVar.force_zoom_ammount = this.slider_forceZoom.value;
			this.label_zoomValue.text = "Zoom: " + CVar.force_zoom_ammount;
		}
		this.slider_forceZoom.visible = false;
		this.objectList.push(this.slider_forceZoom);
		
		this.objectList.push(this.forceReturn);
		
		this.checkBox_autoSlow = new CheckBox();
		this.checkBox_autoSlow.text = "Auto Slow-mo";
		this.checkBox_autoSlow.onClick = function(e:MouseEvent) {
			CVar.slow_motion_auto = this.checkBox_autoSlow.value;
		}
		this.objectList.push (this.checkBox_autoSlow);
		
		this.objectList.push(this.forceReturn);
		
		this.label_slowRate = new Label();
		this.label_slowRate.text = "FPS: " + CVar.slow_motion_rate;
		this.objectList.push(this.label_slowRate);
		
		this.slider_autoSlowRate = new HSlider();
		this.slider_autoSlowRate.value = 5;
		this.slider_autoSlowRate.min = 1;
		this.slider_autoSlowRate.max = 40;
		this.slider_autoSlowRate.onChange = function(e:UIEvent) {
			CVar.slow_motion_rate = this.slider_autoSlowRate.value;
			this.label_slowRate.text = "FPS: " + CVar.slow_motion_rate;
		}
		this.objectList.push(this.slider_autoSlowRate);
		
		//Editor Settings
		this.dividerEditorSettings = new TextField();
		this.dividerEditorSettings.defaultTextFormat = font_a;
		this.dividerEditorSettings.width = 300;
		this.dividerEditorSettings.selectable = false;
		this.dividerEditorSettings.text = "Editor Settings";
		this.objectList.push(this.dividerEditorSettings);
		
		this.checkBox_angleSnap = new CheckBox();
		this.checkBox_angleSnap.text = "Angle Snap";
		this.checkBox_angleSnap.onClick = function(e:MouseEvent) {
			CVar.angle_snap = this.checkBox_angleSnap.value;
		}
		this.objectList.push(this.checkBox_angleSnap);
		
		this.checkBox_jointSnap = new CheckBox();
		this.checkBox_jointSnap.text = "Joint Snap";
		this.checkBox_jointSnap.value = true;
		this.checkBox_jointSnap.onClick = function(e:MouseEvent) {
			CVar.line_snap = this.checkBox_jointSnap.value;
		}
		this.objectList.push(this.checkBox_jointSnap);
		
		this.objectList.push(this.forceReturn);
		
		this.checkBox_skeleton = new CheckBox();
		this.checkBox_skeleton.text = "Skeleton";
		this.checkBox_skeleton.onClick = function(e:MouseEvent) {
			CVar.contact_points = this.checkBox_skeleton.value;
		}
		this.objectList.push(this.checkBox_skeleton);
		
		this.label_riderAlpha = new Label();
		this.label_riderAlpha.text = "Alpha: ";
		this.label_riderAlpha.width = 200;
		this.objectList.push(this.label_riderAlpha);
		
		this.slider_RiderAlpha = new HSlider();
		this.slider_RiderAlpha.min = 0;
		this.slider_RiderAlpha.max = 10;
		this.slider_RiderAlpha.value = 10;
		this.slider_RiderAlpha.onChange = function(e:UIEvent) {
			CVar.rider_alpha = this.slider_RiderAlpha.value;
		}
		this.objectList.push(this.slider_RiderAlpha);
		
		this.checkBox_previewMode = new CheckBox();
		this.checkBox_previewMode.text = "Preview mode";
		this.checkBox_previewMode.onClick = function(e:MouseEvent) {
			CVar.preview_mode = this.checkBox_previewMode.value;
			Common.gTrack.set_rendermode_edit();
		}
		this.objectList.push(this.checkBox_previewMode);
		
		this.objectList.push(this.forceReturn);
		
		this.label_guiScale = new Label();
		this.label_guiScale.text = "GUI Scale: ";
		this.objectList.push(this.label_guiScale);
		
		this.slider_guiScale = new HSlider();
		this.slider_guiScale.value = 1;
		this.slider_guiScale.min = 1;
		this.slider_guiScale.max = 5;
		this.slider_guiScale.onChange = function(e:UIEvent) {
			CVar.toolbar_scale = this.slider_guiScale.value;
			Common.gCode.setScale();
			Common.gCode.align();
		}
		this.objectList.push(this.slider_guiScale);
		
		this.attachItems();
	}
	function attachItems() 
	{
		this.list = new Sprite();
		this.addChild(this.list);
		this.list.x = 5;
		this.list.y = 5;
		
		var i = 0;
		var j = 0;
		for (a in this.objectList) {
			this.list.addChild(a);
			a.y = i * 30;
			if (Std.is(a, TextField)) { //Section divider
				if (i != 0) {
					if (j != 0) {
						i += 2;
						a.y += 30;
					} else {
						++i;
					}
				} else {
					++i;
				}
				j = 0;
			} else if (Std.is(a, Shape)) { //Force return
				++i;
				j = 0;
			} else { //Normal object placement
				a.x = 15 + (105 * j);
				if (Std.is(a, HSlider) && j > 0) { //special indenting for slider
					a.x -= 45;
				}
				++j;
				if (j == 3) {
					j = 0;
					++i;
				}
			}
		}

		this.close = new TextButton("Close", Common.gCode.toggleSettings_box);
		this.addChild(this.close);
		this.close.y = 405;
	}
	public function update() {
		
	}
}