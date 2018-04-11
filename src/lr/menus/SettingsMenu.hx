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
import components.CheckBox;
import components.HSlider;

/**
 * ...
 * @author Kaelan Evans
 */
class SettingsMenu extends Sprite
{
	private var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 16, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	private var font_b:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT);
	
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
	var slider_forceZoom:HSlider;
	var label_zoomValue:TextField;
	var label_slowRate:TextField;
	
	var checkBox_angleSnap:CheckBox;
	var checkBox_jointSnap:CheckBox;
	var checkBox_skeleton:CheckBox;
	var checkBox_previewMode:CheckBox;
	var slider_RiderAlpha:HSlider;
	var slider_guiScale:HSlider;
	
	public function new() 
	{
		super();
		
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
		
		this.checkBox_colorPlay = new CheckBox("Color Play", CVar.color_play);
		this.checkBox_colorPlay.onChange = function () {
			CVar.color_play = CVar.color_play == true ? false : true;
			this.checkBox_colorPlay.update(CVar.color_play);
		}
		this.objectList.push(this.checkBox_colorPlay);
		
		this.checkBox_hitTest = new CheckBox("Hit Test", CVar.hit_test);
		this.checkBox_hitTest.onChange = function() {
			CVar.hit_test = CVar.hit_test == true ? false : true;
			this.checkBox_hitTest.update(CVar.hit_test);
		}
		this.objectList.push(this.checkBox_hitTest);
		
		this.checkBox_hitTestLive = new CheckBox("Live Hit Test", CVar.hit_test_live);
		this.checkBox_hitTestLive.visible = false;
		this.checkBox_hitTestLive.onChange = function() {
			CVar.hit_test_live = CVar.hit_test_live == true ? false : true;
			this.checkBox_hitTestLive.update(CVar.hit_test_live);
		}
		this.objectList.push(this.checkBox_hitTestLive);
		
		this.checkBox_forceZoom = new CheckBox("Force Zoom", CVar.force_zoom);
		this.checkBox_forceZoom.onChange = function() {
			CVar.force_zoom = CVar.force_zoom == true ? false : true;
			this.checkBox_forceZoom.update(CVar.force_zoom);
			this.slider_forceZoom.visible = CVar.force_zoom;
			this.label_zoomValue.visible = CVar.force_zoom;
		}
		this.objectList.push(this.checkBox_forceZoom);
		
		this.objectList.push(this.forceReturn);
		
		this.label_zoomValue = new TextField();
		this.label_zoomValue.text = "Zoom: " + CVar.force_zoom_ammount;
		this.label_zoomValue.visible = false;
		this.objectList.push(this.label_zoomValue);
		
		this.slider_forceZoom = new HSlider(Common.track_scale_min, Common.track_scale_max, 4);
		this.slider_forceZoom.onChange = function():Void {
			CVar.force_zoom_ammount = this.slider_forceZoom.value;
			this.label_zoomValue.text = "Zoom: " + CVar.force_zoom_ammount;
		}
		this.slider_forceZoom.visible = false;
		this.objectList.push(this.slider_forceZoom);
		
		this.objectList.push(this.forceReturn);
		
		this.checkBox_autoSlow = new CheckBox("Auto Slow-mo", CVar.slow_motion_auto);
		this.checkBox_autoSlow.onChange = function() {
			CVar.slow_motion_auto = CVar.slow_motion_auto == true ? false : true;
		}
		this.objectList.push (this.checkBox_autoSlow);
		
		this.objectList.push(this.forceReturn);
		
		//Editor Settings
		this.dividerEditorSettings = new TextField();
		this.dividerEditorSettings.defaultTextFormat = font_a;
		this.dividerEditorSettings.width = 300;
		this.dividerEditorSettings.selectable = false;
		this.dividerEditorSettings.text = "Editor Settings";
		this.objectList.push(this.dividerEditorSettings);
		
		this.checkBox_angleSnap = new CheckBox("Angle Snap", CVar.angle_snap);
		this.checkBox_angleSnap.onChange = function() {
			CVar.angle_snap = CVar.angle_snap == true ? false : true;
			this.checkBox_angleSnap.update(CVar.angle_snap);
		}
		this.objectList.push(this.checkBox_angleSnap);
		
		this.checkBox_jointSnap = new CheckBox("Joint Snap", CVar.line_snap);
		this.checkBox_jointSnap.onChange = function() {
			CVar.line_snap = CVar.line_snap == true ? false : true;
			this.checkBox_jointSnap.update(CVar.line_snap);
		}
		this.objectList.push(this.checkBox_jointSnap);
		
		this.objectList.push(this.forceReturn);
		
		this.checkBox_skeleton = new CheckBox("Skeleton", CVar.contact_points);
		this.checkBox_skeleton.onChange = function() {
			CVar.contact_points = CVar.contact_points == true ? false : true;
			this.checkBox_skeleton.update(CVar.contact_points);
		}
		this.objectList.push(this.checkBox_skeleton);
		
		this.slider_RiderAlpha = new HSlider(0, 10, 10);
		this.slider_RiderAlpha.onChange = function() {
			CVar.rider_alpha = this.slider_RiderAlpha.value;
		}
		this.objectList.push(this.slider_RiderAlpha);
		
		this.checkBox_previewMode = new CheckBox("Preview mode", CVar.preview_mode);
		this.checkBox_previewMode.onChange = function() {
			CVar.preview_mode = CVar.preview_mode == true ? false : true;
			this.checkBox_previewMode.update(CVar.preview_mode);
			Common.gTrack.set_rendermode_edit();
		}
		this.objectList.push(this.checkBox_previewMode);
		
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
			a.y = i * 35;
			if (Std.is(a, TextField)) { //Section divider
				if (i != 0) {
					if (j != 0) {
						i += 2;
						a.y += 35;
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
					a.x = 15;
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