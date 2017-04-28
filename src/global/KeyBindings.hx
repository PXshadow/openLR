package global;

import openfl.ui.Keyboard;

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
	public static var ff_toggle:Int = Keyboard.SPACE;
	public static var sm_toggle:Int = Keyboard.M;
	public static var rw_toggle:Int = Keyboard.CONTROL; //sim only
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
		KeyBindings.ff_toggle = Keyboard.SPACE;
		KeyBindings.sm_toggle = Keyboard.M;
		KeyBindings.undo_line = Keyboard.BACKSPACE;
		
		KeyBindings.undo_stroke = Keyboard.Z;
		KeyBindings.redo_stroke = Keyboard.Y;
		KeyBindings.redo_line = Keyboard.BACKSPACE;
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
	}
}