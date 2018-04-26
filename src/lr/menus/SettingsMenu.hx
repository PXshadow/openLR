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
	var checkBox_autoSlow:CheckBox;
	var slider_forceZoom:HSlider;
	var label_zoomValue:TextField;
	var label_slowRate:TextField;
	
	var checkBox_angleSnap:CheckBox;
	var checkBox_jointSnap:CheckBox;
	var checkBox_previewMode:CheckBox;
	var checkbox_scrollCursor:CheckBox;
	
	public var window:WindowBox;
	
	public function new() 
	{
		super();
		
		this.addEventListener(MouseEvent.MOUSE_OVER, this.temToolDis);
		this.addEventListener(MouseEvent.MOUSE_OUT, this.temToolDisDis);
		
		this.window = new WindowBox("Settings", WindowMode.MENU, 300);
		this.addChild(this.window);
		this.window.drag = true;
		this.window.x = this.window.y = 20;
		
		//Track settings
		
		this.checkBox_colorPlay = new CheckBox("Color Play", CVar.volatile.color_play);
		this.checkBox_colorPlay.onChange = function () {
			CVar.volatile.color_play = this.checkBox_colorPlay.value;
		}
		this.window.add_item(this.checkBox_colorPlay);
		
		this.checkBox_hitTest = new CheckBox("Hit Test", CVar.volatile.hit_test);
		this.checkBox_hitTest.onChange = function() {
			CVar.volatile.hit_test = this.checkBox_hitTest.value;
			this.checkBox_hitTestLive.visible = CVar.volatile.hit_test;
		}
		this.window.add_item(this.checkBox_hitTest);
		
		this.checkBox_hitTestLive = new CheckBox("Live Hit Test", CVar.volatile.hit_test_live);
		this.checkBox_hitTestLive.visible = false;
		this.checkBox_hitTestLive.onChange = function() {
			CVar.volatile.hit_test_live = this.checkBox_hitTestLive.value;
		}
		this.window.add_item(this.checkBox_hitTestLive, false, true);
		
		this.checkBox_forceZoom = new CheckBox("Force Zoom: x4", CVar.track.force_zoom);
		this.checkBox_forceZoom.onChange = function() {
			CVar.track.force_zoom = this.checkBox_forceZoom.value;
			this.slider_forceZoom.visible = CVar.track.force_zoom;
		}
		this.window.add_item(this.checkBox_forceZoom);
		
		this.slider_forceZoom = new HSlider(Common.track_scale_min, Common.track_scale_max * 4, 16);
		this.slider_forceZoom.onChange = function():Void {
			CVar.track.force_zoom_ammount = this.slider_forceZoom.value / 4;
			this.checkBox_forceZoom.label.text = "Force Zoom: x" + (CVar.track.force_zoom_ammount);
			this.checkBox_forceZoom.label.width = this.checkBox_forceZoom.label.textWidth + 2;
		}
		this.slider_forceZoom.visible = false;
		this.window.add_item(this.slider_forceZoom, true, true);
		
		this.checkBox_autoSlow = new CheckBox("Auto Slow-mo", CVar.volatile.slow_motion_auto);
		this.checkBox_autoSlow.onChange = function() {
			CVar.volatile.slow_motion_auto = CVar.volatile.slow_motion_auto == true ? false : true;
		}
		this.window.add_item(this.checkBox_autoSlow, false, true);
		
		
		//Editor Settings
		this.checkBox_angleSnap = new CheckBox("Angle Snap", CVar.local.angle_snap);
		this.checkBox_angleSnap.onChange = function() {
			CVar.local.angle_snap = this.checkBox_angleSnap.value;
		}
		this.window.add_item(this.checkBox_angleSnap);
		
		this.checkBox_jointSnap = new CheckBox("Joint Snap", CVar.local.line_snap);
		this.checkBox_jointSnap.onChange = function() {
			CVar.local.line_snap = this.checkBox_jointSnap.value;
		}
		this.window.add_item(this.checkBox_jointSnap, false, true);
		
		this.checkBox_previewMode = new CheckBox("Preview mode", CVar.volatile.preview_mode);
		this.checkBox_previewMode.onChange = function() {
			CVar.volatile.preview_mode = this.checkBox_previewMode.value;
			Common.gTrack.set_rendermode_edit();
		}
		this.window.add_item(this.checkBox_previewMode);
		
		this.checkbox_scrollCursor = new CheckBox("Scroll zoom focuses on cursor", CVar.local.scroll_cursor);
		this.checkbox_scrollCursor.onChange = function():Void {
			CVar.local.scroll_cursor = this.checkbox_scrollCursor.value;
		}
		this.window.add_item(this.checkbox_scrollCursor, true);
		
		this.window.negative.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
			CVar.flushLocal();
			Common.gCode.toggleSettings_box();
		});
	}
	public function update() {
		CVar.loadLocal();
		this.checkBox_angleSnap.set(CVar.local.angle_snap);
		this.checkBox_autoSlow.set(CVar.volatile.slow_motion_auto);
		this.checkBox_colorPlay.set(CVar.volatile.color_play);
		this.checkBox_forceZoom.set(CVar.track.force_zoom);
		this.checkBox_hitTest.set(CVar.volatile.hit_test);
		this.checkBox_jointSnap.set(CVar.local.line_snap);
		this.checkBox_previewMode.set(CVar.volatile.preview_mode);
		this.checkbox_scrollCursor.set(CVar.local.scroll_cursor);
		
		this.slider_forceZoom.set(CVar.track.force_zoom_ammount);
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