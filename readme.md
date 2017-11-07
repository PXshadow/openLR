# OpenLR, an open source desktop app for Line Rider.

### Original game by Boštjan "fšk" Čadež

### Build by Kaelan "Kevans" Evans

![](http://i.imgur.com/tfI0Lk2.gif)

### The language used is Haxe: http://haxe.org
	
Play online versions here
	
Flash: https://kevansevans.github.io/flash/openLR.swf
	
HTML5: https://kevansevans.github.io/openLR-JS/
	
Binaries/Releases can be downloaded here: https://github.com/kevansevans/openLR/releases

## Haxelibs used:
	
	HXCPP 3.4.185 (haxelib set hxcpp 3.4.185)
	lime 5.8.1 (https://github.com/openfl/lime)
	openFL 6.4.0 (http://www.openfl.org/) (https://github.com/openfl/openfl)
	HaxeUI Dev Branch (http://haxeui.org/)
	
If possible, openLR will always use the latest update for Haxe, openFL, and Lime. This is to ensure the most efficient builds possible, as performance is a major concern.
	
## How to compile:
	
Install Haxe from http://haxe.org/download

(Or use `sudo apt install haxe` through bash)
	
Run in terminal the following commands, select Y to install if prompted:
	
	haxelib set hxcpp 3.4.185
	
	haxelib install openfl
	
	haxelib run openfl setup
	
	haxelib git haxeui-core https://github.com/haxeui/haxeui-core
		
	haxelib git haxeui-core https://github.com/haxeui/haxeui-openfl
	
Running the above commands should install all the needed libraries to compile, including Lime. You may have to install other
programs, the commands above assume you already have some form of a development enviornment set up on your system.

Run the command `openfl` to verify it was installed correctly. You should see the OpenFL logo appear in your terminal.

Download/Clone this repository.

Change terminal directory to root openLR folder. It should contain the `openLR.hxproj` or `project.xml` files inside of it.

The following targets are currently supported:
	
	openfl build cpp
	
	openfl build HTML5
	
	openfl build flash
	
	openFL build air
	
openLR does not support Neko as a target, so compiling to non-native OS target (e.g. user is on windows and runs `openfl build mac/linux`), the build will fail.

## Future plans

Better save format

Compatibility with other save formats (SOL, JSON, TRK)

Mechanics across various LR builds and titles

Infinite rider support

Custom Rider support through JSON

Full rebindables keys

Multiple Language support

Modding support with cppia and hscript

Mobile deployment to Android and iOS

## Special Thanks

Boštjan "fšk" Čadež for Line Rider

InXile for not sending a cease and desist (yet) (this has no official endorsement)

LR-Tools https://github.com/conundrumer/lr-core (Thank you for this)

LRA https://github.com/jealouscloud/linerider-advanced (Thank you for this)

Haxe developers, Lime developers, and OpenFL Developers

FlashDevelop/HaxeDevelop for being such a wonderful IDE

www.reddit.com/r/linerider

www.weridethelines.com

HaxeFlixel Discord Server

And you most of all!

You can contact me at kbeevans@gmail.com for questions or info