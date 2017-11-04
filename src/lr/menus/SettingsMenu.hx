package lr.menus;

import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import ui.inter.TextButton;
import ui.inter.CheckBox;
import global.Language;
import global.Common;
import global.CVar;

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
	
	var checkBox_colorPlay:CheckBox;
	var checkBox_hitTest:CheckBox;
	var checkBox_hitTestLive:CheckBox;
	
	public function new() 
	{
		super();
		
		this.graphics.clear();
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(400, 0);
		this.graphics.lineTo(400, 500);
		this.graphics.lineTo(0, 500);
		this.graphics.lineTo(0, 0);
		
		this.objectList = new Array();
		
		
		//Track settings
		this.dividerTrackSettings = new TextField();
		this.dividerTrackSettings.defaultTextFormat = font_a;
		this.dividerTrackSettings.width = 300;
		this.dividerTrackSettings.selectable = false;
		this.dividerTrackSettings.text = "Track Settings";
		this.objectList.push(this.dividerTrackSettings);
		
		this.checkBox_colorPlay = new CheckBox("Color Play", false);
		this.checkBox_colorPlay.hitBox.addEventListener(MouseEvent.MOUSE_UP, this.toggle_colorPlay);
		this.objectList.push(this.checkBox_colorPlay);
		
		this.checkBox_hitTest = new CheckBox("Hit test", false);
		this.checkBox_hitTest.hitBox.addEventListener(MouseEvent.MOUSE_UP, this.toggle_hitTest);
		this.objectList.push(this.checkBox_hitTest);
		
		this.checkBox_hitTestLive = new CheckBox("Live", false);
		this.checkBox_hitTestLive.visible = false;
		this.objectList.push(this.checkBox_hitTestLive);
		
		//Editor Settings
		this.dividerEditorSettings = new TextField();
		this.dividerEditorSettings.defaultTextFormat = font_a;
		this.dividerEditorSettings.width = 300;
		this.dividerEditorSettings.selectable = false;
		this.dividerEditorSettings.text = "Editor Settings";
		this.objectList.push(this.dividerEditorSettings);
		
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
			if (Std.is(a, TextField)) {
				j = 0;
				++i;
			} else { 
				a.x = 30 + (100 * j);
				++j;
				if (j == 3) {
					j = 0;
					++i;
				}
			}
		}
		
		this.close = new TextButton("Close", Common.gCode.toggleSettings_box, 1);
		this.addChild(this.close);
		this.close.y = 505;
	}
	public function update() {
		
	}
	//setting functions
	
	private function toggle_colorPlay(e:MouseEvent):Void 
	{
		CVar.color_play = checkBox_colorPlay.toggle();
	}
	private function toggle_hitTest(e:MouseEvent):Void 
	{
		CVar.hit_test = checkBox_hitTest.toggle();
		this.checkBox_hitTestLive.visible = CVar.hit_test;
	}
}