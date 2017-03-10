package ui.inter;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author ...
 */
class SingleButton extends Sprite
{
	var textContainer:Sprite;
	var msg:TextField;
	var vis_box:Sprite;
	public function new(_msg:String, action:Dynamic = null) 
	{
		super();
		this.vis_box = new Sprite();
		this.textContainer = new Sprite();
		this.msg = new TextField();
		this.msg.text = _msg;
		this.msg.selectable = false;
		
		this.textContainer.addChild(this.msg);
		this.textContainer.x = this.textContainer.y = 5;
		
		this.addChild(this.vis_box);
		this.vis_box.graphics.clear();
		this.vis_box.graphics.lineStyle(2, 0, 1);
		this.vis_box.graphics.beginFill(0xFFFFFF, 1);
		this.vis_box.graphics.moveTo(0, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, 0);
		this.vis_box.graphics.lineTo(this.textContainer.width + 5, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, this.textContainer.height + 5);
		this.vis_box.graphics.lineTo(0, 0);
		
		this.addChild(this.textContainer);
	}
	
}