package lr.tool;

import lr.tool.editing.ToolPencil;
import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

import lr.tool.editing.*;
import global.KeyBindings;
import global.Common;
import global.CVar;
import global.SVar;

@:enum abstract ToolType(String) from String to String {
	public var None:String = "None";
	public var Pencil:String = "Pencil";
	public var Line:String = "Line";
	public var Eraser:String = "Eraser";
	public var Pan:String = "Pan";
}

/**
 * ...
 * @author Kaelan Evans
 * 
 * Base functions for anything mouse related, specifically pertaining to click and drag behavior
 * 
 */
class ToolBase
{
	public static var lastTool:String = "None";
	public var currentTool:ToolAction;
	
	public function new(_type:String = "init") 
	{
		SVar.current_tool = _type;
		Common.gToolBase = this;
	}
	public function set_tool(_type:String) {
		this.currentTool = new ToolNone();
		switch(_type) {
			case ToolType.None :
				return;
			case ToolType.Pencil :
				this.currentTool = new ToolPencil();
			case ToolType.Line :
				this.currentTool = new ToolLine();
			case ToolType.Eraser :
				this.currentTool = new ToolEraser();
		}
		if (_type == ToolBase.lastTool) return;
		Common.gToolbar.update_icons(_type);
		ToolBase.lastTool = _type;
	}
	public function set_listeners() {
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, leftMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, leftMouseUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, leftMouseMove);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, rightMouseMove);
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, rightMouseUp);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyModifierDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, KeyModifierUp);
	}
	
	function KeyModifierUp(e:KeyboardEvent):Void 
	{
		switch (e.keyCode) {
			case (Keyboard.SHIFT) :
				this.currentTool.mod_shift = true;
			case (Keyboard.CONTROL) :
				this.currentTool.mod_ctrl = true;
			case (Keyboard.X) :
				this.currentTool.mod_x = true;
			case (Keyboard.Z) :
				this.currentTool.mod_z = true;
		}
	}
	function KeyModifierDown(e:KeyboardEvent):Void 
	{
		switch (e.keyCode) {
			case (Keyboard.SHIFT) :
				this.currentTool.mod_shift = true;
			case (Keyboard.CONTROL) :
				this.currentTool.mod_ctrl = true;
			case (Keyboard.X) :
				this.currentTool.mod_x = true;
			case (Keyboard.Z) :
				this.currentTool.mod_z = true;
		}
	}
	
	function KeyNumDown(e:KeyboardEvent):Void 
	{
		
	}
	
	function rightMouseUp(event:MouseEvent):Void 
	{
		this.currentTool.rightMouseUp(event);
	}
	
	function rightMouseDown(event:MouseEvent):Void 
	{
		this.currentTool.rightMouseDown(event);
	}
	
	function leftMouseMove(event:MouseEvent):Void 
	{
		this.currentTool.leftMouseMove(event);
	}
	
	function rightMouseMove(event:MouseEvent):Void 
	{
		this.currentTool.rightMouseMove(event);
	}
	
	function leftMouseUp(event:MouseEvent):Void 
	{
		this.currentTool.leftMouseUp(event);
	}
	
	function leftMouseDown(e:MouseEvent):Void 
	{
		this.currentTool.leftMouseDown(e);
	}
}