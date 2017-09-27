# OpenLR, an open source desktop app for Line Rider.

### Original game by Boštjan "fšk" Čadež

### Build by Kaelan "Kevans" Evans

![](http://i.imgur.com/tfI0Lk2.gif)

### The language used is Haxe: http://haxe.org
	
Binaries/Releases can be downloaded here: https://github.com/kevansevans/openLR/releases

## Haxelibs used:
	
	HXCPP 3.4.185 (haxelib set hxcpp 3.4.185)
	openFL 6.2.0 (http://www.openfl.org/) (https://github.com/openfl/openfl)
	lime 5.6.0 (https://github.com/openfl/lime)
	
If possible, openLR will always use the latest update for Haxe, openFL, and Lime. This is to ensure the most efficient builds possible, as performance is a major concern.
	
## How to compile:
	
Install Haxe from http://haxe.org/download

(Or use `sudo apt install haxe` through bash)
	
Run in terminal the following commands, select Y to install if prompted:
	
	haxelib set hxcpp 3.4.185
	
	haxelib install openfl
	
	haxelib run openfl setup
	
Running the above commands should install all the needed libraries to compile, including Lime. You may have to install other
programs, the commands above assume you already have some form of a development enviornment set up on your system.

Run the command `openfl` to verify it was installed correctly. You should see the OpenFL logo appear in your terminal.

Change terminal directory to root openLR folder. It should contain the `openLR.hxproj` or `project.xml` files inside of it.

Run the command:
	
	openfl build cpp
	
Alternative targets include `openfl build html5`, and `openfl build flash`. More will be added as development progresses.
	
Project will be compiled into bin folder. Be aware that you can compile to other platforms regardless of the platform you are on,
however, compiling to a non-native platform will not produce a native C++ build, and will most likely suffer from performance hits.

If running on a debian based linux branch, the file 'openLR' will need to be renamed to 'openLR.sh'. This has been tested on Ubuntu and Lubuntu. Other haxe supported linux branches have not been tested.

Note: If you are running Windows 10 Ubuntu Bash, you will need to update Ubuntu and install G++ if you have not already. 
Run the command `sudo apt install g++` and the project should correctly compile to the Linux target.

If possible, on windows platform you can download Haxe Develop and use that as an IDE. OpenFL (and other libraries) will still need to be installed. Other IDE's can be used, and will most likely support a Haxe plugin that can compile for you without using the terminal.

## Future plans

Better save format

Compatibility with other save formats (SOL, JSON, TRK)

Mechanics across various LR builds and titles

Infinite rider support

Custom Rider support through JSON

Full rebindables keys

Multiple Language support

Modding support with cppia and hscript

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