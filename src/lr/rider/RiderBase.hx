package lr.rider;

import haxe.ds.Vector;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.utils.Object;
import openfl.utils.AssetLibrary;

import global.Common;
import lr.line.LineBase;
import lr.line.nodes.B2Grid;
import lr.rider.objects.VisBase;
import lr.rider.objects.visual.B2Bosh;
import lr.rider.phys.frames.anchors.CPoint;
import lr.rider.phys.skeleton.bones.Stick;
import lr.rider.phys.skeleton.links.B2Skeleton;
import lr.rider.phys.frames.B2Frame;
import lr.rider.phys.frames.FrameBase;
import lr.rider.phys.skeleton.scarf.B2Scarf;
import lr.rider.phys.skeleton.ScarfBase;
import lr.rider.phys.skeleton.SkeletonBase;

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
class RiderBase extends Sprite
{
	public var recorded_frames:Array<Array<Array<Dynamic>>>;
	
	public var body:FrameBase;
	public var skeleton:SkeletonBase;
	public var clips:VisBase;
	public var scarf:ScarfBase;
	
	public var grav:Object;
	
	var tick_frame = SubFrame.FullTick;
	
	public function new(_type:Int) 
	{
		super();
		
		this.recorded_frames = new Array();
		
		switch (_type) {
			case 1:
				//beta 1 rider
			case 2:
				this.body = new B2Frame(0, 0);
				this.skeleton = new B2Skeleton(this.body.anchors);
				this.scarf = new B2Scarf(this.body.anchors[5]);
				this.clips = new B2Bosh(this.body, this.scarf, this.skeleton, this);
				this.addChild(this.clips);
			case 3:
				//beta 3 rider normal
			case 4:
				//beta 3 rider that falls apart
			default :
				this.body = new B2Frame(0, 0);
				this.skeleton = new B2Skeleton(this.body.anchors);
				this.scarf = new B2Scarf(this.body.anchors[5]);
				this.clips = new B2Bosh(this.body, this.scarf, this.skeleton, this);
				this.addChild(this.clips);
		}
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
		this.clips.render_body();
	}
	public function step_rider_sub() {
		switch (this.tick_frame) {
			case 0 :
				this.body.verlet(this.grav);
				this.scarf.verlet(this.grav);
				this.clips.render_body();
				this.tick_frame = SubFrame.Step1;
			case 1 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.clips.render_body();
				this.tick_frame = SubFrame.Step2;
			case 2 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.clips.render_body();
				this.tick_frame = SubFrame.Step3;
			case 3 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.clips.render_body();
				this.tick_frame = SubFrame.Step4;
			case 4 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.clips.render_body();
				this.tick_frame = SubFrame.Step5;
			case 5 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.clips.render_body();
				this.tick_frame = SubFrame.FullTick;
			case 6 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
				this.body.crash_check();
				this.clips.render_body();
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
	function collision() 
	{
		for (_loc7 in 0...this.body.anchors.length)
		{
			var _loc5 = this.body.anchors[_loc7];
			var _loc6 = Common.gridPos(_loc5.x, _loc5.y);
			for (_loc4 in -1...2)
			{
				var _loc1 = (_loc6.x + _loc4);
				if (B2Grid.grid[_loc1] == null)
				{
					continue;
				}
				for (_loc3 in -1...2)
				{
					var _loc2 = (_loc6.y + _loc3);
					if (B2Grid.grid[_loc1][_loc2] == null)
					{
						continue;
					}
					var tempList:Array<LineBase> = B2Grid.grid[_loc1][_loc2].storage2;
					for (_loc8 in tempList)
					{
						_loc8.collide(_loc5);
					}
				}
			}
		} 
	}
}