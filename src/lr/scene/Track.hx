package lr.scene;

import lr.nodes.B2Grid;
import lr.lines.LineBase;
import openfl.display.Sprite;
import openfl.geom.Point;

import global.SimManager;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Track movie clip with track specific functions and variables
 * 
 */
class Track extends Sprite
{
	private var grid:B2Grid;
	private var simManager:SimManager;
	public function new() 
	{
		super();
		Common.gTrack = this;
		Common.track_scale = 1;
		this.grid = new B2Grid();
		this.simManager = new SimManager();
	}
	public function add_vis_line(line:LineBase) //This is the function that must be called when adding a line. Do not take shortcuts!
	{
		Common.gGrid.massLineIndex(line);
		this.addChild(grid.lines[line.ID]);
		if (Common.svar_sim_running) {
			return;
		}
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
	}
	public function renderPreview(_line:LineBase)
	{
		this.graphics.clear();
		if (!Common.cvar_preview_mode) {
			var _loc_3:Float = _line.nx > 0 ? (Math.ceil(_line.nx)) : (Math.floor(_line.nx));
			var _loc_4:Float = _line.ny > 0 ? (Math.ceil(_line.ny)) : (Math.floor(_line.ny));
			switch(_line.type) {
				case LineType.Floor: 
					this.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round");
					this.graphics.moveTo(_line.x1 + _loc_3, _line.y1 + _loc_4);
					this.graphics.lineTo(_line.x2 + _loc_3, _line.y2 + _loc_4);
				case LineType.Accel: 
					this.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round");
					this.graphics.beginFill(0xCC0000, 1);
					this.graphics.moveTo(_line.x1 + _loc_3, _line.y1 + _loc_4);
					this.graphics.lineTo(_line.x2 + _loc_3, _line.y2 + _loc_4);
					this.graphics.lineTo(_line.x2 + (_line.nx * 5 - _line.dx * _line.invDst * 5), _line.y2 + (_line.ny * 5 - _line.dy * _line.invDst * 5));
					this.graphics.lineTo(_line.x2 - _line.dx * _line.invDst * 5, _line.y2 - _line.dy * _line.invDst * 5);
					this.graphics.endFill();
				case LineType.Scene: 
					this.graphics.lineStyle(2, 0x00CC00, 1);
					this.graphics.moveTo(_line.x1, _line.y1);
					this.graphics.lineTo(_line.x2, _line.y2);
					return;
			}
		}
		this.graphics.lineStyle(2, 0x000000, 1);
		this.graphics.moveTo(_line.x1, _line.y1);
		this.graphics.lineTo(_line.x2, _line.y2);
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
				grid.lines[a].visible = true;
			}
		}
	}
	public function clear_stage()
	{
		for (i in 0...Common.gGrid.lines.length) {
			this.removeChild(Common.gGrid.lines[i]);
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
		this.removeChild(Common.gGrid.lines[_line.ID]);
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
}