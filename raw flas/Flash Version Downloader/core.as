package  {
	
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.FileReference;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
	import flash.net.URLStream;
    import flash.display.MovieClip;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	
	public class core extends MovieClip {
		
		var urlString:String = "https://kevansevans.github.io/flash/openLR.swf";
		var urlReq:URLRequest = new URLRequest(urlString);
		var urlStream:URLStream = new URLStream();
		var fileData:ByteArray = new ByteArray();
		var swfLoader:Loader;                     // create a new instance of the Loader class
		var swfurl:URLRequest;
		
		public function core() {
			this.loader.checker_text.text = "Downloading latest...";
			urlStream.addEventListener(Event.COMPLETE, loaded);
			urlStream.load(urlReq);
		}
		function loaded(event:Event):void
		{
			urlStream.readBytes(fileData, 0, urlStream.bytesAvailable);
			writeAirFile();
		}
		function writeAirFile():void
		{ 
			// Change the folder path to whatever you want plus name your mp3
			// If the folder or folders does not exist it will create it.
			var file:File = File.applicationStorageDirectory.resolvePath("swf/openLR.swf");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(fileData, 0, fileData.length);
			fileStream.close();
			this.removeChild(this.loader);
			this.addSwfToStage();
		}
		function addSwfToStage() {
			this.swfLoader = new Loader();
			var path:File = File.applicationStorageDirectory.resolvePath("swf/openLR.swf");
			this.swfurl = new URLRequest(path.nativePath);
			this.swfLoader.load(this.swfurl);
			this.addChild(this.swfLoader);
		}
	}
}