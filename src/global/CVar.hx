package global;

import openfl.net.SharedObject;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Client Variables. Variables that are controlled by player input in some form.
 */
class CVar 
{
	public static var local = { //Settings that are specific to the player. Saves to appdata
		auto_save : true,
		auto_save_freq : 10,
		angle_snap : false,
		angle_snap_value : 15.0,
		angle_snap_offset : 0.0,
		
		dictionary : "English",
		
		line_snap : true,
		
		scroll_cursor : true,
	};
	public static var track = { //settings that are specific to the track. Saves to track
		force_zoom : false,
		force_zoom_ammount : 2.0,
		
		author : "Made by: Anonymous",
		name: "Untitled",
	};
	public static var volatile = { //settings that are specific to the session. Does not save
		color_play : false,
		contact_points : false,
		
		flagged : false,
		
		hit_test : false,
		hit_test_live : false,
		
		paused : false,
		preview_mode : false,
		
		slow_motion_auto : false,
		slow_motion_rate : 5,
	};
	
	public static var paused:Bool = false;

	public static var mod_shift:Bool = false;
	public static var mod_ctrl:Bool = false;
	public static var mod_alt:Bool = false;
	public static var mod_x:Bool = false;
	public static var mod_z:Bool = false;
	
	public function new() 
	{
		
	}
	public static function flushLocal() {
		var sol:SharedObject = SharedObject.getLocal("OLR_Local", "/olr/");
		sol.data.local = CVar.local;
		sol.flush();
	}
	public static function loadLocal() {
		var sol:SharedObject = SharedObject.getLocal("OLR_Local", "/olr/");
		if (sol.data.local == null) return;
		CVar.local = sol.data.local;
	}
}