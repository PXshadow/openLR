package ui.inter;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;

import global.Common;
import lr.tool.IconButton;
import lr.tool.IconBase;

/**
 * ...
 * @author ...
 */
class ConfirmDialog extends Sprite
{
	private var alert_message:TextField;
	private var yes_button:IconButton;
	private var no_button:IconButton;
	private var trash:Sprite;
	var font:TextFormat = new TextFormat(Assets.getFont("fonts/Verdana.ttf").fontName, 14, 0, null, null, null, null, null, TextFormatAlign.CENTER);
	public function new(_msg:String = "Message not set", _yes:Dynamic = null, _no:Dynamic = null, _newTrack:Bool = false) 
	{
		super();
		
		this.graphics.clear();
		this.graphics.lineStyle(2, 0, 1);
		this.graphics.beginFill(0xFFFFFF, 1);
		this.graphics.moveTo(0, 0);
		this.graphics.lineTo(450, 0);
		this.graphics.lineTo(450, 200);
		this.graphics.lineTo(0, 200);
		this.graphics.lineTo(0, 0);
		
		this.alert_message = new TextField();
		this.alert_message.defaultTextFormat = font;
		this.alert_message.text = _msg;
		this.alert_message.selectable = false;
		this.alert_message.wordWrap = true;
		this.addChild(this.alert_message);
		this.alert_message.width = this.width;
		this.alert_message.y = 40;
		
		if (_newTrack) {
			var innerClip:Sprite;
			#if (!flash)
				innerClip = Common.OLR_Assets.getMovieClip("trash_track");
			#elseif (flash)
				innerClip = Assets.getMovieClip("swf-library:trash_can");
			#end
			trash = new Sprite();
			trash.addChild(innerClip);
			this.addChild(this.trash);
			
			this.trash.x = -140;
			this.trash.y = 80;
		}
		
		this.yes_button = new IconButton(Icon.yes);
		this.addChild(this.yes_button);
		this.yes_button.x = 150;
		this.yes_button.y = 140;
		this.yes_button.addEventListener(MouseEvent.CLICK, _yes);
		
		this.no_button = new IconButton(Icon.no);
		this.no_button.addEventListener(MouseEvent.CLICK, _no);
		this.addChild(this.no_button);
		this.no_button.x = 200;
		this.no_button.y = 140;
	}
	
}