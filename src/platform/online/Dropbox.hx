package platform.online;

#if sys
import haxe.Http;
import lime.system.System;
import openfl.Lib;
import openfl.net.SharedObject;
import sys.io.File;
import sys.FileSystem;

import global.Common;
import ui.inter.AlertBox;

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
	/*
	 * If the user wants, they can provide their own token and modify the compiler flags to allow this class to be used.
	 * You can visit here for a dev token: https://dropbox.github.io/dropbox-api-v2-explorer/
	 * Just select any of the API documentaion pages and there will be a button to generate a code.
	 * Note that this might not work as intended, the keys requested here only have App folder access
	 * */
	var alert:AlertBox;
	public function new() 
	{
		#if KeysAvailable
			this.init_dropbox_connection();
		#else
			trace("Keys are not available");
			return;
		#end
	}
	#if KeysAvailable
	
	var localKeySave:SharedObject;
	function init_dropbox_connection() 
	{
		if (!FileSystem.exists(System.applicationStorageDirectory + "localOnlineInfo.sol")) {
			return; //Would be initialized at start up, but if clearly there's no info here, then it's pointless to do anything;
		}
		this.localKeySave = SharedObject.getLocal("localOnlineInfo", "/");
		this.checkConntection();
	}
	
	function checkConntection()
	{
		trace("checking connection");

		var _locHtpp:Http = new Http("https://www.dropbox.com");
		_locHtpp.onError = function(status) {
			this.checkErrorCode(status);
		}
		_locHtpp.onStatus = function(status) {
			this.checkConnectionCode(status);
		}
		_locHtpp.request(false);
	}
	function checkErrorCode(status:Dynamic) 
	{
		trace(status, "failed");
	}
	function checkConnectionCode(status:Dynamic) 
	{
		trace(status, "success!");
	}
	function beginAuthorizationProcess() {
		
	}
	function requestReAuthorization() 
	{
		trace("Hey I need to ask for permissions again!");
	}
	
	public function init_dropbox_folder_no_api() {
		var request:Http = new Http(ActionURL.NewFolder);
		request.addHeader("Authorization", "Bearer " + token);
		request.addHeader("Content-Type", "application/json");
		request.setPostData('{"path":"/openLR"}');
		request.request(true);
	}
	#end
}