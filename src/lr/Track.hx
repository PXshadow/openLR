package lr;
import lr.line.Grid;
import lr.line.LineBase;
import openfl.display.MovieClip;
import openfl.geom.Point;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class Track extends MovieClip
{
	private var grid:Grid;
	public function new() 
	{
		super();
		Common.gTrack = this;
		Common.track_scale = 1;
		this.grid = new Grid();
	}
	public function add_vis_line(line:Dynamic) {
		Common.gGrid.massLineIndex(line);
		Common.gTrack.addChild(grid.lines[grid.lines.length - 1]);
		grid.lines[grid.lines.length - 1].render("edit");
	}
	public function render_preview_line(_a:Point, _b:Point) {
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
	public function update_render()
	{
		var con = Common.cvar_line_render_mode;
		if (con == 0) {
			for (a in 0...grid.lines.length) {
				grid.lines[a].render("play");
			}
			Common.cvar_line_render_mode = 1;
		} else if (con == 1) {
			for (b in 0...grid.lines.length) {
				grid.lines[b].render("edit");
			}
			Common.cvar_line_render_mode = 0;
		}
	}
}