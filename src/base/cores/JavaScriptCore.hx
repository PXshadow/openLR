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

	private var title_card:TitleCard;
	public function new(_stage:Stage) 
	{
		super(_stage);
		
		Common.gCode = this; //This class
		
		this.title_card = new TitleCard();
		this.main_stage.addChild(this.title_card);
	}
	
}