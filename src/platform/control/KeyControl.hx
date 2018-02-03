package platform.control;

import haxe.Json;
import lime.system.System;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.utils.Object;
import sys.FileSystem;
import sys.io.File;

import global.Common;
import global.CVar;
import global.SVar;
import lr.nodes.Grid;
import lr.tool.Toolbar;
import lr.tool.ToolBase;

/**
 * ...
 * @author Kaelan Evans
 */
class KeyControl 
{

	private var bindings:KeyBindings;
	public function new() 
	{
		this.bindings = new KeyBindings();
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyPress_single);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPress_repeat);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPress_down);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyPress_release);
	}
	function keyPress_single(e:KeyboardEvent) {
		if (!SVar.keysEnabled) return;
		switch (e.keyCode) {
			//Tools
			case Keyboard.Q :
				if (!SVar.sim_running) Toolbar.tool.set_tool(ToolType.Pencil);
			case Keyboard.W :
				if (!SVar.sim_running) Toolbar.tool.set_tool(ToolType.Line);
			case Keyboard.E :
				if (!SVar.sim_running) Toolbar.tool.set_tool(ToolType.Eraser);
			//Swatches
			case Keyboard.NUMBER_1 :
				if (!SVar.sim_running) Common.gToolbar.update_swatch(0);
			case Keyboard.NUMBER_2 :
				if (!SVar.sim_running) Common.gToolbar.update_swatch(1);
			case Keyboard.NUMBER_3 :
				if (!SVar.sim_running) Common.gToolbar.update_swatch(2);
			//Shortcuts and Actions
			case Keyboard.Z :
				if (e.controlKey) Common.gGrid.add_remove_action(Action.undo_action);
			case Keyboard.Y :
				if (e.controlKey) Common.gGrid.add_remove_action(Action.redo_action);
				else Common.globalPlay();
			case Keyboard.BACKSPACE :
				if (e.shiftKey) Common.gGrid.add_remove_action(Action.redo_line);
				else Common.gGrid.add_remove_action(Action.undo_line);
			case Keyboard.SPACE :
				Common.gSimManager.pause_play_toggle();
			case Keyboard.M :
				if (SVar.sim_running) Common.gSimManager.slow_motion_toggle();
			case Keyboard.N :
				if (SVar.sim_running) Common.gSimManager.fast_forward_toggle();
			case Keyboard.B :
				if (SVar.sim_running) Common.gSimManager.rewind_toggle();
			case Keyboard.I :
				Common.globalFlagPlace();
		}
	}
	function keyPress_repeat(e:KeyboardEvent) {
		if (!SVar.keysEnabled) return;
		switch (e.keyCode) {
			case Keyboard.LEFT :
				if (e.shiftKey) Common.gSimManager.sub_step_backward();
				else Common.gSimManager.step_backward();
			case Keyboard.RIGHT :
				if (e.shiftKey) Common.gSimManager.sub_step_forward();
				else Common.gSimManager.step_forward();
		}
	}
	function keyPress_down(e:KeyboardEvent) {
		if (!SVar.keysEnabled) return;
		switch (e.keyCode) {
			case Keyboard.SHIFT :
				CVar.mod_shift = true;
			case Keyboard.CONTROL :
				CVar.mod_ctrl = true;
			case Keyboard.COMMAND :
				CVar.mod_ctrl = true;
			case Keyboard.ALTERNATE :
				CVar.mod_alt = true;
			case Keyboard.Z :
				CVar.mod_z = true;
			case Keyboard.X :
				CVar.mod_x = true;
		}
	}
	function keyPress_release(e:KeyboardEvent) {
		if (!SVar.keysEnabled) return;
		switch (e.keyCode) {
			case Keyboard.SHIFT :
				CVar.mod_shift = false;
			case Keyboard.CONTROL :
				CVar.mod_ctrl = false;
			case Keyboard.COMMAND :
				CVar.mod_ctrl = false;
			case Keyboard.ALTERNATE :
				CVar.mod_alt = false;
			case Keyboard.Z :
				CVar.mod_z = false;
			case Keyboard.X :
				CVar.mod_x = false;
		}
	}
}
class KeyBindings 
{
	public static var pencil:Int = Keyboard.Q;
	public static var line:Int = Keyboard.W;
	public static var eraser:Int = Keyboard.E;
	public static var swatch_blue:Int = Keyboard.NUMBER_1;
	public static var swatch_red:Int = Keyboard.NUMBER_2;
	public static var swatch_green:Int = Keyboard.NUMBER_3;
	public static var play:Int = Keyboard.Y;
	public static var stop:Int = Keyboard.U;
	public static var flag:Int = Keyboard.I;
	public static var angle_snap:Int = Keyboard.X;
	public static var line_snap:Int = Keyboard.S;
	public static var ff_toggle:Int = Keyboard.N;
	public static var sm_toggle:Int = Keyboard.M;
	public static var rw_toggle:Int = Keyboard.B;
	public static var pp_toggle:Int = Keyboard.SPACE;
	public static var step_forward:Int = Keyboard.RIGHT;
	public static var step_backward:Int = Keyboard.LEFT;
	public static var undo_line:Int = Keyboard.BACKSPACE;
	
