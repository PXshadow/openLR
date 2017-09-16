package lr.settings;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import openfl.display.StageQuality;

import ui.inter.StepCounter;
import ui.inter.CheckBox;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract Quality(Int) from Int to Int
{
	public var low:Int = 1;
	public var medium:Int = 2;
	public var high:Int = 3;
	public var best:Int = 4;
}
class EngineSettings extends Sprite
{
	
	var sWidth:Float = 0;
	var sHeight:Float = 0;
	
	var gameQuality:StepCounter;
	var frustrumCulling_toggle:CheckBox;
	var toolbar_scale:StepCounter;
	
	private var qual:Int = 4;

	public function new() 
	{
		super();
		
		this.gameQuality = new StepCounter();
		this.addChild(this.gameQuality);
		this.gameQuality.set_numeric_mode(1, 4, 1, 4, " Quality");
		this.gameQuality.stepDown.addEventListener(MouseEvent.CLICK, this.dec_game_quality);
		this.gameQuality.stepUp.addEventListener(MouseEvent.CLICK, this.inc_game_quality);
		
		this.frustrumCulling_toggle = new CheckBox("Line Culling", true);
		this.addChild(this.frustrumCulling_toggle);
		this.frustrumCulling_toggle.y = 35;
		this.frustrumCulling_toggle.hitBox.addEventListener(MouseEvent.CLICK, this.toggle_frustrumCulling);
		
		this.toolbar_scale = new StepCounter();
		this.addChild(this.toolbar_scale);
		this.toolbar_scale.y = 70;
		this.toolbar_scale.set_numeric_mode(0.2, 4, 0.2, 1, " Scale");
		this.toolbar_scale.stepUp.addEventListener(MouseEvent.CLICK, inc_ui_scale);
		this.toolbar_scale.stepDown.addEventListener(MouseEvent.CLICK, dec_ui_scale);
		
		this.sWidth = this.width;
		this.sHeight = this.height;
	
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo( -5, -5);
		this.graphics.lineTo(this.sWidth + 5, -5);
		this.graphics.lineTo(this.sWidth + 5, this.sHeight + 5);
		this.graphics.lineTo(-5, this.sHeight + 5);
		this.graphics.lineTo( -5, -5);
	}
	
	private function inc_game_quality(e:MouseEvent):Void 
	{
		this.qual = this.gameQuality.inc();
		if (this.qual == 2) {
			Lib.current.stage.quality = StageQuality.MEDIUM;
		} else if (this.qual == 3) {
			Lib.current.stage.quality = StageQuality.HIGH;
		} else if (this.qual == 4) {
			Lib.current.stage.quality = StageQuality.BEST;
		}
	}
	
	private function dec_game_quality(e:MouseEvent):Void 
	{
		this.qual = this.gameQuality.dec();
		if (this.qual == 2) {
			Lib.current.stage.quality = StageQuality.MEDIUM;
		} else if (this.qual == 3) {
			Lib.current.stage.quality = StageQuality.HIGH;
		} else if (this.qual == 1) {
			Lib.current.stage.quality = StageQuality.LOW;
		}
	}
	private function dec_ui_scale(e:MouseEvent):Void 
	{
		Common.cvar_toolbar_scale = this.toolbar_scale.dec();
		Common.gCode.setScale();
		Common.gCode.align();
	}
	
	private function inc_ui_scale(e:MouseEvent):Void 
	{
		Common.cvar_toolbar_scale = this.toolbar_scale.inc();
		Common.gCode.setScale();
		Common.gCode.align();
	}
	private function toggle_frustrumCulling(e:MouseEvent):Void 
	{
		Common.cvar_frustrumCulling_enabled = this.frustrumCulling_toggle.toggle();
	}
}