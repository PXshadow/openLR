package init;

/**
 * ...
 * @author Kaelan Evans
 */
class FileStart
{
	public var ready:Bool = false;
	public function new() 
	{
		checkDirectories();
		loadSettings();
	}
	
	function loadSettings() 
	{
		trace("Loading settings");
	}
	
	function checkDirectories() 
	{
		trace("checking directories");
	}
	
}