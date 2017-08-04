package ui.tool;

import openfl.utils.AssetLibrary;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import ui.tool.icon.IconButton;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Base functions and variables for icons. Default behavior disables mosue tools on rollover and reenables on roll out.
 * 
 */
class IconBase extends Sprite
{
	private var enabled:Bool = true;
	private var iconButton:IconButton;
	private var icon:Sprite;
	public function new(_path:String = "swf/ui/IconUndefined.bundle") 
	{
		super();
		
		this.iconButton = new IconButton();
		this.addChild(this.iconButton);
		if (_path == "") {
			this.attach_listeners();
			this.iconButton.alpha = 0;
			this.iconButton.height = 15;
			return; 
		}
		var swfIcon = AssetLibrary.loadFromFile(_path);
		swfIcon.onComplete(this.attachIcon);
		swfIcon.onError(this.attachNull);
	}
	function attachIcon(lib:AssetLibrary) 
	{
		var innerClip = lib.getMovieClip("");
		this.icon = new Sprite();
		this.icon.addChild(innerClip);
		this.addChild(this.icon);
		this.icon.mouseEnabled = false;
		this.attach_listeners();
	}
	function attachNull(lib:AssetLibrary) 
	{
		trace("import failed");
	}
	private function attach_listeners() {
		this.iconButton.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.iconButton.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.iconButton.addEventListener(MouseEvent.MOUSE_DOWN, down);
		this.iconButton.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, alt);
		this.iconButton.addEventListener(MouseEvent.DOUBLE_CLICK, double_click);
	}
	private function double_click(e:MouseEvent):Void 
	{
		trace ("Double click action not yet set");
	}
	
	public function alt(e:MouseEvent):Void 
	{
		trace("Alt behavior not yet set or not yet overidden");
	}
	
	public function down(e:MouseEvent):Void 
	{
		trace ("action not yet overidden");
	}
	
	private function enable_tool(e:MouseEvent):Void 
	{
		if (!Common.svar_sim_running || Common.gSimManager.paused) {
			Common.gToolBase.enable();
			this.alpha = 1;
		}
		Mouse.cursor = MouseCursor.AUTO;
	}
	
	private function disable_tool(e:MouseEvent):Void 
	{
		if (!Common.svar_sim_running) {
			Common.gToolBase.disable();
			this.alpha = 0.75;
		}
		if (enabled) {
			Mouse.cursor = MouseCursor.BUTTON;
		}
	}
	
	public function enable() {
		this.iconButton.addEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.iconButton.addEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.alpha = 1;
		this.enabled = true;
	}
	
	public function disable() {
		this.iconButton.removeEventListener(MouseEvent.MOUSE_OVER, disable_tool);
		this.iconButton.removeEventListener(MouseEvent.MOUSE_OUT, enable_tool);
		this.alpha = 0.25;
		this.enabled = false;
	}
	public function select() {
		this.graphics.clear();
		this.graphics.lineStyle(3, 0, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(30, 0);
		this.graphics.lineTo(30, 30);
		this.graphics.lineTo(0, 30);
		this.graphics.lineTo(0, 0);
	}
	public function deselect() {
		this.graphics.clear();
	}
}