package lr.rider;

import cpp.net.Poll;
import haxe.ds.Vector;
import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.utils.Object;
import openfl.Assets.AssetLibrary;
import openfl.events.IOErrorEvent;

import global.Common;
import lr.line.Grid;
import lr.line.LineBase;
import lr.rider.phys.*;

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
	public var recorded_frames:Array<Array<Array<Dynamic>>>;
	
	private var body:MovieClip;
	private var leftArm:MovieClip;
	private var rightArm:MovieClip;
	private var leftLeg:MovieClip;
	private var rightLeg:MovieClip;
	private var sled:MovieClip;
	
	private var camera:RiderCamera;
	
	public var flag:FlagMarker;
	public var Start:StartPointVis;
	
	private var crashed:Bool = false;
	
	public function new() 
	{
		g = new Object();
		g.x = 0;
		g.y = 0.175;
		
		this.bosh = new MovieClip();
		Common.gTrack.rider_layer.addChild(this.bosh);
		
		this.getAssets();
		this.camera = new RiderCamera();
		this.Start = new StartPointVis();
		Common.gTrack.back_layer.addChild(this.Start);
		
		this.recorded_frames = new Array();
		this.init_rider();
	}
	private function getAssets() {
		var swfLibSled = AssetLibrary.loadFromFile("swf/sled.bundle");
		swfLibSled.onComplete(sledClip);
		
		var swfLibBody = AssetLibrary.loadFromFile("swf/body.bundle");
		swfLibBody.onComplete(bodyClip);
		
		var swfLibLeg = AssetLibrary.loadFromFile("swf/leg.bundle");
		swfLibLeg.onComplete(legClip);
		
		var swfLibArm = AssetLibrary.loadFromFile("swf/arm.bundle");
		swfLibArm.onComplete(armClip);
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
		this.edges[7] = new BindStick(anchors[1], anchors[4]);//
		this.edges[8] = new BindStick(anchors[2], anchors[4]);//
		
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
		
		this.edges[20].rest *= 0.5;
		this.edges[21].rest *= 0.5;
		
		for (i in 0...anchors.length) { //this shift is necesarry as it keeps the rider from flying the second the sim starts. 
			anchors[i].x = anchors[i].x + Common.track_start_x;
			anchors[i].y = anchors[i].y + Common.track_start_y;
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
	}
	public function moveToStart(_x:Float, _y:Float) {
		this.init_rider();
		for (i in 0...anchors.length) {
			anchors[i].x = anchors[i].x + _x;
			anchors[i].y = anchors[i].y + _y;
			anchors[i].vx = anchors[i].x - 0.4;
			anchors[i].vy = anchors[i].y;
		}
		this.Start.x = _x;
		this.Start.y = _y;
		this.render_body();
		this.record_frame();
	}
	public function reset() //this reset is necesary so it doesn't break the saved flag location, otherwise we get a NaN rider.
	{
		this.anchors[0].x = 0;
		this.anchors[0].y = 0;
		this.anchors[1].x = 0;
		this.anchors[1].y = 10;
		this.anchors[2].x = 30;
		this.anchors[2].y = 10;
		this.anchors[3].x = 35;
		this.anchors[3].y = 0;
		this.anchors[4].x = 10;
		this.anchors[4].y = 0;
		this.anchors[5].x = 10;
		this.anchors[5].y = -11;
		this.anchors[6].x = 23;
		this.anchors[6].y = -10;
		this.anchors[7].x = 23;
		this.anchors[7].y = -10;
		this.anchors[8].x = 20;
		this.anchors[8].y = 10;
		this.anchors[9].x = 20;
		this.anchors[9].y = 10;
		
		
		for (i in anchors) {
			i.x *= 0.5;
			i.y *= 0.5;
			i.x += Common.track_start_x;
			i.y += Common.track_start_y;
			i.vx = i.x - 0.4;
			i.vy = i.y;
		}
		
		Stick.crash = false;
	}
	public function step_rider() { //This is called every time the timer goes off in SimManaher.hx
		for (i in 0...anchors.length) {
			anchors[i].verlet(this.g); //Apply speed and gravity to the rider
		}
		for (a in 0...6) {
			for (b in 0...edges.length) {
				if (edges[b].constrain()) {} //Adjust all of the riders bones (edges)
			}
			this.collision(); //check for line collision
		}
		var _loc4:Float = anchors[3].x - anchors[0].x;
		var _loc5:Float = anchors[3].y - anchors[0].y;
		if (_loc4 * (anchors[1].y - anchors[0].y) - _loc5 * (anchors[1].x - anchors[0].x) < 0)
		{
			Stick.crash = true; //Tail fakie counter measure. "Bug" that existed in Beta 1 that was was patched in Rev 5 (presumably);
		}
		Common.sim_rider_speed = Math.floor((Math.sqrt(Math.pow(anchors[5].dx - g.x, 2)) + Math.sqrt(Math.pow(anchors[5].dy - g.y, 2))) * 100) / 100;
		if (Common.sim_rider_speed > Common.sim_rider_speed_top) {
			Common.sim_rider_speed_top = Common.sim_rider_speed;
		}
		this.render_body();
		this.camera.pan(anchors[4]);
		this.record_frame();
	}
	
	function record_frame() 
	{
		this.recorded_frames[Common.sim_frames] = new Array();
		for (i in 0...anchors.length) {
			this.recorded_frames[Common.sim_frames][i] = new Array();
			this.recorded_frames[Common.sim_frames][i][0] = anchors[i].x;
			this.recorded_frames[Common.sim_frames][i][1] = anchors[i].y;
			this.recorded_frames[Common.sim_frames][i][2] = anchors[i].vx;
			this.recorded_frames[Common.sim_frames][i][3] = anchors[i].vy;
			this.recorded_frames[Common.sim_frames][i][4] = anchors[i].dx;
			this.recorded_frames[Common.sim_frames][i][5] = anchors[i].dy;
			this.recorded_frames[Common.sim_frames][i][6] = Stick.crash;
		}
	}
	public function inject_frame(_frame) {
		try {
			for (i in 0...anchors.length) {
				anchors[i].x = this.recorded_frames[_frame][i][0];
				anchors[i].y = this.recorded_frames[_frame][i][1];
				anchors[i].vx = this.recorded_frames[_frame][i][2];
				anchors[i].vy = this.recorded_frames[_frame][i][3];
				anchors[i].dx = this.recorded_frames[_frame][i][4];
				anchors[i].dy = this.recorded_frames[_frame][i][5];
				Stick.crash = this.recorded_frames[_frame][i][6];
			}
		} catch(e:String) {
			return;
		}
		Common.sim_frames = _frame;
		this.render_body();
		this.camera.pan(anchors[4]);
	}
	public function inject_frame_and_iterate(_frame, _iter) {
		try {
			for (i in 0...anchors.length) {
				anchors[i].x = this.recorded_frames[_frame][i][0];
				anchors[i].y = this.recorded_frames[_frame][i][1];
				anchors[i].vx = this.recorded_frames[_frame][i][2];
				anchors[i].vy = this.recorded_frames[_frame][i][3];
				anchors[i].dx = this.recorded_frames[_frame][i][4];
				anchors[i].dy = this.recorded_frames[_frame][i][5];
				Stick.crash = this.recorded_frames[_frame][i][6];
			}
		} catch(e:String) {
			return;
		}
		for (a in 0..._iter) {
			this.step_forward();
		}
		this.render_body();
	}
	public function step_back()
	{
		if (Common.sim_frames > 0) {
			Common.sim_frames -= 1;
			for (i in 0...anchors.length) {
				anchors[i].x = this.recorded_frames[Common.sim_frames][i][0];
				anchors[i].y = this.recorded_frames[Common.sim_frames][i][1];
				anchors[i].vx = this.recorded_frames[Common.sim_frames][i][2];
				anchors[i].vy = this.recorded_frames[Common.sim_frames][i][3];
				anchors[i].dx = this.recorded_frames[Common.sim_frames][i][4];
				anchors[i].dy = this.recorded_frames[Common.sim_frames][i][5];
				Stick.crash = this.recorded_frames[Common.sim_frames][i][6];
			}
		}
		this.render_body();
		this.camera.pan(anchors[4]);
	}
	public function step_forward() {
		this.step_rider();
	}
	public function render_body()
	{
		this.body.x = this.anchors[4].x;
		this.body.y = this.anchors[4].y;
		this.body.rotation = Common.get_angle_degrees(new Point(anchors[4].x, anchors[4].y), new Point(anchors[5].x, anchors[5].y));
		
		this.sled.x = anchors[0].x;
		this.sled.y = anchors[0].y;
		this.sled.rotation = Common.get_angle_degrees(new Point(anchors[0].x, anchors[0].y), new Point(anchors[3].x, anchors[3].y));
		
		this.leftArm.x = this.rightArm.x = anchors[5].x;
		this.leftArm.y = this.rightArm.y = anchors[5].y;
		this.leftArm.rotation = Common.get_angle_degrees(new Point(anchors[5].x, anchors[5].y), new Point(anchors[6].x, anchors[6].y));
		this.rightArm.rotation = Common.get_angle_degrees(new Point(anchors[5].x, anchors[5].y), new Point(anchors[7].x, anchors[7].y));
		
		this.leftLeg.x = this.rightLeg.x = this.anchors[4].x;
		this.leftLeg.y = this.rightLeg.y = this.anchors[4].y;
		this.leftLeg.rotation = Common.get_angle_degrees(new Point(anchors[4].x, anchors[4].y), new Point(anchors[8].x, anchors[8].y));
		this.rightLeg.rotation = Common.get_angle_degrees(new Point(anchors[4].x, anchors[4].y), new Point(anchors[9].x, anchors[9].y));
		
		this.bosh.graphics.clear();
		if (!Stick.crash) {
			this.bosh.graphics.lineStyle(0.5, 0, 1);
			this.bosh.graphics.moveTo(anchors[6].x, anchors[6].y);
			this.bosh.graphics.lineTo(anchors[3].x, anchors[3].y);
			this.bosh.graphics.lineTo(anchors[7].x, anchors[7].y);
		}
		if (Common.cvar_contact_points) {
			this.body.alpha = this.sled.alpha = this.leftArm.alpha = this.rightArm.alpha = this.leftLeg.alpha = this.rightLeg.alpha = 0.25;
			this.render_bones();
		} else {
			this.body.alpha = this.sled.alpha = this.leftArm.alpha = this.rightArm.alpha = this.leftLeg.alpha = this.rightLeg.alpha = 1;
		}
		
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
					var tempList:Array<LineBase> = Grid.grid[_loc1][_loc2].storage2;
					for (_loc8 in tempList)
					{
						_loc8.collide(_loc5);
					} // end of for...in
				} // end of for
			} // end of for
		} // end of for
	}
	public function render_bones() {
		this.bosh.graphics.clear();
		this.bosh.graphics.lineStyle(0.25, 0xFF0000, 1);
		for (i in 0...anchors.length) {
			this.bosh.graphics.drawCircle(anchors[i].x, anchors[i].y, 1);
		}
		this.bosh.graphics.lineStyle(0.25, 0x0000FF, 1);
		for (b in 0...edges.length) {
			this.bosh.graphics.moveTo(edges[b].a.x, edges[b].a.y);
			this.bosh.graphics.lineTo(edges[b].b.x, edges[b].b.y);
		}
	}
	function bodyClip(lib:AssetLibrary) 
	{
		var innerClip:MovieClip;
		innerClip = lib.getMovieClip("");
		body = new MovieClip();
		body.addChild(innerClip);
		innerClip.y = -5.40; //X/Y values are obtained from the raw .fla and are not provided in the source
		body.scaleX = body.scaleY = 0.5;
		this.load_clips();
	}
	function sledClip(lib:AssetLibrary) 
	{
		var innerClip:MovieClip;
		innerClip = lib.getMovieClip("");
		sled = new MovieClip();
		sled.addChild(innerClip);
		innerClip.y = -4.5;
		innerClip.x = -1.3;
		sled.scaleX = sled.scaleY = 0.5;
		this.load_clips();
	}
	function legClip(lib:AssetLibrary) 
	{
		var innerClipA:MovieClip;
		var innerClipB:MovieClip;
		innerClipA = lib.getMovieClip("");
		innerClipB = lib.getMovieClip("");
		leftLeg = new MovieClip();
		rightLeg = new MovieClip();
		leftLeg.addChild(innerClipA);
		rightLeg.addChild(innerClipB);
		innerClipA.x = -1.7;
		innerClipA.y = -4.05;
		innerClipB.x = -1.7;
		innerClipB.y = -4.05;
		leftLeg.scaleX = leftLeg.scaleY = rightLeg.scaleX = rightLeg.scaleY = 0.5;
		this.load_clips();
		this.load_clips();
	}
	function armClip(lib:AssetLibrary) 
	{
		var innerClipA:MovieClip;
		var innerClipB:MovieClip;
		innerClipA = lib.getMovieClip("");
		innerClipB = lib.getMovieClip("");
		leftArm = new MovieClip();
		rightArm = new MovieClip();
		leftArm.addChild(innerClipA);
		rightArm.addChild(innerClipB);
		innerClipA.x = -1.5;
		innerClipA.y = -2.55;
		innerClipB.x = -1.5;
		innerClipB.y = -2.55;
		leftArm.scaleX = leftArm.scaleY = rightArm.scaleX = rightArm.scaleY = 0.5;
		this.load_clips();
		this.load_clips();
	}
	var clips:Int = 0;
	function load_clips()
	{
		++clips;
		if (clips == 6) {
			bosh.addChild(this.leftLeg);
			bosh.addChild(this.leftArm);
			bosh.addChild(this.sled);
			bosh.addChild(this.rightLeg);
			bosh.addChild(this.body);
			bosh.addChild(this.rightArm);
			this.render_body();
		}
	}
	public function flag_location() {
		for (i in anchors) {
			i.save();
		}
		this.markFlag();
	}
	
	function markFlag() 
	{
		try {
			Common.gTrack.back_layer.removeChild(this.flag);
		} catch (_msg:String) {
			
		}
		try {
			Common.simfl_frames = Common.sim_frames;
			this.flag = new FlagMarker(Common.sim_frames);
			Common.gTrack.back_layer.addChild(this.flag);
			this.flag.x = anchors[0].x;
			this.flag.y = anchors[0].y;
			this.crashed = Stick.crash;
			Common.sim_flagged_frame = Common.sim_frames;
		} catch (_msg:String) {}
	}
	public function return_to_flag() {
		for (i in anchors) {
			i.restore();
		}
		Stick.crash = this.crashed;
		Common.sim_frames = Common.simfl_frames;
	}
	
	public function destroy_flag() 
	{
		try {
			Common.gTrack.back_layer.removeChild(this.flag);
		} catch (_msg:String) {
			
		}
	}
}