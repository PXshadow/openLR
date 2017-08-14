package lr.rider;

import haxe.ds.Vector;
import lr.rider.objects.StartPointVis;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.utils.Object;
import openfl.utils.AssetLibrary;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;

import global.Common;
import global.RiderManager;
import lr.lines.LineBase;
import lr.nodes.B2Grid;
import lr.rider.RiderRecorder;
import lr.rider.objects.FlagMarker;
import lr.rider.objects.VisBase;
import lr.rider.objects.visual.B2Bosh;
import lr.rider.phys.frames.anchors.CPoint;
import lr.rider.phys.skeleton.bones.Stick;
import lr.rider.phys.skeleton.links.B2Skeleton;
import lr.rider.phys.frames.B2Frame;
import lr.rider.phys.frames.B1Frame;
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
	public var Beta3a:Int = 3; //Female Rider
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
	
	var tick_frame = SubFrame.FullTick;
	
	private var riderID:Int;
	
	public function new(_type:Int, _x:Float, _y:Float, _id:Int) 
	{
		super();
		
		this.start_point = new StartPointVis();
		this.addChild(this.start_point);
		
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
		
		this.start_point.x = this.body.anchors[0].x;
		this.start_point.y = this.body.anchors[0].y;
		
		this.adjust_rider_dimensions();
		
		this.recorder = new RiderRecorder(_id);
		this.camera = new RiderCamera();
		
		Common.gStage.addEventListener(KeyboardEvent.KEY_DOWN, this.adjust_rider_debug);
	}
	private function adjust_rider_debug(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.NUMPAD_4 || e.keyCode == Keyboard.NUMPAD_6 || e.keyCode == Keyboard.NUMPAD_8 || e.keyCode == Keyboard.NUMPAD_2) {
			this.adjust_start_velocity(e);
		}
		if (e.keyCode == Keyboard.MINUS || e.keyCode == Keyboard.EQUAL) {
			this.adjust_rider_angle(e);
		}
		this.adjust_rider_dimensions();
		this.clips.render_body();
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
	
	function adjust_start_velocity(e:KeyboardEvent) 
	{
		switch (e.keyCode) {
			case Keyboard.NUMPAD_4:
				this.rider_x_velocity -= 0.2;
			case Keyboard.NUMPAD_6:
				this.rider_x_velocity += 0.2;
			case Keyboard.NUMPAD_8:
				this.rider_y_velocity -= 0.2;
			case Keyboard.NUMPAD_2:
				this.rider_y_velocity += 0.2;
		}
		if (this.rider_x_velocity >= 5) {
			this.rider_x_velocity = 5;
		}
		if (this.rider_x_velocity <= -5) {
			this.rider_x_velocity = -5;
		}
		if (this.rider_y_velocity >= 5) {
			this.rider_y_velocity = 5;
		}
		if (this.rider_y_velocity <= -5) {
			this.rider_y_velocity = -5;
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
	}
	public function iterate() {
		this.body.verlet(this.grav);
		this.scarf.verlet(this.grav);
		for (a in 0...6) {
			this.skeleton.constrain();
			this.scarf.constrain();
			this.collision();
		}
		this.body.crash_check();
		this.recorder.index_frame(Common.sim_frames, this.body.anchors, this.scarf.anchors);
	}
	public function step_rider_back() {
		while (tick_frame != SubFrame.FullTick) {
			this.step_rider_sub();
		}
		recorder.inject_frame(Common.sim_frames - 1, this.body.anchors, this.scarf.anchors);
		if (Common.sim_frames == 0) {
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
		if (Common.sim_frames == 0) {
			this.reset();
		}
		this.camera.pan(this.body.anchors[4]);
		this.clips.render_body();
	}
	function reset() 
	{
		this.body.reset();
		this.scarf.reset();
		RiderManager.crash[this.riderID] = false;
		this.adjust_rider_dimensions();
	}
	public function inject_and_update(_frame:Int) {
		var _loc1 = Common.sim_frames;
		if (_loc1 == 0) {
			return;
		}
		recorder.inject_frame(_frame, this.body.anchors, this.scarf.anchors);
		if (_loc1 != 0) {
			for (a in _frame..._loc1) {
				this.iterate();
				trace("sim frames was not 0");
			}
		} else {
			for (a in 0..._frame) {
				this.iterate();
				this.inject_postion(0);
				Common.sim_max_frames = _frame;
				Common.gTimeline.update();
				trace("sim frames was 0");
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
	public function return_to_start() {
		this.inject_postion(0);
	}
	public function set_start(_x:Float, _y:Float) {
		this.inject_postion(0);
		this.body.set_start(_x, _y);
		this.scarf.set_start(_x, _y);
		this.inject_and_update(0);
		this.start_point.x = this.body.anchors[0].x;
		this.start_point.y = this.body.anchors[0].y;
	}
	public function store_location() {
		if (flagged) {
			this.removeChild(this.flag);
		} else {
			this.flagged = true;
			this.flag_vis = true;
		}
		Common.sim_flagged_frame = Common.sim_frames;
		this.flag = new FlagMarker(Common.sim_frames);
		this.addChild(this.flag);
		this.flag.x = this.body.anchors[4].x;
		this.flag.y = this.body.anchors[4].y;
		this.flag.alpha = 1;
		this.body.save_position();
	}
	public function enable_flag() {
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
					if (B2Grid.grid[_loc1][_loc2].lowFrame == - 1) {
						B2Grid.grid[_loc1][_loc2].lowFrame = Common.sim_frames;
					} else if (Common.sim_frames <  B2Grid.grid[_loc1][_loc2].lowFrame) {
						B2Grid.grid[_loc1][_loc2].lowFrame = Common.sim_frames;
					}
				}
			}
		} 
	}
}