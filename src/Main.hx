package;

import openfl.display.Sprite;
import openfl.Lib;

import init.FileStart;
import global.Common;
import ui.tool.ToolMouseNull;

/**
 * ...
 * @author Kaelan Evans
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //OpenLR Project
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * This program was built using FlashDevelop IDE, with haxe and openFL. Other libraries if used can be found in project.xml
 */
class Main extends Sprite 
{
	private var test_tool:ToolMouseNull;
	
	private var mainFileInit:FileStart;
	public function new() 
	{
		super();
		
		mainFileInit = new FileStart();
		this.init_env();
		
		this.test_tool = new ToolMouseNull();
	}
	public function init_env()
	{
		Common.gCode = this;
		Common.gStage = this.stage;
	}
}
