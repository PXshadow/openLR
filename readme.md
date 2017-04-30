# OpenLR, an open source alternative desktop app for Line Rider.

### Original game by Boštjan "fšk" Čadež

### Build by Kaelan "Kevans" Evans

### The language used is Haxe: http://haxe.org/ (Running Haxe 3.4.2)

## Haxelibs used:
	
	
	openFL 4.9.2:
	lime 4.0.3
	
	(If possible, openLR will always use the latest update for Haxe, openFL, and Lime)
	
## How to compile (Instructions may not work as is):
	
Install Haxe from http://haxe.org/download/
	
Run in terminal the following commands:
	
	haxelib install openfl
	
	haxelib run openfl setup
	(Running this command will install the latest version of lime for you, and othe haxelibs necesary)

Run the command 'openfl' to verify it was installed correctly.

Change terminal directory to root openLR folder.

Run the command:
	
	openfl build mac/linux/windows
	
Project will be compiled into bin folder. Be aware that you can compile to other platforms regardless of the platform you are on,
however compiling to a non-native platform will not produce a native C++ build, and if distributed, will most likely suffer from performance hits.

If possible, on windows platform you can download Haxe Develop and use that as an IDE. OpenFL (and other libraries) will still need to be installed.

## Special Thanks

Boštjan "fšk" Čadež for Line Rider
Haxe developers, Lime developers, and OpenFL Developers
FlashDevelop/HaxeDevelop for being such a wonderful IDE
www.reddit.com/r/linerider
www.weridethelines.com
