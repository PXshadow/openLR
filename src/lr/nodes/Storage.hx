package lr.nodes;

import lr.lines.LineBase;

/**
 * ...
 * @author Kaelan Evans
 */
class Storage 
{
	public var primary:Array<LineBase>;
	public var secondary:Array<LineBase>;
	public var lowFrame = -1;
	public function new() 
	{
		this.primary = new Array();
		this.secondary = new Array();
	}
	public function inject_line(_line:LineBase) {
		this.primary.push(_line);
		if (_line.type != 2) {
			this.secondary.push(_line);
		}
		haxe.ds.ArraySort.sort(this.secondary, function(a, b):Int {
			if (a.ID < b.ID) return 1;
			else if (a.ID > b.ID) return -1;
			return 0;
		});
	}
	public function remove_line(_line:LineBase) {
		this.primary.remove(_line);
		this.secondary.remove(_line);
	}
}