package lr.rider;

import haxe.ds.Vector;
import lr.line.LineBase;
import lr.rider.phys.*;
import openfl.display.MovieClip;
import openfl.utils.Object;
import global.Common;
import lr.line.Grid;

/**
 * ...
 * @author ...
 */
class RiderBase 
{
	public var anchors:Vector<CPoint>;
	public var edges:Vector<Stick>;
	public var startFrame:Vector<CPoint>;
	public var saveFrame:Vector<CPoint>;
	public var g:Object;
	public var bosh:MovieClip;
	public function new() 
	{
		g = new Object();
		g.x = 0;
		g.y = 0.175;
		
		this.bosh = new MovieClip();
		Common.gTrack.addChild(this.bosh);
	}
	public function init_rider() 
	{
		Stick.crash = false;
		
		this.anchors = new Vector(10);
		
		this.anchors[0] = new CPoint(0, 0, 0.8, 0); //2nd Peg
		this.anchors[1] = new CPoint(0, 10, 0, 1); //Upper Nose
		this.anchors[2] = new CPoint(30, 10, 0, 2); //Lower Nose
		this.anchors[3] = new CPoint(35, 0, 0, 3); //1st peg
		this.anchors[4] = new CPoint(10, 0, 0.8, 4); //Butt
		this.anchors[5] = new CPoint(10, -11, 0.8, 5); //Shoulder
		this.anchors[6] = new CPoint(23, -10, 0.1, 6); //hand
		this.anchors[7] = new CPoint(23, -10, 0.1, 7); //hand
		this.anchors[8] = new CPoint(20, 10, 0, 8); //Foot
		this.anchors[9] = new CPoint(20, 10, 0, 9); //Foot
		
		for (a in 0...anchors.length) {
			anchors[a].x *= 0.5;
			anchors[a].y *= 0.5;
		}
		
		this.edges = new Vector(22);
		
		this.edges[0] = new Stick(anchors[0], anchors[1]);// Sled
		this.edges[1] = new Stick(anchors[1], anchors[2]);//
		this.edges[2] = new Stick(anchors[2], anchors[3]);//
		this.edges[3] = new Stick(anchors[3], anchors[0]);//
		this.edges[4] = new Stick(anchors[0], anchors[2]);//
		this.edges[5] = new Stick(anchors[3], anchors[1]);//
		
		this.edges[6] = new BindStick(anchors[0], anchors[4]);// Sled to butt
		this.edges[7] = new BindStick(anchors[0], anchors[4]);//
		this.edges[8] = new BindStick(anchors[0], anchors[4]);//
		
		this.edges[9] = new Stick(anchors[5], anchors[4]); // Body
		this.edges[10] = new Stick(anchors[5], anchors[6]);//
		this.edges[11] = new Stick(anchors[5], anchors[7]);//
		this.edges[12] = new Stick(anchors[4], anchors[8]);//
		this.edges[13] = new Stick(anchors[4], anchors[9]);//
		this.edges[14] = new Stick(anchors[5], anchors[7]);//Duplicate of edge 11. Necesary for any compatibility with other builds
		
		this.edges[15] = new BindStick(anchors[5], anchors[0]);// other bounds
		this.edges[16] = new BindStick(anchors[3], anchors[6]);//
		this.edges[17] = new BindStick(anchors[3], anchors[7]);//
		this.edges[18] = new BindStick(anchors[8], anchors[2]);//
		this.edges[19] = new BindStick(anchors[9], anchors[2]);//
		
		this.edges[20] = new RepellStick(anchors[5], anchors[8]);// Keeps shoulder from getting too close to feet
		this.edges[21] = new RepellStick(anchors[5], anchors[9]);//
		
		for (i in 0...anchors.length) { //this shift is necesarry as it heeps the rider from flying the second the sim starts. 
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
	}
	public function step_rider() {
		for (i in 0...anchors.length) {
			anchors[i].verlet(this.g);
		}
		for (a in 0...6) {
			for (b in 0...edges.length) {
				if (edges[b].constrain()) {}
			}
			this.collision();
		}
		this.render_bones();
	}
	public function collision() 
	{
		for (_loc7 in 0...anchors.length)
		{
			var _loc5 = anchors[_loc7];
			var _loc6 = Common.gridPos(_loc5.x, _loc5.y);
			for (_loc4 in -1...2)
			{
				var _loc1 = (_loc6.x + _loc4);
				if (Grid.grid[_loc1] == null)
				{
					continue;
				} // end if
				for (_loc3 in -1...2)
				{
					var _loc2 = (_loc6.y + _loc3);
					if (Grid.grid[_loc1][_loc2] == null)
					{
						continue;
					} // end if
					var tempStorage:Array<LineBase>;
					tempStorage = new Array();
					for (_loc8 in 0...Grid.grid[_loc1][_loc2].storage2.length)
					{
						if (Grid.grid[_loc1][_loc2].storage2[_loc8] != null)
						{
							tempStorage.push(Grid.grid[_loc1][_loc2].storage2[_loc8]);
						} else {
							continue;
						}
					} // end of for...in
					if (tempStorage.length == 0) {
						continue;
					} else {
						for (i in 0...tempStorage.length) {
							tempStorage[i].collide(_loc5);
						}
					}
				} // end of for
			} // end of for
		} // end of for
	}
	public function save_rider() {
		this.saveFrame = new Vector(10);
		this.saveFrame = this.anchors;
	}
	public function render_bones() {
		this.bosh.graphics.clear();
		this.bosh.graphics.lineStyle(2, 0xFF0000, 1);
		for (i in 0...anchors.length) {
			this.bosh.graphics.drawCircle(anchors[i].x, anchors[i].y, 1);
		}
		this.bosh.graphics.lineStyle(1, 0x0000FF, 1);
		for (b in 0...edges.length) {
			this.bosh.graphics.moveTo(edges[b].a.x, edges[b].a.y);
			this.bosh.graphics.lineTo(edges[b].b.x, edges[b].b.y);
		}
	}
}