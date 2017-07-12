package file.ui;
import openfl.display.SimpleButton;

/**
 * ...
 * @author Kaelan Evans
 */
class FileButton extends SimpleButton
{
	public var ID:Int = 0;
	public var filePath:String;
	public var file_parent:FileItem;
	public function new(_id:Int, _path:String, _parent:FileItem) 
	{
		super();
		this.ID = _id;
		this.filePath = _path;
		this.file_parent = _parent;
	}
	
}