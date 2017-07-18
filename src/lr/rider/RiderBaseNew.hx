package lr.rider;

import haxe.ds.Vector;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.utils.Object;
import openfl.utils.AssetLibrary;

import global.Common;
import lr.line.Grid;
import lr.line.LineBase;
import lr.rider.phys.contacts.anchors.CPoint;
import lr.rider.phys.skeleton.B2Skeleton;
import lr.rider.phys.contacts.B2Body;
import lr.rider.phys.skeleton.bones.Stick;
import lr.rider.phys.skeleton.B2Scarf;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract RiderType(Int) from Int to Int {
	public var Beta1:Int = 1;
	public var Beta2:Int = 2;
	public var Beta3a:Int = 3;
	public var Beta3b:Int = 4; //this is the one that falls apart
	public var JSON:Int = 5;
}
@:enum abstract SubFrame(Int) from Int to Int {
	public var Momentum:Int = 0;
	public var Step1:Int = 1;
	public var Step2:Int = 2;
	public var Step3:Int = 3;
	public var Step4:Int = 4;
	public var Step5:Int = 5;
	public var FullTick:Int = 6;
}
class RiderBaseNew extends Sprite
{
	public var recorded_frames:Array<Array<Array<Dynamic>>>;
	
	public var body:B2Body;
	public var skeleton:B2Skeleton;
	public var scarf:B2Scarf;
	public var grav:Object;
	
	public var bosh:Sprite;
	private var body_vis:Sprite;
	private var leftArm:Sprite;
	private var rightArm:Sprite;
	private var leftLeg:Sprite;
	private var rightLeg:Sprite;
	private var sled:Sprite;
	private var string:Sprite;
	private var scarf_vis:Sprite;
	private var skeleton_vis:Sprite;
	
	var tick_frame = SubFrame.FullTick;
	
