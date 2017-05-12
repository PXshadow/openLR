![](http://i.imgur.com/tfI0Lk2.gif)

# OpenLR, an open source alternative desktop app for Line Rider.

### Original game by Boštjan "fšk" Čadež

### Build by Kaelan "Kevans" Evans

### The language used is Haxe: http://haxe.org/ (Running Haxe 3.4.2)
	
Binaries can be downloaded here: https://github.com/kevansevans/openLR/releases

## Haxelibs used:
	
	
	openFL 5.0.0
	lime 4.1.0
	
	(If possible, openLR will always use the latest update for Haxe, openFL, and Lime)
	
## How to compile:
	
Install Haxe from http://haxe.org/download/
	
Run in terminal the following commands:
	
	haxelib install openfl
	
	haxelib run openfl setup
	
Running the above commands should install all the needed libraries to compile, including Lime,

Run the command 'openfl' to verify it was installed correctly. You should see the OpenFL logo appear in your terminal.

Change terminal directory to root openLR folder.

Run the command:
	
	openfl build cpp
	
Project will be compiled into bin folder. Be aware that you can compile to other platforms regardless of the platform you are on,
however compiling to a non-native platform will not produce a native C++ build, and will most likely suffer from performance hits.

Note: If you are running Windows 10 Ubuntu Bash, you will need to update Ubuntu and install G++ if you have not already. Run the command `sudo apt-get install g++` and the project should correctly compile to the Linux target.

If possible, on windows platform you can download Haxe Develop and use that as an IDE. OpenFL (and other libraries) will still need to be installed. Other IDE's can be used, and will most likely support a Haxe plugin that can compile for you without using the terminal.

## Special Thanks

Boštjan "fšk" Čadež for Line Rider

Haxe developers, Lime developers, and OpenFL Developers

FlashDevelop/HaxeDevelop for being such a wonderful IDE

www.reddit.com/r/linerider

www.weridethelines.com

