package;

import file.SaveManager;
import global.FrameRate;
import global.SimManager;
import haxe.Timer;
import lr.TextInfo;
import lr.Toolbar;
import lr.Track;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;

import init.FileStart;
import global.Common;
import ui.inter.SingleButton;

/**
 * ...
 * @author Kaelan Evans
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //OpenLR Project Release Alpha 0.0.3
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * This program was built using HaxeDevelop IDE, with haxe and openFL. Other libraries if used can be found in project.xml
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //Known issues to work around
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 *  --None ATM
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //Notes
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * -- GitKraken test: Success!
 * -- Supported platforms
 * 		-- Windows: Yes!
 * 		-- Linux: Yes! (Debian)
 * 		-- OSX: Yes! (Built in Yosemite)
 * --Need to clean up some of the "rabbit hole" functions. Starting to get lost in my own code.
 * --Need to make some UI classes. Check boxes, radio buttons, lists.
 * --Need to work on defaults for settings. Alpha 0.0.4 will probably be that
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //To do
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * -- Arbitrary save parser. Will allow for saves to be incomplete and future proof
 * -- UI system. Menus, checkboxes, radio buttons, arbitrarily sized buttons, fonts, blah blah blah
 * -- Better file management. Save with name support, save as (arbitrary location), load from saves folder, and browse.
 * 
 */
class Main extends Sprite 
{
	private var mainFileInit:FileStart; //this class controls settings
	private var visContainer:MovieClip; //simple display container. This will make it easier to take screenshots and record video without having to move a matrix all around
	private var track:Track;
	private var toolBar:Toolbar;
	private var textInfo:TextInfo;
	private var FPS:FrameRate;
	
	public function new() 
	{
		super(); //In Haxe, a super must be called when classes inherit
		
		this.mainFileInit = new FileStart();
		this.init_env();
		this.init_track();
	}
	
	public function init_env() //Initialize enviornment
	{
		Common.gCode = this; //This class
		Common.gStage = this.stage; //The stage, not to be comfused with main.hx
		
		Common.stage_height = this.stage.stageHeight;
		Common.stage_width = this.stage.stageWidth;
		
		this.stage.addEventListener(Event.RESIZE, resize);
		
		this.FPS = new FrameRate();
	}
	
	public function init_track() //display minimum items
	{
		this.visContainer = new MovieClip();
		this.addChild(visContainer);
		Common.gVisContainer = this.visContainer;
		
		this.track = new Track();
		this.visContainer.addChild(this.track);
		this.track.x = this.stage.stageWidth * 0.5;
		this.track.y = this.stage.stageHeight * 0.5;
		
		this.toolBar = new Toolbar();
		this.visContainer.addChild(this.toolBar);
		
		this.textInfo = new TextInfo();
		this.addChild(this.textInfo);
	}
	private function resize(e:Event):Void
	{
		trace(this.stage.stageWidth, this.stage.stageHeight);
		this.visContainer.x = this.visContainer.y = 0;
		this.toolBar.x = (this.stage.stageWidth / 2) - (this.toolBar.width / 2); 
		
		Common.stage_height = this.stage.stageHeight;
		Common.stage_width = this.stage.stageWidth;
		
		this.textInfo.x = (this.stage.stageWidth - this.textInfo.width) - 5;
		this.textInfo.y = 5;
	}
	public function return_to_origin() {
		this.track.x = this.stage.stageWidth * 0.5;
		this.track.y = this.stage.stageHeight * 0.5;
	}
}
