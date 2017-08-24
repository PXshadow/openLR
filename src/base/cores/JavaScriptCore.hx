package base.cores;

import openfl.display.Stage;

import base.CoreBase;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class JavaScriptCore extends CoreBase
{

	public function new(_stage:Stage) 
	{
		super(_stage);
		
		Common.gCode = this; //This class
	}
	
}