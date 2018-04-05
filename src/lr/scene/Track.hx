package lr.scene;

import lr.nodes.Grid;
import lr.nodes.Panel;
import lr.lines.LineBase;
import openfl.display.Sprite;
import openfl.geom.Point;

import global.engine.SimManager;
import global.Common;
import global.CVar;
import global.SVar;
import lr.nodes.SubPanel;

/**
 * ...
 * @author Kaelan Evans
 * 
 * Track movie clip with track specific functions and variables
 * 
 */
class Track extends Sprite
{
	private var grid:Grid;
	private var simManager:SimManager;
	public var canvas:Sprite;
	public var rider:Sprite;
	
	private var local_tl:Point;
	private var local_br:Point;
	public var tile_tl:Point;
	public var tile_br:Point;
	
	public var renderList:Array<Panel>;
	public var hitTestList:Array<LineBase>;
	
	public function new() 
	{
		super();
		Common.gTrack = this;
		Common.track_scale = 1;
		this.grid = new Grid();
		this.simManager = new SimManager();
		
		this.canvas = new Sprite();
		this.addChild(this.canvas);
		this.rider = new Sprite();
		this.addChild(this.rider);
		
		this.renderList = new Array();
		this.check_visibility();
	}
	
	public function check_visibility():Void 
	{
		var _locStageTL:Point = this.globalToLocal(Common.stage_tl);
		var _locStageBR:Point = this.globalToLocal(Common.stage_br);
		var _locTileTL = Common.tilePos(_locStageTL.x, _locStageTL.y);
		var _locTileBR = Common.tilePos(_locStageBR.x, _locStageBR.y);
		if (local_br == null || local_tl == null) {
			this.local_tl = _locStageTL;
			this.local_br = _locStageBR;
			this.tile_tl = new Point(_locTileTL.x, _locTileTL.y);
			this.tile_br = new Point(_locTileBR.x, _locTileBR.y);
		}
		if (_locStageBR.x != this.local_br.x || _locStageBR.y != this.local_br.y || this.local_tl.x != _locStageTL.x || this.local_tl.y != _locStageTL.y) {
			if (_locTileBR.x != this.tile_br.x || _locTileBR.y != this.tile_br.y || this.tile_tl.x != _locTileTL.x || this.tile_tl.y != _locTileTL.y) {
				this.local_tl = _locStageTL;
				this.local_br = _locStageBR;
				this.tile_tl.x = _locTileTL.x;
				this.tile_tl.y = _locTileTL.y;
				this.tile_br.x = _locTileBR.x;
				this.tile_br.y = _locTileBR.y;
				this.update_visibility();
			}
		} else {
			return;
		}
	}
	
	function update_visibility() 
	{
		#if (flash)
			return;
		#end
		for (a in this.renderList) {
			if (a.panelPosX < this.tile_tl.x) {
				Common.gTrack.canvas.removeChild(a.frame);
				a.onStage = false;
				this.renderList.remove(a);
			} else if (a.panelPosX > this.tile_br.x) {
				Common.gTrack.canvas.removeChild(a.frame);
				a.onStage = false;
				this.renderList.remove(a);
			} else if (a.panelPosY < this.tile_tl.y) {
				Common.gTrack.canvas.removeChild(a.frame);
				a.onStage = false;
				this.renderList.remove(a);
			} else if (a.panelPosY > this.tile_br.y) {
				Common.gTrack.canvas.removeChild(a.frame);
				a.onStage = false;
				this.renderList.remove(a);
			}
		}
		var _loc1:Int = Std.int(this.tile_tl.x -1);
		var _loc2:Int = Std.int(this.tile_br.x + 1);
		var _loc3:Int = Std.int(this.tile_tl.y -1);
		var _loc4:Int = Std.int(this.tile_br.y + 1);
		for (b in _loc1..._loc2) {
			if (Grid.tile[b] == null) {
					continue;
				}
			for (c in _loc3..._loc4) {
				if (Grid.tile[b][c] == null) {
					continue;
				}
				if (Grid.tile[b][c].onStage == true) {
					continue;
				} else {
					this.renderList.push(Grid.tile[b][c]);
					Grid.tile[b][c].onStage = true;
					Common.gTrack.canvas.addChild(Grid.tile[b][c].frame);
				}
			}
		}
	}
	public function decachePanels() {
		for (a in renderList) {
			a.frame.cacheAsBitmap = false;
		}
	}
	public function cachePanels() {
		for (a in renderList) {
			a.frame.cacheAsBitmap = true;
		}
	}
	public function renderPreview(_line:LineBase)
	{
		this.graphics.clear();
		if (!CVar.preview_mode) {
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
		this.hitTestList = new Array<LineBase>();
		if (!CVar.color_play) {
			Common.gGrid.updateRender("Play");
		} else {
			Common.gGrid.updateRender("Edit");
		}
	}
	public function set_rendermode_edit() {
		if (CVar.preview_mode) {
			Common.gGrid.updateRender("Play");
		} else {
			Common.gGrid.updateRender("Edit");
		}
		SubPanel.derender_litlines();
	}
	public function clear_stage()
	{
		for (a in Common.gGrid.lines) {
			if (a == null) {
				continue;
			}
			Common.gGrid.remove_line(a);
		}
		Common.gGrid.new_grid();
		Common.gSimManager.reset();
		Common.gCode.reset_timeline();
		SVar.frames = 0;
		SVar.max_frames = 0;
		SVar.pause_frame = 0;
		SVar.rider_speed_top = 0;
		CVar.slow_motion_rate = 5;
		SVar.slow_motion = false;
	}
	public function set_simmode_play(_fromStart:Bool = false) {
		this.simManager.start_sim(_fromStart);
		SVar.sim_running = true;
	}
	public function set_simmode_resume() {
		
	}
	public function set_simmode_pause() {
		this.simManager.pause_sim();
	}
	public function set_simmode_stop() {
		this.simManager.end_sim();
		SVar.sim_running = false;
	}
}