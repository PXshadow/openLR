package global;

import openfl.utils.Object;
import openfl.ui.Keyboard;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

/**
 * ...
 * @author Kaelan Evans
 */
class KeyBindings 
{
	public static var KeyStringList:Array<String>;
	
	//single strokes
	public static var pencil_1:Int = Keyboard.Q;
	public static var pencil_2:Int = Keyboard.F3;
	public static var line_1:Int = Keyboard.W;
	public static var line_2:Int = Keyboard.F2;
	public static var eraser_1:Int = Keyboard.E;
	public static var eraser_2:Int = Keyboard.F3;
	public static var pan_1:Int = Keyboard.R;
	public static var pan_2:Int = Keyboard.F4;
	public static var swatch_blue:Int = Keyboard.NUMBER_1;
	public static var swatch_red:Int = Keyboard.NUMBER_2;
	public static var swatch_green:Int = Keyboard.NUMBER_3;
	public static var icon_play:Int = Keyboard.Y;
	public static var icon_stop:Int = Keyboard.U;
	public static var icon_flag:Int = Keyboard.I;
	public static var mod_action_shift:Int = Keyboard.SHIFT;
	public static var mod_action_control:Int = Keyboard.CONTROL;
	public static var angle_snap:Int = Keyboard.X; //Includes lock toggle
	public static var line_snap:Int = Keyboard.S; //Includes lock toggle
	public static var ff_toggle:Int = Keyboard.N;
	public static var sm_toggle:Int = Keyboard.M;
	public static var rw_toggle:Int = Keyboard.B; //sim only
	public static var pp_toggle:Int = Keyboard.SPACE;
	public static var step_forward:Int = Keyboard.RIGHT;
	public static var step_backward:Int = Keyboard.LEFT;
	public static var undo_line:Int = Keyboard.BACKSPACE;
	
	//combo strokes
	public static var undo_stroke:Int = Keyboard.Z; //control
	public static var redo_stroke:Int = Keyboard.Y; //control
	public static var redo_line:Int = Keyboard.BACKSPACE; //shift
	
