package file.ui;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.display.SimpleButton;

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
	}
	
	function generateList() 
	{
		this.displayList = new Array();
		for (i in 0...this.currentList.length) {
			this.displayList[i] = new FileItem(i, this.currentList[i]);
			this.addChild(this.displayList[i]);
			this.displayList[i].x = 10;
			this.displayList[i].y = (i * 30) + 10;
			this.displayList[i].hitBox.addEventListener(MouseEvent.MOUSE_DOWN, change_selected_index);
		}
	}
	
	private function change_selected_index(e:MouseEvent):Void 
	{
		var item = cast(e.target, FileButton);
		if (FileWindow.selectedIndex != -1) {
			this.displayList[FileWindow.selectedIndex].deselect();
		}
		FileWindow.selectedIndex = item.ID;
		item.file_parent.selected();
	}
	
}