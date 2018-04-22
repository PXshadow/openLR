package lr.nodes; 
 
import openfl.display.Shape; 
import openfl.display.Sprite; 
 
import lr.lines.LineBase; 
 
/** 
 * ... 
 * @author Kaelan Evans 
 */ 
@:enum abstract LayerMode(Int) from Int to Int { 
  public var color:Int = 0; 
  public var black:Int = 1; 
  public var hitTest_black:Int = 2; 
  public var hitTest_color:Int = 3; 
} 
class SubPanel extends Sprite 
{ 
  private var layer_gwell:Shape; 
  private var layer_scene_color:Shape; 
  private var layer_scene_black:Shape; 
  private var layer_color:Shape; 
  private var layer_black:Shape; 
  private var layer_hitTest:Sprite; 
  private var lineCache:Array<LineBase>; 
  public static var array_hitTest:Array<Sprite> = new Array<Sprite>(); 
  public static var array_hitTestActove:Array<Sprite> = new Array<Sprite>(); 
  public static var lit_lines:Array<Sprite> = new Array<Sprite>(); 
   
  public var offset_x:Int = 0; 
  public var offset_y:Int = 0; 
   
  public var gwellZoneVisible:Bool = false; 
   
  public function new(_x:Int, _y:Int)  
  { 
    super(); 
     
    this.offset_x = _x; 
    this.offset_y = _y; 
     
    this.layer_gwell = new Shape(); 
    this.layer_scene_color = new Shape(); 
    this.layer_scene_black = new Shape(); 
    this.layer_color = new Shape(); 
    this.layer_black = new Shape(); 
    this.layer_hitTest = new Sprite(); 
     
    this.addChild(this.layer_scene_color); 
    this.addChild(this.layer_scene_black); 
    this.addChild(this.layer_gwell); 
    this.addChild(this.layer_color); 
    this.addChild(this.layer_black); 
    this.addChild(this.layer_hitTest); 
     
    this.layer_scene_black.visible = false;
	this.cacheAsBitmap = true;
  } 
  public function drawLine(_line:LineBase) { 
    var _loc_3:Float = _line.nx > 0 ? (Math.ceil(_line.nx)) : (Math.floor(_line.nx)); 
    var _loc_4:Float = _line.ny > 0 ? (Math.ceil(_line.ny)) : (Math.floor(_line.ny));  
    switch(_line.type) { 
      case (LineType.Floor) : 
        this.layer_color.graphics.lineStyle(2, 0x0066FF, 1, true, "normal", "round"); 
        this.layer_color.graphics.moveTo((_line.x1 + _loc_3) - this.offset_x, (_line.y1 + _loc_4) - this.offset_y); 
        this.layer_color.graphics.lineTo((_line.x2 + _loc_3) - this.offset_x, (_line.y2 + _loc_4) - this.offset_y); 
        this.layer_black.graphics.lineStyle(2, 0, 1, true, "normal", "round"); 
        this.layer_black.graphics.moveTo((_line.x1) - this.offset_x, (_line.y1) - this.offset_y); 
        this.layer_black.graphics.lineTo((_line.x2) - this.offset_x, (_line.y2) - this.offset_y); 
        SubPanel.array_hitTest[_line.ID] = new Sprite(); 
        SubPanel.array_hitTest[_line.ID].graphics.clear(); 
        SubPanel.array_hitTest[_line.ID].graphics.lineStyle(2, 0x0000FF, 1, true, "normal", "round"); 
        SubPanel.array_hitTest[_line.ID].graphics.moveTo((_line.x1) - this.offset_x, (_line.y1) - this.offset_y); 
        SubPanel.array_hitTest[_line.ID].graphics.lineTo((_line.x2) - this.offset_x, (_line.y2) - this.offset_y); 
        SubPanel.array_hitTest[_line.ID].visible = false; 
        this.layer_hitTest.addChild(SubPanel.array_hitTest[_line.ID]); 
      case (LineType.Accel) : 
        this.layer_color.graphics.lineStyle(2, 0xCC0000, 1, true, "normal", "round"); 
        this.layer_color.graphics.moveTo((_line.x1 + _loc_3) - this.offset_x, (_line.y1 + _loc_4) - this.offset_y); 
        this.layer_color.graphics.lineTo((_line.x2 + _loc_3) - this.offset_x, (_line.y2 + _loc_4) - this.offset_y); 
        this.layer_color.graphics.beginFill(0xCC0000, 1);  
        this.layer_color.graphics.moveTo((_line.x1 + _loc_3) - this.offset_x, (_line.y1 + _loc_4) - this.offset_y);  
        this.layer_color.graphics.lineTo((_line.x2 + _loc_3) - this.offset_x, (_line.y2 + _loc_4) - this.offset_y);  
        this.layer_color.graphics.lineTo(_line.x2 + (_line.nx * 5 - _line.dx * _line.invDst * 5) - this.offset_x, (_line.y2 - this.offset_y) + (_line.ny * 5 - _line.dy * _line.invDst * 5));  
        this.layer_color.graphics.lineTo(_line.x2 - (_line.dx * _line.invDst * 5) - this.offset_x, (_line.y2 - this.offset_y) - (_line.dy * _line.invDst * 5));  
        this.layer_color.graphics.endFill(); 
        this.layer_black.graphics.lineStyle(2, 0, 1, true, "normal", "round"); 
        this.layer_black.graphics.moveTo((_line.x1) - this.offset_x, (_line.y1) - this.offset_y); 
        this.layer_black.graphics.lineTo((_line.x2) - this.offset_x, (_line.y2) - this.offset_y); 
        SubPanel.array_hitTest[_line.ID] = new Sprite(); 
        SubPanel.array_hitTest[_line.ID].graphics.clear(); 
        SubPanel.array_hitTest[_line.ID].graphics.lineStyle(2, 0xFF0000, 1, true, "normal", "round"); 
        SubPanel.array_hitTest[_line.ID].graphics.moveTo((_line.x1) - this.offset_x, (_line.y1) - this.offset_y); 
        SubPanel.array_hitTest[_line.ID].graphics.lineTo((_line.x2) - this.offset_x, (_line.y2) - this.offset_y); 
        SubPanel.array_hitTest[_line.ID].visible = false; 
        this.layer_hitTest.addChild(SubPanel.array_hitTest[_line.ID]); 
      case (LineType.Scene) : 
        this.layer_scene_color.graphics.lineStyle(2, 0x00CC00, 1, true, "normal", "round"); 
        this.layer_scene_color.graphics.moveTo((_line.x1) - this.offset_x, (_line.y1) - this.offset_y); 
        this.layer_scene_color.graphics.lineTo((_line.x2) - this.offset_x, (_line.y2) - this.offset_y); 
        this.layer_scene_black.graphics.lineStyle(2, 0, 1, true, "normal", "round"); 
        this.layer_scene_black.graphics.moveTo((_line.x1) - this.offset_x, (_line.y1) - this.offset_y); 
        this.layer_scene_black.graphics.lineTo((_line.x2) - this.offset_x, (_line.y2) - this.offset_y); 
    } 
  } 
  public function refreshLines(_lines:Array<LineBase>, _break = false) { 
    this.lineCache = _lines; 
    this.layer_black.graphics.clear(); 
    this.layer_color.graphics.clear(); 
    this.layer_scene_black.graphics.clear(); 
    this.layer_scene_color.graphics.clear(); 
    if (_break) return; 
    for (a in _lines) { 
      this.drawLine(a); 
    } 
  } 
  public function refresh() { 
    this.refreshLines(this.lineCache); 
  } 
  public function set_rendermode_playback() { 
    this.layer_color.visible = false; 
    this.layer_scene_black.visible = true; 
    this.layer_scene_color.visible = false; 
  } 
  public function set_rendermode_edit() { 
    this.layer_color.visible = true; 
    this.layer_scene_black.visible = false; 
    this.layer_scene_color.visible = true; 
  } 
  public static function derender_litlines() { 
    for (a in SubPanel.lit_lines) { 
      a.visible = false; 
    } 
    SubPanel.lit_lines = new Array<Sprite>(); 
  } 
}