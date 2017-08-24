package base.cores;
import base.CoreBase;

import openfl.display.Stage;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class Flash extends CoreBase
{

	public function new(_stage:Stage) 
	{
		super(_stage);
		
		Common.gCode = this; //This class
	}
	
}