	private var KeyMap:Map<String, Int>;
	
	public function new() {
		this.KeyMap = new Map();
		this.setMapBinds();
		this.setGlobalBinds();
	}
	function setGlobalBinds() 
	{
		if (!FileSystem.exists(System.documentsDirectory + "openLR/Binds.txt")) {
			this.write_settings();
			return;
		} else {
			//Load json here
		}
	}
	private function setMapBinds() 
	{
		this.KeyMap["0"] = Keyboard.NUMBER_0;
		this.KeyMap["1"] = Keyboard.NUMBER_1;
		this.KeyMap["2"] = Keyboard.NUMBER_2;
		this.KeyMap["3"] = Keyboard.NUMBER_3;
		this.KeyMap["4"] = Keyboard.NUMBER_4;
		this.KeyMap["5"] = Keyboard.NUMBER_5;
		this.KeyMap["6"] = Keyboard.NUMBER_6;
		this.KeyMap["7"] = Keyboard.NUMBER_7;
		this.KeyMap["8"] = Keyboard.NUMBER_8;
		this.KeyMap["9"] = Keyboard.NUMBER_9;
		this.KeyMap["="] = Keyboard.EQUAL;
		this.KeyMap["+"] = Keyboard.EQUAL;
		this.KeyMap["-"] = Keyboard.MINUS;
		this.KeyMap["_"] = Keyboard.MINUS;
		this.KeyMap["A"] = Keyboard.A;
		this.KeyMap["B"] = Keyboard.B;
		this.KeyMap["C"] = Keyboard.C;
		this.KeyMap["D"] = Keyboard.D;
		this.KeyMap["E"] = Keyboard.E;
		this.KeyMap["F"] = Keyboard.F;
		this.KeyMap["G"] = Keyboard.G;
		this.KeyMap["H"] = Keyboard.H;
		this.KeyMap["I"] = Keyboard.I;
		this.KeyMap["J"] = Keyboard.J;
		this.KeyMap["K"] = Keyboard.K;
		this.KeyMap["L"] = Keyboard.L;
		this.KeyMap["M"] = Keyboard.M;
		this.KeyMap["N"] = Keyboard.N;
		this.KeyMap["O"] = Keyboard.O;
		this.KeyMap["P"] = Keyboard.P;
		this.KeyMap["Q"] = Keyboard.Q;
		this.KeyMap["R"] = Keyboard.R;
		this.KeyMap["S"] = Keyboard.S;
		this.KeyMap["T"] = Keyboard.T;
		this.KeyMap["U"] = Keyboard.U;
		this.KeyMap["V"] = Keyboard.V;
		this.KeyMap["W"] = Keyboard.W;
		this.KeyMap["X"] = Keyboard.X;
		this.KeyMap["Y"] = Keyboard.Y;
		this.KeyMap["Z"] = Keyboard.Z;
		this.KeyMap["F1"] = Keyboard.F1;
		this.KeyMap["F2"] = Keyboard.F2;
		this.KeyMap["F3"] = Keyboard.F3;
		this.KeyMap["F4"] = Keyboard.F4;
		this.KeyMap["F5"] = Keyboard.F5;
		this.KeyMap["F6"] = Keyboard.F6;
		this.KeyMap["F7"] = Keyboard.F7;
		this.KeyMap["F8"] = Keyboard.F8;
		this.KeyMap["F9"] = Keyboard.F9;
		this.KeyMap["F10"] = Keyboard.F10;
		this.KeyMap["F11"] = Keyboard.F11;
		this.KeyMap["F12"] = Keyboard.F12;
		this.KeyMap["SPACE"] = Keyboard.SPACE;
	}
	private function write_settings() {
		var key:Object = new Object(); 
		key = { 
			"pencil" : "Q", 
			"line" : "W", 
			"eraser" : "E", 
			"swatch_blue" : "1", 
			"swatch_red" : "2", 
			"swatch_green" : "3", 
			"play" : "Y", 
			"stop" : "U", 
			"flag" : "I",
			"angle_snap" : "X", 
			"line_snap" : "S", 
			"ff_toggle" : "N", 
			"sm_toggle" : "M", 
			"rw_toggle" : "B", 
			"pp_toggle" : "SPACE", 
			"step_forward" : "RIGHT", 
			"step_backward" : "LEFT",  
		} 
		var file = File.write(System.documentsDirectory + "openLR/Binds.txt", true); 
		file.writeString(Json.stringify(key, null, "\t")); 
		file.close(); 
	} 
}