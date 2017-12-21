package ui.inter;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

import global.Common;

/**
 * ...
 * @author ...
 */
class FileWindow extends Sprite
{
	public static var selectedIndex:Int = -1;
	public var currentList:Array<String>;
	var displayList:Array<FileItem>;
	public function new(_list:Array<String>) 
	{
		super();
		this.currentList = new Array();
		this.currentList = _list;
		
		this.generateList();
		if (this.currentList.length > 13) {
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, scrollList);
			for (i in 0...displayList.length) {
				var yPos = this.y + (i * 30);
				if (yPos < 0) {
					displayList[i].visible = false;
				} else if (yPos > 370) {
					displayList[i].visible = false;
				} else {
					displayList[i].visible = true;
				}
				if (i == selectedIndex) {
					displayList[i].selected();
				} else {
					displayList[i].deselect();
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
			this.displayList[i].ID = i;
			this.displayList[i].addEventListener(MouseEvent.CLICK, change_selected_index);
			this.displayList[i].addEventListener(MouseEvent.RIGHT_CLICK, update_directory);
		}
	}
	
	function update_directory(e:MouseEvent):Void 
	{
		var item = cast(e.target, FileItem);
		Common.gImport.updateList(item.filePath);
	}
	
	private function change_selected_index(e:MouseEvent):Void 
	{
		var item = cast(e.target, FileItem);
		if (FileWindow.selectedIndex != -1) {
			try {
				this.displayList[FileWindow.selectedIndex].deselect();
			} catch (e:String) {
				
			}
		}
		FileWindow.selectedIndex = item.ID;
		item.selected();
	}
	
}