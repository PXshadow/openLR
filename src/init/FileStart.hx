package init;

/**
 * ...
 * @author Kaelan Evans
 * 
 * makes sure directories are made and proper file navigation is established
 * 
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