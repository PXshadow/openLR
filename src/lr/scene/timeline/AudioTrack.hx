package lr.scene.timeline;

import haxe.io.Bytes;
import lime.media.AudioBuffer;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundMixer;
import openfl.utils.ByteArray;
import sys.io.File;

import global.Common;

/**
 * ...
 * @author Kaelan Evans
 */
class AudioTrack 
{
	var soundBytes:Bytes;
	var soundBytesArray:Bytes;
	var soundTrack:Sound;
	var soundChannel:SoundChannel;
	var soundBuffer:AudioBuffer;
	
	public static var leftChannelAverage:Array<Int>;
	public static var rightChannelAverage:Array<Int>;
	public function new() 
	{
		Common.gAudioTrack = this;
		
		this.soundBytes = File.getBytes("./s3k.ogg");
		this.soundTrack = Sound.fromAudioBuffer(this.soundBuffer = AudioBuffer.fromBytes(this.soundBytes));
		this.getByteData();
	}
	public function playTrack() {
		this.soundChannel = soundTrack.play();
	}
	public function stopTrack() {
		this.soundChannel.stop();
	}
	private function getByteData() {
		AudioTrack.leftChannelAverage = new Array();
		AudioTrack.rightChannelAverage = new Array();
		
		soundBytesArray = ByteArray.fromBytes(this.soundBuffer.data.toBytes());
		
		var bytePos:Int = 0;
		for (i in 0...Math.floor(soundBytesArray.length / 8))
		{
			trace(soundBytesArray.getUInt16(bytePos), soundBytesArray.getUInt16(bytePos + 4));
			bytePos += 8;
		}
	}
}