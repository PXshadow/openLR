package base.cores;
import base.CoreBase;

import flash.display.Stage;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class FlashCore extends CoreBase
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