	public function new() 
	{
		KeyBindings.KeyStringList = new Array();
		this.setArrayBinds();
	}
	public static function reset() {
		KeyBindings.pencil_1 = Keyboard.Q;
		KeyBindings.pencil_2 = Keyboard.F3;
		KeyBindings.line_1 = Keyboard.W;
		KeyBindings.line_2 = Keyboard.F2;
		KeyBindings.eraser_1 = Keyboard.E;
		KeyBindings.eraser_2 = Keyboard.F3;
		KeyBindings.pan_1 = Keyboard.R;
		KeyBindings.pan_2 = Keyboard.F4;
		KeyBindings.swatch_blue = Keyboard.NUMBER_1;
		KeyBindings.swatch_red = Keyboard.NUMBER_2;
		KeyBindings.swatch_green = Keyboard.NUMBER_3;
		KeyBindings.icon_play = Keyboard.Y;
		KeyBindings.icon_stop = Keyboard.U;
		KeyBindings.icon_flag = Keyboard.I;
		KeyBindings.mod_action_shift = Keyboard.SHIFT;
		KeyBindings.mod_action_control = Keyboard.CONTROL;
		KeyBindings.angle_snap = Keyboard.X;
		KeyBindings.line_snap = Keyboard.S;
		KeyBindings.ff_toggle = Keyboard.N;
		KeyBindings.sm_toggle = Keyboard.M;
		KeyBindings.rw_toggle = Keyboard.B;
		KeyBindings.pp_toggle = Keyboard.SPACE;
		KeyBindings.step_forward = Keyboard.RIGHT;
		KeyBindings.step_backward = Keyboard.LEFT;
		KeyBindings.undo_line = Keyboard.BACKSPACE;
		
		KeyBindings.undo_stroke = Keyboard.Z;
		KeyBindings.redo_stroke = Keyboard.Y;
		KeyBindings.redo_line = Keyboard.BACKSPACE;
	}
	static public function set_bindings(object) 
	{
		KeyBindings.pencil_1 = object.binds.pencil_1;
		KeyBindings.pencil_2 = object.binds.pencil_2;
		KeyBindings.line_1 = object.binds.line_1;
		KeyBindings.line_2 = object.binds.line_2;
		KeyBindings.eraser_1 = object.binds.eraser_1;
		KeyBindings.eraser_2 = object.binds.eraser_2;
		KeyBindings.pan_1 = object.binds.pan_1;
		KeyBindings.pan_2 = object.binds.pan_2;
		KeyBindings.swatch_blue = object.binds.swatch_blue;
		KeyBindings.swatch_red = object.binds.swatch_red;
		KeyBindings.swatch_green = object.binds.swatch_green;
		KeyBindings.icon_play = object.binds.icon_play;
		KeyBindings.icon_stop = object.binds.icon_stop;
		KeyBindings.icon_flag = object.binds.icon_flag;
		KeyBindings.mod_action_shift = object.binds.mod_action_shift;
		KeyBindings.mod_action_control = object.binds.mod_action_control;
		KeyBindings.angle_snap = object.binds.angle_snap;
		KeyBindings.line_snap = object.binds.line_snap;
		KeyBindings.ff_toggle = object.binds.ff_toggle;
		KeyBindings.sm_toggle = object.binds.sm_toggle;
		KeyBindings.rw_toggle = object.binds.rw_toggle;
		KeyBindings.pp_toggle = object.binds.pp_toggle;
		KeyBindings.step_forward = object.binds.step_forward;
		KeyBindings.step_backward = object.binds.step_backward;
		KeyBindings.undo_line = object.binds.undo_line;
		
		KeyBindings.write_settings(); //this is needed, should prevent users having to rebind everything whenever a new key is introduced
	}
	static public function write_settings() {
		var key:Object = new Object(); 
		key = { 
		"binds" : { 
			"pencil_1" : KeyBindings.pencil_1, 
			"pencil_2" : KeyBindings.pencil_2, 
			"line_1" : KeyBindings.line_1, 
			"line_2" : KeyBindings.line_2, 
			"eraser_1" : KeyBindings.eraser_1, 
			"eraser_2" : KeyBindings.eraser_2, 
			"pan_1" : KeyBindings.pan_1, 
			"pan_2" : KeyBindings.pan_2, 
			"swatch_blue" : KeyBindings.swatch_blue, 
			"swatch_red" : KeyBindings.swatch_red, 
			"swatch_green" : KeyBindings.swatch_green, 
			"icon_play" : KeyBindings.icon_play, 
			"icon_stop" : KeyBindings.icon_stop, 
			"icon_flag" : KeyBindings.icon_flag, 
			"mod_action_shift" : KeyBindings.mod_action_shift, 
			"mod_action_control" : KeyBindings.mod_action_control, 
			"angle_snap" : KeyBindings.angle_snap, 
			"line_snap" : KeyBindings.line_snap, 
			"ff_toggle" : KeyBindings.ff_toggle, 
			"sm_toggle" : KeyBindings.sm_toggle, 
			"rw_toggle" : KeyBindings.rw_toggle, 
			"pp_toggle" : KeyBindings.pp_toggle, 
			"step_forward" : KeyBindings.step_forward, 
			"step_backward" : KeyBindings.step_backward, 
			"undo_line" : KeyBindings.undo_line, 
			"undo_stroke" : KeyBindings.undo_stroke, 
			"redo_stroke" : KeyBindings.redo_stroke, 
			"redo_line" : KeyBindings.redo_line 
			}, 
			"reference" : "http://api.openfl.org/openfl/ui/Keyboard.html" 
		} 
		var file = File.write("./settings/KeyBindings.json", true); 
		file.writeString(Json.stringify(key, null, "\t")); 
		file.close(); 
	} 
	private function setArrayBinds() 
	{
		KeyBindings.KeyStringList[Keyboard.NUMBER_0] = "0";
		KeyBindings.KeyStringList[Keyboard.NUMBER_1] = "1";
		KeyBindings.KeyStringList[Keyboard.NUMBER_2] = "2";
		KeyBindings.KeyStringList[Keyboard.NUMBER_3] = "3";
		KeyBindings.KeyStringList[Keyboard.NUMBER_4] = "4";
		KeyBindings.KeyStringList[Keyboard.NUMBER_5] = "5";
		KeyBindings.KeyStringList[Keyboard.NUMBER_6] = "6";
		KeyBindings.KeyStringList[Keyboard.NUMBER_7] = "7";
		KeyBindings.KeyStringList[Keyboard.NUMBER_8] = "8";
		KeyBindings.KeyStringList[Keyboard.NUMBER_9] = "9";
		KeyBindings.KeyStringList[Keyboard.A] = "A";
		KeyBindings.KeyStringList[Keyboard.B] = "B";
		KeyBindings.KeyStringList[Keyboard.C] = "C";
		KeyBindings.KeyStringList[Keyboard.D] = "D";
		KeyBindings.KeyStringList[Keyboard.E] = "E";
		KeyBindings.KeyStringList[Keyboard.F] = "F";
		KeyBindings.KeyStringList[Keyboard.G] = "G";
		KeyBindings.KeyStringList[Keyboard.H] = "H";
		KeyBindings.KeyStringList[Keyboard.I] = "I";
		KeyBindings.KeyStringList[Keyboard.J] = "J";
		KeyBindings.KeyStringList[Keyboard.K] = "K";
		KeyBindings.KeyStringList[Keyboard.L] = "L";
		KeyBindings.KeyStringList[Keyboard.M] = "M";
		KeyBindings.KeyStringList[Keyboard.N] = "N";
		KeyBindings.KeyStringList[Keyboard.O] = "O";
		KeyBindings.KeyStringList[Keyboard.P] = "P";
		KeyBindings.KeyStringList[Keyboard.Q] = "Q";
		KeyBindings.KeyStringList[Keyboard.R] = "R";
		KeyBindings.KeyStringList[Keyboard.S] = "S";
		KeyBindings.KeyStringList[Keyboard.T] = "T";
		KeyBindings.KeyStringList[Keyboard.U] = "U";
		KeyBindings.KeyStringList[Keyboard.V] = "V";
		KeyBindings.KeyStringList[Keyboard.W] = "W";
		KeyBindings.KeyStringList[Keyboard.X] = "X";
		KeyBindings.KeyStringList[Keyboard.Y] = "Y";
		KeyBindings.KeyStringList[Keyboard.Z] = "Z";
		KeyBindings.KeyStringList[Keyboard.F1] = "F1";
		KeyBindings.KeyStringList[Keyboard.F2] = "F2";
		KeyBindings.KeyStringList[Keyboard.F3] = "F3";
		KeyBindings.KeyStringList[Keyboard.F4] = "F4";
		KeyBindings.KeyStringList[Keyboard.F5] = "F5";
		KeyBindings.KeyStringList[Keyboard.F6] = "F6";
		KeyBindings.KeyStringList[Keyboard.F7] = "F7";
		KeyBindings.KeyStringList[Keyboard.F8] = "F8";
		KeyBindings.KeyStringList[Keyboard.F9] = "F9";
		KeyBindings.KeyStringList[Keyboard.F10] = "F10";
		KeyBindings.KeyStringList[Keyboard.F11] = "F11";
		KeyBindings.KeyStringList[Keyboard.F12] = "F12";
		KeyBindings.KeyStringList[Keyboard.BACKSPACE] = "Backspace";
		KeyBindings.KeyStringList[Keyboard.TAB] = "Tab";
		KeyBindings.KeyStringList[Keyboard.ALTERNATE] = "Alt";
		KeyBindings.KeyStringList[Keyboard.ENTER] = "Enter/Return";
		KeyBindings.KeyStringList[Keyboard.SHIFT] = "Shift"; //Might not want to have shift and control rebindable for everything that uses it
		KeyBindings.KeyStringList[Keyboard.CONTROL] = "Ctrl";
		KeyBindings.KeyStringList[Keyboard.SPACE] = "Space";
		KeyBindings.KeyStringList[Keyboard.LEFT] = "Left";
		KeyBindings.KeyStringList[Keyboard.RIGHT] = "Right";
	}
}