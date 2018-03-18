package lr.rider.objects.visual;

import openfl.display.Sprite;
import openfl.display.LineScaleMode;
import openfl.geom.Point;
import openfl.geom.ColorTransform;
import openfl.utils.AssetLibrary;

#if (flash)
	import openfl.Assets;
#end

import global.Common;
import global.CVar;
import global.engine.RiderManager;
import lr.rider.RiderBase;
import lr.rider.phys.SkeletonBase;
import lr.rider.objects.VisBase;
import lr.rider.phys.frames.FrameBase;
import lr.rider.phys.scarf.ScarfBase;

/**
 * ...
 * @author Kaelan Evans
 */
class B2Bosh extends VisBase
{
	public var bosh:Sprite;
	
	private var color_a:Int = 0xD20202;
	private var color_b:Int = 0xFFFFFF;
	
	private var body_vis:Sprite;
	private var leftArm:Sprite;
	private var rightArm:Sprite;
	private var leftLeg:Sprite;
	private var rightLeg:Sprite;
	private var sled:Sprite;
	private var string:Sprite;
	private var scarf_a:Sprite;
	private var scarf_b:Sprite;
	private var scarf_vis:Sprite;
	private var skeleton_vis:Sprite;
	
	private var body:FrameBase;
	private var scarf:ScarfBase;
	private var skeleton:SkeletonBase;
	private var base:RiderBase;
	
	private var riderID:Int;
	
	public function new(_body:FrameBase, _scarf:ScarfBase, _skeleton:SkeletonBase, _base:RiderBase, _id:Int) 
	{
		super();
		
		this.riderID = _id;
		
		this.body = _body;
		this.scarf = _scarf;
		this.skeleton = _skeleton;
		
		this.bosh = new Sprite();
		this.addChild(this.bosh);
		
		this.getAssets();
	}
	private function getAssets() {
	
		#if (!flash)
			this.sledClip(Common.OLR_Assets);
			this.bodyClip(Common.OLR_Assets);
			this.legClip(Common.OLR_Assets);
			this.armClip(Common.OLR_Assets);
		#elseif (flash)
			this.sledClip();
			this.bodyClip();
			this.legClip();
			this.armClip();
		#end
	}
	function bodyClip(lib:AssetLibrary = null) 
	{
		var innerClip:Sprite;
		var innerClipB:Sprite;
		var innerClipC:Sprite;
		#if (!flash)
			innerClip = lib.getMovieClip("olr_body");
			innerClipB = lib.getMovieClip("scarf_a");
			innerClipC = lib.getMovieClip("scarf_b");
		#elseif (flash)
			innerClip = Assets.getMovieClip("swf-library:olr_body");
		#end
		
		body_vis = new Sprite();
		body_vis.addChild(innerClip);
		
		scarf_a = new Sprite();
		scarf_a.addChild(innerClipB);
		body_vis.addChild(scarf_a);
		
		scarf_b = new Sprite();
		scarf_b.addChild(innerClipC);
		body_vis.addChild(scarf_b);
		
		innerClip.y = -5.40;
		
		innerClipB.y = -5;
		innerClipB.x = 14.4;
		innerClipB.rotation = 90;
		
		innerClipC.y = -3;
		innerClipC.x = 14.4;
		innerClipC.rotation = 90;
		
		body_vis.scaleX = body_vis.scaleY = 0.5;
		this.load_clips();
	}
	function sledClip(lib:AssetLibrary = null) 
	{
		var innerClip:Sprite;
		#if (!flash)
			innerClip = lib.getMovieClip("olr_sled");
		#elseif (flash)
			innerClip = Assets.getMovieClip("swf-library:olr_sled");
		#end
		sled = new Sprite();
		sled.addChild(innerClip);
		innerClip.y = -4.5;
		innerClip.x = -1.3;
		sled.scaleX = sled.scaleY = 0.5;
		this.load_clips();
	}
	function legClip(lib:AssetLibrary = null) 
	{
		var innerClipA:Sprite;
		var innerClipB:Sprite;
		#if (!flash)
			innerClipA = lib.getMovieClip("olr_leg");
			innerClipB = lib.getMovieClip("olr_leg");
		#elseif (flash)
			innerClipA = Assets.getMovieClip("swf-library:olr_leg");
			innerClipB = Assets.getMovieClip("swf-library:olr_leg");
		#end
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
	function armClip(lib:AssetLibrary = null) 
	{
		var innerClipA:Sprite;
		var innerClipB:Sprite;
		#if (!flash)
			innerClipA = lib.getMovieClip("olr_arm");
			innerClipB = lib.getMovieClip("olr_arm");
		#elseif (flash)
			innerClipA = Assets.getMovieClip("swf-library:olr_arm");
			innerClipB = Assets.getMovieClip("swf-library:olr_arm");
		#end
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
			this.render_body();
		}
	}

