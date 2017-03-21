package file.ui;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;

import global.Common;

/**
 * ...
 * @author ...
 */
class FileWindow extends MovieClip
{
	var currentList:Array<String>;
	var displayList:Array<FileItem>;
	public function new(_list:Array<String>) 
	{
		super();
		this.currentList = new Array();
		this.currentList = _list;
		
		this.generateList();
		if (this.currentList.length > 13) {
			Common.gStage.addEventListener(MouseEvent.MOUSE_WHEEL, scrollList);
			for (i in 0...displayList.length) {
				var yPos = this.y + (i * 30);
				if (yPos < 0) {
					displayList[i].visible = false;
				} else if (yPos > 370) {
					displayList[i].visible = false;
				} else {
					displayList[i].visible = true;
				}
			}
		}
	}
	
	private function scrollList(e:MouseEvent):Void 
	{
		this.y += 5 * e.delta;
		if (this.y >= 0) {
			this.y = 0;
		} else if (this.y <= (((currentList.length * 30) - 390) * -1)) {
			this.y = (((currentList.length * 30) - 390) * -1);
		}
		for (i in 0...displayList.length) {
			var yPos = this.y + (i * 30);
			if (yPos < 0) {
				displayList[i].visible = false;
			} else if (yPos > 370) {
				displayList[i].visible = false;
			} else {
				displayList[i].visible = true;
			}
		}
	}
	
	function generateList() 
	{
		this.displayList = new Array();
		for (i in 0...this.currentList.length) {
			this.displayList[i] = new FileItem(this.currentList[i]);
			this.addChild(this.displayList[i]);
			this.displayList[i].x = 10;
			this.displayList[i].y = (i * 30) + 10;
		}
	}
	
}