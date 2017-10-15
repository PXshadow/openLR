package  {
	
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.FileReference;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    import flash.display.MovieClip;
	import flash.
	
	public class main extends MovieClip {

		public function main() {
			this.download();
		}
		var localRef:FileReference;
        var urlVars:URLVariables;
        var fileRequest:URLRequest;
		var str:String = File.applicationDirectory.nativePath;

        private function download():void
        {
            localRef = new FileReference();
            localRef.addEventListener(Event.COMPLETE, completeHandler);

            urlVars = new URLVariables();
            urlVars.id = 456;

            fileRequest = new URLRequest();
            fileRequest.method = URLRequestMethod.GET;
            fileRequest.data = urlVars;
            fileRequest.url = "https://kevansevans.github.io/flash/openLR.swf";
			localRef.
        }

        private function completeHandler(e:Event):void
        {
            trace('OK. Dosya Kaydedildi.');
			this.removeChild(loader);
        }

	}
	
}
