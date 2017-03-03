package;

import lr.Toolbar;
import lr.Track;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.Lib;

import init.FileStart;
import global.Common;

/**
 * ...
 * @author Kaelan Evans
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //OpenLR Project
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * This program was built using FlashDevelop IDE, with haxe and openFL. Other libraries if used can be found in project.xml
 * 
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * //Known issues to make work around
 * /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * 
 * -- OpenFL does not constantly update vector graphics. Zomming in will cause blurring of lines.
 * -- Haxe does not support array indexing in negative values. Map data type might possible fix this instead of Array or Vector.
 * 
 */
class Main extends Sprite 
{
	private var mainFileInit:FileStart;
	private var visContainer:MovieClip;
	private var track:Track;
	private var toolBar:Toolbar;
	
	public function new() 
	{
		super();
		
		mainFileInit = new FileStart();
		
		this.init_env();
		this.init_track();
	}
	public function init_env()
	{
		Common.gCode = this;
		Common.gStage = this.stage;
	}
	
	public function init_track()
	{
		this.visContainer = new MovieClip();
		this.addChild(visContainer);
		Common.gVisContainer = this.visContainer;
		
		this.track = new Track();
		this.visContainer.addChild(this.track);
		
		this.toolBar = new Toolbar();
		this.visContainer.addChild(this.toolBar);
	}
}