	override public function render_body()
	{
		var _locFloatAlpha:Float = CVar.rider_alpha * 0.1;
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
		this.body_vis.alpha = this.leftArm.alpha = this.rightArm.alpha = this.leftLeg.alpha = this.rightLeg.alpha = this.sled.alpha = _locFloatAlpha;
		this.bosh.graphics.clear();
		this.string.graphics.clear();
		this.skeleton_vis.graphics.clear();
		this.scarf_vis.graphics.clear();
		if (!RiderManager.crash[this.riderID]) {
			#if (flash)
				this.string.graphics.lineStyle(1, 0, _locFloatAlpha, false, LineScaleMode.NONE);
			#else
				this.string.graphics.lineStyle(0.5, 0, _locFloatAlpha, false, LineScaleMode.NONE);
			#end
			this.string.graphics.moveTo(this.body.anchors[6].x, this.body.anchors[6].y);
			this.string.graphics.lineTo(this.body.anchors[3].x, this.body.anchors[3].y);
			this.string.graphics.lineTo(this.body.anchors[7].x, this.body.anchors[7].y);
		}
		if (CVar.contact_points) {
			this.render_bones();
		}
		#if (flash)
			this.scarf_vis.graphics.lineStyle(2, this.color_b, _locFloatAlpha, false, LineScaleMode.NORMAL, "none");
		#else
			this.scarf_vis.graphics.lineStyle(2, this.color_b, _locFloatAlpha, false, LineScaleMode.NONE, "none");
		#end
		this.scarf_vis.graphics.moveTo(this.scarf.edges[0].a.x, this.scarf.edges[0].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[0].b.x, this.scarf.edges[0].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[2].a.x, this.scarf.edges[2].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[2].b.x, this.scarf.edges[2].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[4].a.x, this.scarf.edges[4].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[4].b.x, this.scarf.edges[4].b.y);
		#if (flash)
			this.scarf_vis.graphics.lineStyle(2, this.color_a, _locFloatAlpha, false, LineScaleMode.NORMAL, "none");
		#else
			this.scarf_vis.graphics.lineStyle(2, this.color_a, _locFloatAlpha, false, LineScaleMode.NONE, "none");
		#end
		this.scarf_vis.graphics.moveTo(this.scarf.edges[1].a.x, this.scarf.edges[1].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[1].b.x, this.scarf.edges[1].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[3].a.x, this.scarf.edges[3].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[3].b.x, this.scarf.edges[3].b.y);
		this.scarf_vis.graphics.moveTo(this.scarf.edges[5].a.x, this.scarf.edges[5].a.y);
		this.scarf_vis.graphics.lineTo(this.scarf.edges[5].b.x, this.scarf.edges[5].b.y);
	}
	override public function set_scarf_color(a:Int, b:Int) {
		this.color_a = a;
		this.color_b = b;
		
		this.scarf_a.transform.colorTransform = new ColorTransform(((a >> 16) & 0xff) / 255, ((a >> 8) & 0xff) / 255, ((a & 0xff) / 255));
		this.scarf_b.transform.colorTransform = new ColorTransform(((b >> 16) & 0xff) / 255, ((b >> 8) & 0xff) / 255, ((b & 0xff) / 255));
	}
	public function render_bones() {
		this.bosh.graphics.clear();
		#if (flash)
			this.skeleton_vis.graphics.lineStyle(1, 0xFF6600, 0.5, false, LineScaleMode.NORMAL);
		#else
			this.skeleton_vis.graphics.lineStyle(0.25, 0xFF6600, 1, false, LineScaleMode.NONE);
		#end
		for (i in 0...4) { //Minimal sled points
			this.skeleton_vis.graphics.moveTo(this.skeleton.edges[i].a.x, this.skeleton.edges[i].a.y);
			this.skeleton_vis.graphics.lineTo(this.skeleton.edges[i].b.x, this.skeleton.edges[i].b.y);
		}
		#if (flash)
			this.skeleton_vis.graphics.lineStyle(1, 0xCC0033, 0.5, false, LineScaleMode.NORMAL);
		#else
			this.skeleton_vis.graphics.lineStyle(0.25, 0xCC0033, 1, false, LineScaleMode.NONE);
		#end
		for (i in 9...14) { //Minimal body_vis points
			this.skeleton_vis.graphics.moveTo(this.skeleton.edges[i].a.x, this.skeleton.edges[i].a.y);
			this.skeleton_vis.graphics.lineTo(this.skeleton.edges[i].b.x, this.skeleton.edges[i].b.y);
		}
		#if (flash)
			this.skeleton_vis.graphics.lineStyle(0.25, 0x6600FF, 1, false, LineScaleMode.NORMAL);
		#else
			this.skeleton_vis.graphics.lineStyle(0.25, 0x6600FF, 0.1, false, LineScaleMode.NONE);
		#end
		for (i in 0...this.body.anchors.length) {
			this.skeleton_vis.graphics.beginFill(0x6600ff, 1);
			this.skeleton_vis.graphics.drawCircle(this.body.anchors[i].x, this.body.anchors[i].y, 0.5);
			this.skeleton_vis.graphics.endFill();
		}
		#if (flash)
			this.skeleton_vis.graphics.lineStyle(1, 0x0000FF, 0.5, false, LineScaleMode.NORMAL);
		#else
			this.skeleton_vis.graphics.lineStyle(0.25, 0x0000FF, 1, false, LineScaleMode.NONE);
		#end
		for (i in 0...this.body.anchors.length) {
			this.skeleton_vis.graphics.moveTo(this.body.anchors[i].x, this.body.anchors[i].y);
			this.skeleton_vis.graphics.lineTo(this.body.anchors[i].nx , this.body.anchors[i].ny);
		}
	}
}