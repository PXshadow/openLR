# OpenLR, an open source app for Line Rider built in Haxe and OpenFL

### Original game by Boštjan "fšk" Čadež

### Build by Kaelan "Kevans" Evans

![](http://i.imgur.com/YlYlSZS.gif)
	
#### Play online versions here
	
Flash: https://kevansevans.github.io/flash/openLR.swf
	
HTML5: https://kevansevans.github.io/openLR-JS/
	
Binaries/Releases can be downloaded here: https://github.com/kevansevans/openLR/releases
	
## What is Open Line Rider?

Open Line Rider is a fan driven successor to the popular internet flash game Line Rider, crafted by a long time community member and community developer. The game is simple: Draw lines, press play, watch Bosh ride your creation. No points to earn, no goals to achieve, just a pure blank canvas and your imagination.

OpenLR is meant to be a build that doesn't answer to community bias, but still caters to the call of community needs, and tries to go beyond what we have accepted as normal conventions. As development progresses, OpenLR will provide tools to make track editing more efficient, while also providing more methods of expression and more free control of how a track can be constructed.

OpenLR is not just open source, it's open to anyone and everyone.

#### What are the goals for OpenLR?

- Provide a faithful editor that is easy to use for new comers, yet familiar and intuitive long time players.
- Provide a more customized track settings that open the doors up for more creative track ideas.
- Provide an easy to use API that allows for future developers to easily modify and create their own versions.
- Provide basic support for everything that every other version has used.

#### Why Haxe and openFL?

The Haxe toolkit was a decision based on the need to make development easier and quicker for myself, and future developers. Haxe reflects the ActionScript 3 syntax, making it a very easy OOL to pick up on. AS2 and AS3 was the first programming languages I learned, and Line Rider was the first thing I used those skills for. OpenLR can be the first step for new developers as well. Other API's and languages don't have the same levels of beginner friendly, which would be counter intuitive to the goals of this project.

The choice with openFL, opposed to Haxe Kha or Haxe Flixel, was for porting reasons. Line Rider being made in AS2, it made porting the engine over much more simple.

Finally, Haxe toolkit allows for powerful cross platform deployment natively. Deploying to your operating system of choice produces a native C++ build. Deploying to HTML5 produces a native HTML5/JavaScript version that can be ran in a web browser. This means that users finding difficulty running one version won't be out of luck, as they have several other targets they can try out.

## Haxelibs used:
	
	Lime 6.2.0 (https://github.com/openfl/lime)
	OpenFL 7.1.2 (http://www.openfl.org/) (https://github.com/openfl/openfl)
	
If possible, openLR will always use the latest update for Haxe, openFL, and Lime. This is to ensure the most efficient builds possible, as performance is a major concern.
	
## How to compile:
	
Install Haxe from http://haxe.org/download

(Or use `sudo apt install haxe` through bash)
	
Run in terminal the following commands, select Y to install if prompted:
	
	haxelib install openfl
	
	haxelib run openfl setup
	
Running the above commands should install all the needed libraries to compile, including Lime. You may have to install other
programs, the commands above assume you already have some form of a development enviornment set up on your system.

Run the command `openfl` to verify it was installed correctly. You should see the OpenFL logo appear in your terminal.

Download/Clone this repository.

Change terminal directory to root openLR folder. It should contain the `openLR.hxproj` or `project.xml` files inside of it.

The following targets are currently supported, run these commands in your terminal to compile:
	
	openfl build cpp
	
	openfl build HTML5
	
	openfl build flash
	
	openFL build air
	
openLR does not support Neko as a target, so compiling to non-native OS target (e.g. user is on windows and runs `openfl build mac/linux`), the build will fail.

## Future plans

Compatibility with other save formats (SOL, JSON, TRK)

Mechanics across various LR builds and titles

Infinite rider support

Custom Rider support through JSON

Full rebindables keys

Multiple Language support

Modding support with cppia and hscript

Mobile deployment to Android and iOS

And way down the line, multiplayer connections

## Special Thanks

Boštjan "fšk" Čadež for Line Rider

InXile for not sending a cease and desist (yet) (this has no official endorsement)

LR-Tools https://github.com/conundrumer/lr-core (Thank you for this)

LRA https://github.com/jealouscloud/linerider-advanced (Thank you for this)

Haxe developers, Lime developers, OpenFL developers, and HaxeUI developers

FlashDevelop/HaxeDevelop for being such a wonderful IDE

www.reddit.com/r/linerider

www.weridethelines.com

HaxeFlixel Discord Server

And you most of all!

You can contact me at kbeevans@gmail.com for questions or info

Join the Line Rider Discord! https://discord.gg/0ggPNq98iruWoixw