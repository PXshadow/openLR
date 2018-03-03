package platform.file;

//Primary
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

//secondary

//third party
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
@:enum abstract FileType(Int) from Int to Int {
	public var cancel:Int = -2;
	public var unknown:Int = -1;
	public var New:Int = 0;
	public var Directory:Int = 1;
	public var JSON:Int = 2;
	public var TRK:Int = 3;
	public var SOL:Int = 4;
}
class BrowserBase extends Sprite
{
	var fileLoader:ImportBase;
	
	var textField_title:TextField;
	var textField_versionInfo:TextField;
	
	var textField_fileName:TextField;
	var textField_filePath:TextField;
	
	private var font_a:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana Bold.ttf").fontName, 24, 0, null, null, null, null, null, TextFormatAlign.LEFT); 
	private var font_b:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.LEFT); 
	
	public function new() {
		super();
		
		this.render();
		
		this.draw_title();
		
		Lib.current.stage.addChild(this);
		
		Lib.current.stage.addEventListener(Event.RESIZE, this.resize);
	}
	public function display_info(_fileName:String, _fileType:Int, _filePath:String) {
		
	}
	public function render() {
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(Lib.current.stage.stageWidth, 0);
		this.graphics.lineTo(Lib.current.stage.stageWidth, 80);
		this.graphics.lineStyle(4, 0, 1);
		this.graphics.lineTo(0, 80);
	}
	public function draw_title() {
		this.textField_title = new TextField(); 
		this.addChild(this.textField_title); 
		this.textField_title.selectable = false; 
		this.textField_title.x = this.textField_title.y = 5; 
		this.textField_title.defaultTextFormat = this.font_a; 
		this.textField_title.width = 160; 
		#if sys
			this.textField_title.text = "OpenLR\nC++";
		#elseif js
			this.textField_title.text = "OpenLR\nHTML5";
		#elseif flash
			this.textField_title.text = "OpenLR\nFlash";
		#end
		this.textField_title.text += " " + Common.version;
	}
	public function add_title_interface() {
		
	}
	public function resize(e:Event) {
		this.render();
	}
}
	