	public function new(_type:Int) 
	{
		super();
		
		this.recorded_frames = new Array();
		
		switch (_type) {
			case 1:
				//beta 1 rider
			case 2:
				this.body = new B2Body(0, 0);
				this.skeleton = new B2Skeleton(this.body.anchors);
				this.scarf = new B2Scarf(this.body.anchors[5]);
			case 3:
				//beta 3 rider normal
			case 4:
				//beta 3 rider that falls apart
			default :
				this.body = new B2Body(0, 0);
				this.skeleton = new B2Skeleton(this.body.anchors);
				this.scarf = new B2Scarf(this.body.anchors[5]);
		}
		this.bosh = new Sprite();
		this.getAssets();
		
		this.grav = new Object();
		this.grav.x = 0;
		this.grav.y = 0.175;
	}
	public function step_rider()
	{
		while (tick_frame != SubFrame.FullTick) {
			this.step_rider_sub();
		}
		this.body.verlet(this.grav);
		this.scarf.verlet(this.grav);
		for (a in 0...6) {
			this.skeleton.constrain();
			this.scarf.constrain();
			this.collision();
		}
		this.body.crash_check();
		this.render_body();
	}
	public function step_rider_sub() {
		switch (this.tick_frame) {
			case 0 :
				this.body.verlet(this.grav);
				this.scarf.verlet(this.grav);
				this.render_body();
				this.tick_frame = SubFrame.Step1;
			case 1 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.render_body();
				this.tick_frame = SubFrame.Step2;
			case 2 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.render_body();
				this.tick_frame = SubFrame.Step3;
			case 3 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.render_body();
				this.tick_frame = SubFrame.Step4;
			case 4 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.render_body();
				this.tick_frame = SubFrame.Step5;
			case 5 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.render_body();
				this.tick_frame = SubFrame.FullTick;
			case 6 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.body.crash_check();
				this.render_body();
				this.tick_frame = SubFrame.Momentum;
		}
	}
	public function return_to_start() {
		
	}
	public function record_frame() {
		var anchors:Vector<CPoint> = this.body.anchors;
		this.recorded_frames[Common.sim_frames] = new Array();
		for (i in 0...anchors.length) {
			this.recorded_frames[Common.sim_frames][i] = new Array();
			this.recorded_frames[Common.sim_frames][i][0] = this.body.anchors[i].x;
			this.recorded_frames[Common.sim_frames][i][1] = this.body.anchors[i].y;
			this.recorded_frames[Common.sim_frames][i][2] = this.body.anchors[i].vx;
			this.recorded_frames[Common.sim_frames][i][3] = this.body.anchors[i].vy;
			this.recorded_frames[Common.sim_frames][i][4] = this.body.anchors[i].dx;
			this.recorded_frames[Common.sim_frames][i][5] = this.body.anchors[i].dy;
			this.recorded_frames[Common.sim_frames][i][6] = Stick.crash;
		}
	}
	private function getAssets() {
		//These are used to preserve the resolution quality of the rider when scaling.
		var swfLibSled = AssetLibrary.loadFromFile("swf/sled.bundle");
		swfLibSled.onComplete(sledClip);
		
		var swfLibBody = AssetLibrary.loadFromFile("swf/body.bundle");
		swfLibBody.onComplete(bodyClip);
		
		var swfLibLeg = AssetLibrary.loadFromFile("swf/leg.bundle");
		swfLibLeg.onComplete(legClip);
		
		var swfLibArm = AssetLibrary.loadFromFile("swf/arm.bundle");
		swfLibArm.onComplete(armClip);
	}
	function bodyClip(lib:AssetLibrary) 
	{
		var innerClip:Sprite;
		innerClip = lib.getMovieClip("");
		body_vis = new Sprite();
		body_vis.addChild(innerClip);
		innerClip.y = -5.40; //X/Y values are obtained from the raw .fla and are not provided in the source
		body_vis.scaleX = body_vis.scaleY = 0.5;
		this.load_clips();
	}
	function sledClip(lib:AssetLibrary) 
	{
		var innerClip:Sprite;
		innerClip = lib.getMovieClip("");
		sled = new Sprite();
		sled.addChild(innerClip);
		innerClip.y = -4.5;
		innerClip.x = -1.3;
		sled.scaleX = sled.scaleY = 0.5;
		this.load_clips();
	}
	function legClip(lib:AssetLibrary) 
	{
		var innerClipA:Sprite;
		var innerClipB:Sprite;
		innerClipA = lib.getMovieClip("");
		innerClipB = lib.getMovieClip("");
		leftLeg = new Sprite();
		rightLeg = new Sprite();
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
		var innerClipA:Sprite;
		var innerClipB:Sprite;
		innerClipA = lib.getMovieClip("");
		innerClipB = lib.getMovieClip("");
		leftArm = new Sprite();
		rightArm = new Sprite();
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
			this.scarf_vis = new Sprite();
			bosh.addChild(this.scarf_vis);
			bosh.addChild(this.leftLeg);
			bosh.addChild(this.leftArm);
			bosh.addChild(this.sled);
			bosh.addChild(this.rightLeg);
			bosh.addChild(this.body_vis);
			this.string = new Sprite();
			bosh.addChild(this.string);
			bosh.addChild(this.rightArm);
			this.skeleton_vis = new Sprite();
			bosh.addChild(this.skeleton_vis);
			this.addChild(this.bosh);
			this.render_body();
		}
	}
	public function render_body()
	{
		this.body_vis.x = this.body.anchors[4].x;
		this.body_vis.y = this.body.anchors[4].y;
		this.body_vis.rotation = Common.get_angle_degrees(new Point(this.body.anchors[4].x, this.body.anchors[4].y), new Point(this.body.anchors[5].x, this.body.anchors[5].y));
		
		this.sled.x = this.body.anchors[0].x;
		this.sled.y = this.body.anchors[0].y;
		this.sled.rotation = Common.get_angle_degrees(new Point(this.body.anchors[0].x, this.body.anchors[0].y), new Point(this.body.anchors[3].x, this.body.anchors[3].y));
		
		this.leftArm.x = this.rightArm.x = this.body.anchors[5].x;
		this.leftArm.y = this.rightArm.y = this.body.anchors[5].y;
		this.leftArm.rotation = Common.get_angle_degrees(new Point(this.body.anchors[5].x, this.body.anchors[5].y), new Point(this.body.anchors[6].x, this.body.anchors[6].y));
		this.rightArm.rotation = Common.get_angle_degrees(new Point(this.body.anchors[5].x, this.body.anchors[5].y), new Point(this.body.anchors[7].x, this.body.anchors[7].y));
		
		this.leftLeg.x = this.rightLeg.x = this.body.anchors[4].x;
		this.leftLeg.y = this.rightLeg.y = this.body.anchors[4].y;
		this.leftLeg.rotation = Common.get_angle_degrees(new Point(this.body.anchors[4].x, this.body.anchors[4].y), new Point(this.body.anchors[8].x, this.body.anchors[8].y));
		this.rightLeg.rotation = Common.get_angle_degrees(new Point(this.body.anchors[4].x, this.body.anchors[4].y), new Point(this.body.anchors[9].x, this.body.anchors[9].y));
		
		//rider rendering
		this.body_vis.alpha = this.leftArm.alpha = this.rightArm.alpha = this.leftLeg.alpha = this.rightLeg.alpha = this.sled.alpha = Common.cvar_rider_alpha;
		this.bosh.graphics.clear();
		this.string.graphics.clear();
		this.skeleton_vis.graphics.clear();
		this.scarf_vis.graphics.clear();
		if (!Stick.crash) {
			this.string.graphics.lineStyle(0.5, 0, Common.cvar_rider_alpha);
			this.string.graphics.moveTo(this.body.anchors[6].x, this.body.anchors[6].y);
			this.string.graphics.lineTo(this.body.anchors[3].x, this.body.anchors[3].y);
			this.string.graphics.lineTo(this.body.anchors[7].x, this.body.anchors[7].y);
		}
		if (Common.cvar_contact_points) {
			this.render_bones();
		}
		this.scarf_vis.graphics.lineStyle(2, 0xFFFFFF, Common.cvar_rider_alpha, false, "none", "none");
		this.scarf_vis.graphics.moveTo(this.scarf.edges[0].a.x, this.scarf.edges[0].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[0].b.x, this.scarf.edges[0].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[2].a.x, this.scarf.edges[2].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[2].b.x, this.scarf.edges[2].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[4].a.x, this.scarf.edges[4].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[4].b.x, this.scarf.edges[4].b.y);
		this.scarf_vis.graphics.lineStyle(2, 0xD20202, Common.cvar_rider_alpha, false, "none", "none");
		this.scarf_vis.graphics.moveTo(this.scarf.edges[1].a.x, this.scarf.edges[1].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[1].b.x, this.scarf.edges[1].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[3].a.x, this.scarf.edges[3].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[3].b.x, this.scarf.edges[3].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[5].a.x, this.scarf.edges[5].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[5].b.x, this.scarf.edges[5].b.y);
	}
	public function render_bones() {
		this.bosh.graphics.clear();
		this.skeleton_vis.graphics.lineStyle(0.25, 0xFF6600, 1);
		for (i in 0...4) { //Minimal sled points
			this.skeleton_vis.graphics.moveTo(this.skeleton.edges[i].a.x, this.skeleton.edges[i].a.y);
			this.skeleton_vis.graphics.lineTo(this.skeleton.edges[i].b.x, this.skeleton.edges[i].b.y);
		}
		this.skeleton_vis.graphics.lineStyle(0.25, 0xCC0033, 1);
		for (i in 9...14) { //Minimal body_vis points
			this.skeleton_vis.graphics.moveTo(this.skeleton.edges[i].a.x, this.skeleton.edges[i].a.y);
			this.skeleton_vis.graphics.lineTo(this.skeleton.edges[i].b.x, this.skeleton.edges[i].b.y);
		}
		this.skeleton_vis.graphics.lineStyle(0.25, 0x6600ff, 0.1);
		for (i in 0...this.body.anchors.length) {
			this.skeleton_vis.graphics.beginFill(0x6600ff, 1);
			this.skeleton_vis.graphics.drawCircle(this.body.anchors[i].x, this.body.anchors[i].y, 0.5);
			this.skeleton_vis.graphics.endFill();
		}
	}
	function collision() 
	{
		for (_loc7 in 0...this.body.anchors.length)
		{
			var _loc5 = this.body.anchors[_loc7];
			var _loc6 = Common.gridPos(_loc5.x, _loc5.y);
			for (_loc4 in -1...2)
			{
				var _loc1 = (_loc6.x + _loc4);
				if (Grid.grid[_loc1] == null)
				{
					continue;
				}
				for (_loc3 in -1...2)
				{
					var _loc2 = (_loc6.y + _loc3);
					if (Grid.grid[_loc1][_loc2] == null)
					{
						continue;
					}
					var tempList:Array<LineBase> = Grid.grid[_loc1][_loc2].storage2;
					for (_loc8 in tempList)
					{
						_loc8.collide(_loc5);
					}
				}
			}
		} 
	}
}