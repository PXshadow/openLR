package lr.menus;

import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import ui.inter.TextButton;
import global.Common;
import global.CVar;
import lr.tool.ToolBase;
import components.CheckBox;
import components.HSlider;
import components.WindowBox;

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
	
	var window:WindowBox;
	
	public function new() 
	{
		super();
		
		this.addEventListener(MouseEvent.MOUSE_OVER, this.temToolDis);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.temToolDisDis);
		
		this.window = new WindowBox("Settings", WindowMode.MENU, 400);
		this.addChild(this.window);
		this.window.drag = true;
		this.window.x = this.window.y = 20;
		
		//Track settings
		
		this.checkBox_colorPlay = new CheckBox("Color Play", CVar.color_play);
		this.checkBox_colorPlay.onChange = function () {
			CVar.color_play = CVar.color_play == true ? false : true;
			this.checkBox_colorPlay.update(CVar.color_play);
		}
		this.window.add_item(this.checkBox_colorPlay);
		
		this.checkBox_hitTest = new CheckBox("Hit Test", CVar.hit_test);
		this.checkBox_hitTest.onChange = function() {
			CVar.hit_test = CVar.hit_test == true ? false : true;
			this.checkBox_hitTest.update(CVar.hit_test);
			this.checkBox_hitTestLive.visible = CVar.hit_test;
		}
		this.window.add_item(this.checkBox_hitTest);
		
		this.checkBox_hitTestLive = new CheckBox("Live Hit Test", CVar.hit_test_live);
		this.checkBox_hitTestLive.visible = false;
		this.checkBox_hitTestLive.onChange = function() {
			CVar.hit_test_live = CVar.hit_test_live == true ? false : true;
			this.checkBox_hitTestLive.update(CVar.hit_test_live);
		}
		this.window.add_item(this.checkBox_hitTestLive, false, true);
		
		this.checkBox_forceZoom = new CheckBox("Force Zoom", CVar.force_zoom);
		this.checkBox_forceZoom.onChange = function() {
			CVar.force_zoom = CVar.force_zoom == true ? false : true;
			this.checkBox_forceZoom.update(CVar.force_zoom);
			this.slider_forceZoom.visible = CVar.force_zoom;
			this.label_zoomValue.visible = CVar.force_zoom;
		}
		this.window.add_item(this.checkBox_forceZoom);
		
		this.label_zoomValue = new TextField();
		this.label_zoomValue.text = "Zoom: " + CVar.force_zoom_ammount;
		this.label_zoomValue.visible = false;
		//this.window.add_item(this.label_zoomValue);
		
		this.slider_forceZoom = new HSlider(Common.track_scale_min, Common.track_scale_max, 4);
		this.slider_forceZoom.onChange = function():Void {
			CVar.force_zoom_ammount = this.slider_forceZoom.value;
			this.label_zoomValue.text = "Zoom: " + CVar.force_zoom_ammount;
		}
		this.slider_forceZoom.visible = false;
		this.window.add_item(this.slider_forceZoom, true, true);
		
		this.checkBox_autoSlow = new CheckBox("Auto Slow-mo", CVar.slow_motion_auto);
		this.checkBox_autoSlow.onChange = function() {
			CVar.slow_motion_auto = CVar.slow_motion_auto == true ? false : true;
		}
		this.window.add_item(this.checkBox_autoSlow, false, true);
		
		
		//Editor Settings
		this.checkBox_angleSnap = new CheckBox("Angle Snap", CVar.angle_snap);
		this.checkBox_angleSnap.onChange = function() {
			CVar.angle_snap = CVar.angle_snap == true ? false : true;
			this.checkBox_angleSnap.update(CVar.angle_snap);
		}
		this.window.add_item(this.checkBox_angleSnap);
		
		this.checkBox_jointSnap = new CheckBox("Joint Snap", CVar.line_snap);
		this.checkBox_jointSnap.onChange = function() {
			CVar.line_snap = CVar.line_snap == true ? false : true;
			this.checkBox_jointSnap.update(CVar.line_snap);
		}
		this.window.add_item(this.checkBox_jointSnap, false, true);
		
		this.checkBox_skeleton = new CheckBox("Skeleton", CVar.contact_points);
		this.checkBox_skeleton.onChange = function() {
			CVar.contact_points = CVar.contact_points == true ? false : true;
			this.checkBox_skeleton.update(CVar.contact_points);
		}
		this.window.add_item(this.checkBox_skeleton, false, true);
		
		this.slider_RiderAlpha = new HSlider(0, 10, 10);
		this.slider_RiderAlpha.onChange = function() {
			CVar.rider_alpha = this.slider_RiderAlpha.value;
		}
		this.window.add_item(this.slider_RiderAlpha, false, true);
		
		this.checkBox_previewMode = new CheckBox("Preview mode", CVar.preview_mode);
		this.checkBox_previewMode.onChange = function() {
			CVar.preview_mode = CVar.preview_mode == true ? false : true;
			this.checkBox_previewMode.update(CVar.preview_mode);
			Common.gTrack.set_rendermode_edit();
		}
		this.window.add_item(this.checkBox_previewMode);
		
		this.window.negative.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
			Common.gCode.toggleSettings_box();
		});
	}
	public function update() {
		this.window.x = this.window.y = 20;
	}
	function temToolDisDis(e:MouseEvent):Void 
	{
		Common.gToolBase.set_tool(ToolBase.lastTool);
	}
	function temToolDis(e:MouseEvent):Void 
	{
		Common.gToolBase.set_tool("None");
	}
}