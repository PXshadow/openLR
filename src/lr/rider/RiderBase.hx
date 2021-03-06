package lr.rider;

import openfl.display.Sprite;
import openfl.utils.Object;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;

import global.Common;
import global.SVar;
import global.engine.RiderManager;
import lr.lines.LineBase;
import lr.nodes.Grid;
import lr.rider.RiderRecorder;
import lr.rider.objects.FlagMarker;
import lr.rider.objects.VisBase;
import lr.rider.objects.StartPointVis;
import lr.rider.objects.visual.B2Bosh;
import lr.rider.objects.visual.UBBish;
import lr.rider.phys.skeleton.links.B2Skeleton;
import lr.rider.phys.skeleton.links.UBSkeleton;
import lr.rider.phys.frames.B2Frame;
import lr.rider.phys.frames.B1Frame;
import lr.rider.phys.frames.FrameBase;
import lr.rider.phys.frames.UBFrame;
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
	public var Beta3a:Int = 3; //Female Rider
	public var Beta3b:Int = 4; //this is the one that falls apart
	public var JSON:Int = 5;
	public var UBBishReskin:Int = 6;
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
	public var body:FrameBase;
	public var skeleton:SkeletonBase;
	public var clips:VisBase;
	public var scarf:ScarfBase;
	public var start_point:StartPointVis;
	
	public var grav:Object;
	
	public var recorder:RiderRecorder;
	public var camera:RiderCamera;
	public var flag:FlagMarker;
	
	public var flagged:Bool = false;
	public var flag_vis:Bool = false;
	
	public var rider_angle:Float = 0;
	public var rider_y_flip:Bool = false;
	public var rider_x_flip:Bool = false;
	public var rider_scale:Float = 0.5;
	public var rider_x_velocity:Float = 0.4;
	public var rider_y_velocity:Float = 0;
	public var rider_pos_x:Float = 0;
	public var rider_pos_y:Float = 0;
	
	var tick_frame = SubFrame.FullTick;
	
	private var riderID:Int;
	
	public function new(_type:Int, _x:Float, _y:Float, _id:Int) 
	{
		super();
		
		this.start_point = new StartPointVis();
		this.addChild(this.start_point);
		
		this.start_point.x = 0;
		this.start_point.y = 0;
		
		this.rider_pos_x = _x;
		this.rider_pos_y = _y;
		
		this.riderID = _id;
		
		switch (_type) {
			case 1:
				this.body = new B1Frame(_x, _y, this.riderID);
				this.skeleton = new B2Skeleton(this.body.anchors, this.riderID);
				this.scarf = new B2Scarf(this.body.anchors[5], this.body.anchors[0], _x, _y, this.riderID);
				this.clips = new B2Bosh(this.body, this.scarf, this.skeleton, this, this.riderID);
				this.addChild(this.clips);
			case 2:
				this.body = new B2Frame(_x, _y, this.riderID);
				this.skeleton = new B2Skeleton(this.body.anchors, this.riderID);
				this.scarf = new B2Scarf(this.body.anchors[5], this.body.anchors[0], _x, _y, this.riderID);
				this.clips = new B2Bosh(this.body, this.scarf, this.skeleton, this, this.riderID);
				this.addChild(this.clips);
			case 3:
				//beta 3 rider normal
			case 4:
				//beta 3 rider that falls apart
			case 5 :
				//JSON Custom Rider
			case 6:
				this.body = new UBFrame(_x, _y, this.riderID);
				this.skeleton = new UBSkeleton(this.body.anchors, this.riderID);
				this.scarf = new B2Scarf(this.body.anchors[5], this.body.anchors[0], _x, _y, this.riderID);
				this.clips = new UBBish(this.body, this.scarf, this.skeleton, this, this.riderID);
				this.addChild(this.clips);
			default :
				this.body = new B2Frame(_x, _y, this.riderID);
				this.skeleton = new B2Skeleton(this.body.anchors, this.riderID);
				this.scarf = new B2Scarf(this.body.anchors[5], this.body.anchors[0], _x, _y, this.riderID);
				this.clips = new B2Bosh(this.body, this.scarf, this.skeleton, this, this.riderID);
				this.addChild(this.clips);
		}
		
		this.grav = new Object();
		this.grav.x = 0;
		this.grav.y = 0.175;
		
		this.recorder = new RiderRecorder(_id);
		this.camera = new RiderCamera();
		
		this.recorder.index_frame(0, this.body.anchors, this.scarf.anchors);
	}
	function adjust_rider_angle(e:KeyboardEvent) 
	{
		switch (e.keyCode) {
			case Keyboard.MINUS:
				this.rider_angle -= 1;
			case Keyboard.EQUAL:
				this.rider_angle += 1;
		}
		if (this.rider_angle <= -1) {
			this.rider_angle = 359;
		}
		if (this.rider_angle >= 360) {
			this.rider_angle = 0;
		}
	}
	public function adjust_rider_dimensions() {
		this.body.set_frame_angle(this.rider_angle);
		this.scarf.set_frame_angle(this.rider_angle);
		this.body.adjust_velocity_start(this.rider_x_velocity, this.rider_y_velocity);
		this.scarf.adjust_velocity_start(this.rider_x_velocity, this.rider_y_velocity);
	}
	public function set_rider_play_mode() {
		this.start_point.visible = false;
	}
	public function set_rider_edit_mode() {
		this.start_point.visible = true;
	}
	public function step_rider()
	{
		while (tick_frame != SubFrame.FullTick) {
			this.step_rider_sub();
		}
		this.iterate();
		this.clips.render_body();
		this.camera.pan(this.body.anchors[4]);
		RiderManager.speed[this.riderID] = Math.floor(Math.sqrt(Math.pow(this.body.anchors[5].dx, 2) + Math.pow(this.body.anchors[5].dy - 0.175, 2)) * 1000) / 1000;
	}
	public function iterate() {
		this.body.verlet(this.grav);
		this.scarf.flutter();
		this.scarf.verlet(this.grav);
		for (a in 0...6) {
			this.skeleton.constrain();
			this.scarf.constrain();
			this.collision();
		}
		this.body.crash_check();
		this.recorder.index_frame(SVar.frames, this.body.anchors, this.scarf.anchors);
	}
	public function step_rider_back() {
		while (tick_frame != SubFrame.FullTick) {
			this.step_rider_sub();
		}
		recorder.inject_frame(SVar.frames - 1, this.body.anchors, this.scarf.anchors);
		if (SVar.frames == 0) {
			this.reset();
		}
		this.camera.pan(this.body.anchors[4]);
		this.clips.render_body();
	}
	public function inject_postion(_frame:Int) {
		while (tick_frame != SubFrame.FullTick) {
			this.step_rider_sub();
		}
		recorder.inject_frame(_frame, this.body.anchors, this.scarf.anchors);
		if (SVar.frames == 0) {
			this.reset();
		}
		this.camera.pan(this.body.anchors[4]);
		try {
			this.clips.render_body();
		} catch (e:String) {
			
		}
	}
	public function reset() 
	{
		this.set_start(this.rider_pos_x, this.rider_pos_y);
	}
	public function set_start(_x:Float, _y:Float) {
		this.body.set_start(_x, _y);
		this.scarf.set_start(_x, _y);
		this.rider_pos_x = this.body.anchors[0].x;
		this.rider_pos_y = this.body.anchors[0].y;
		this.start_point.x = this.body.anchors[0].x;
		this.start_point.y = this.body.anchors[0].y;
		RiderManager.crash[this.riderID] = false;
		this.recorder.index_frame(0, this.body.anchors, this.scarf.anchors);
	}
	public function inject_and_update(_frame:Int) {
		var _loc1 = SVar.frames;
		if (_loc1 == 0) {
			return;
		}
		recorder.inject_frame(_frame, this.body.anchors, this.scarf.anchors);
		if (_loc1 != 0) {
			for (a in _frame..._loc1) {
				this.iterate();
			}
		} else {
			for (a in 0..._frame) {
				this.iterate();
				this.inject_postion(0);
				SVar.max_frames = _frame;
				Common.gTimeline.update();
			}
		}
		this.clips.render_body();
	}
	public function step_rider_sub() {
		switch (this.tick_frame) {
			case 0 :
				this.skeleton.constrain();
				this.scarf.constrain();
				this.collision();
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
				this.body.crash_check();
				this.clips.render_body();
				this.tick_frame = SubFrame.FullTick;
			case 6 :
				this.body.verlet(this.grav);
				this.scarf.verlet(this.grav);
				this.clips.render_body();
				this.tick_frame = SubFrame.Momentum;
		}
	}
	public function store_location() {
		if (flagged) {
			this.removeChild(this.flag);
		} else {
			this.flagged = true;
			this.flag_vis = true;
		}
		SVar.flagged_frame = SVar.frames;
		this.flag = new FlagMarker(SVar.frames);
		this.addChild(this.flag);
		this.flag.x = this.body.anchors[4].x;
		this.flag.y = this.body.anchors[4].y;
		this.flag.alpha = 1;
		this.body.save_position();
	}
	public function enable_flag() {
		this.store_location();
		this.flag.alpha = 1;
	}
	public function disable_flag() {
		this.flag.alpha = 0.2;
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
					var tempList:Array<LineBase> = Grid.grid[_loc1][_loc2].secondary;
					for (_loc8 in tempList)
					{
						if (_loc8 == null) {
							continue;
						}
						_loc8.collide(_loc5);
					}
					if (Grid.grid[_loc1][_loc2].lowFrame == - 1) {
						Grid.grid[_loc1][_loc2].lowFrame = SVar.frames;
					} else if (SVar.frames <  Grid.grid[_loc1][_loc2].lowFrame) {
						Grid.grid[_loc1][_loc2].lowFrame = SVar.frames;
					}
				}
			}
		} 
	}
}