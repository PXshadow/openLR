package platform.online;

import haxe.Http;

/**
 * ...
 * @author Kaelan Evans
 * 
 */
#if KeysAvailable
	@:file("assets/keys/keys.json")
	class JsonKeys extends openfl.utils.ByteArray.ByteArrayData {}
#end
@:enum abstract ActionURL(String) from String {
	public var Overwrite:String = "https://api.dropboxapi.com/2/file_properties/properties/overwrite";
	public var NewFolder:String = "https://api.dropboxapi.com/2/files/create_folder";
	public var Authorize:String = "https://www.dropbox.com/oauth2/authorize";
}
class Dropbox 
{
	public static var token:String = "Fake AF token";
	public function new() 
	{
		trace(new JsonKeys());
	}
	public function init_dropbox_folder() {
		var request:Http = new Http(ActionURL.NewFolder);
		request.addHeader("Authorization", "Bearer " + token);
		request.addHeader("Content-Type", "application/json");
		request.setPostData('{"path":"/openLR"}');
		request.request(true);
	}
}