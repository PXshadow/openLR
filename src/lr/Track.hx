package lr;
import global.SimManager;
import lr.line.Grid;
import lr.line.LineBase;
import openfl.display.MovieClip;
import openfl.geom.Point;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Track movie clip with track specific functions and variables
 * 
 */
class Track extends MovieClip
{
	private var grid:Grid;
	private var simManager:SimManager;
	public var back_layer:MovieClip;
	public var rider_layer:MovieClip;
	public var front_layer:MovieClip;
	public function new() 
	{
		super();
		Common.gTrack = this;
		Common.track_scale = 1;
		this.back_layer = new MovieClip();
		this.rider_layer = new MovieClip();
		this.addChild(this.back_layer);
		this.addChild(this.rider_layer);
		this.grid = new Grid();
		this.simManager = new SimManager();
	}
	public function add_vis_line(line:LineBase) //This is the function that must be called when adding a line. Do not take shortcuts!
	{
		Common.gGrid.massLineIndex(line);
		this.back_layer.addChild(grid.lines[line.ID]);
		if (!Common.svar_sim_running) {
			if (!Common.cvar_preview_mode) {
				grid.lines[line.ID].render("edit");
			} else {
				grid.lines[line.ID].render("play");
			}
		} else {
			if (!Common.cvar_color_play) {
				grid.lines[line.ID].render("play");
			} else {
				grid.lines[line.ID].render("edit");
			}
		}
		//grid.lines[grid.lines.length - 1].render("play");
	}
	public function render_preview_line(_a:Point, _b:Point) 
	{
		var _locDis = Common.get_distance(_a, _b);
		var _locCol = 0xFF0000;
		if (_locDis > Common.line_minLength) {
			_locCol = 0x000000;
		}
		this.graphics.clear();
		this.graphics.lineStyle(2, _locCol, 1);
		this.graphics.moveTo(_a.x, _a.y);
		this.graphics.lineTo(_b.x, _b.y);
	}
	public function clear_preview()
	{
		this.graphics.clear();
	}
	public function set_rendermode_play() {
		for (a in 0...grid.lines.length) {
			if (grid.lines[a] != null)
			{
				if (!Common.cvar_color_play) {
					grid.lines[a].render("play");
				} else {
					grid.lines[a].render("edit");
				}
			}
		}
	}
	public function set_rendermode_edit() {
		for (a in 0...grid.lines.length) {
			if (grid.lines[a] != null) {
				if (!Common.cvar_preview_mode) {
					grid.lines[a].render("edit");
				} else {
					grid.lines[a].render("play");
				}
			}
		}
	}
	public function clear_stage()
	{
		for (i in 0...Common.gGrid.lines.length) {
			this.back_layer.removeChild(Common.gGrid.lines[i]);
		}
		Common.gGrid.new_grid();
		Common.gSimManager.reset();
		Common.gCode.reset_timeline();
		Common.sim_frames = 0;
		Common.sim_max_frames = 0;
		Common.sim_pause_frame = 0;
		Common.sim_rider_speed_top = 0;
		Common.sim_slow_motion_rate = 5;
		Common.sim_slow_motion = false;
	}
	public function remove_line(_line) {
		this.back_layer.removeChild(Common.gGrid.lines[_line.ID]);
	}
	public function set_simmode_play() {
		this.simManager.start_sim();
		Common.gToolBase.disable();
		Common.svar_sim_running = true;
	}
	public function set_simmode_resume() {
		
	}
	public function set_simmode_pause() {
		this.simManager.pause_sim();
	}
	public function set_simmode_stop() {
		this.simManager.end_sim();
		Common.gToolBase.enable();
		Common.svar_sim_running = false;
	}
	public function set_rider_start(_x:Float, _y:Float)
	{
		this.simManager.set_rider_start(_x, _y);
	}
}