package file;

/**
 * 
 * Haxe implementation of LZString http://pieroxy.net/blog/pages/lz-string/index.html https://github.com/pieroxy/lz-string/
 * This is needed to correctly load www.linerider.com saves that compress the saves it generates.
 * Will upload as own library when finished
 * 
 */
class HXLZString 
{
	static var f = String.fromCharCode;
	static var keyStrBase64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	static var keyStrUriSafe:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-$";
	static var baseReverseDic:Map<String, Map<String, Int>> = new Map();
	
	public function new() 
	{
		
	}
	static function getBaseValue(alphabet:String, character:String) {
		if (baseReverseDic[alphabet] == null) {
			baseReverseDic[alphabet] = new Map();
			for (i in 0...alphabet.length) {
				baseReverseDic[alphabet][alphabet.charAt(i)] = i;
			}
		}
		return baseReverseDic[alphabet][character];
	}
	static function compressToBase64(input:String) {
		
	}
	static function decompressFromBase64(input:String) {
		
	}
	static function compressToUTF16(input:String) {
		
	}
	static function decompressFromUTF16(input:String) {
		
	}
	static function compressToUint8Array(input:String) {
		
	}
	static function decompressFromUint8Array(input:String) {
		
	}
	static function compressToEncodedURIComponent(input:String) {
		
	}
	static function decompressFromEncodedURIComponent(input:String) {
		
	}
	static public function compress(uncompressed:String):String {
		return HXLZString._compress(uncompressed, 16, function(a){return f(a); });
	}
	static function _compress(uncompressed:String, bitsPerChar:Int, getCharFromInt:Dynamic):String {
		if (uncompressed == null) return "";
		var value,
        context_dictionary:Map<String, Int> = new Map(),
        context_dictionaryToCreate:Map<String, Bool> = new Map(),
        context_c:String = "",
        context_wc:String = "",
        context_w:String= "",
        context_enlargeIn:Int = 2,
        context_dictSize:Int = 3,
        context_numBits:Int = 2,
        context_data:Array<String> = new Array(),
        context_data_val:Int = 0,
        context_data_position:Int  = 0;
		
		for (ii in 0...uncompressed.length) {
			context_c = uncompressed.charAt(ii);
			if (context_dictionary[context_c] == null) {
				context_dictionary[context_c] = context_dictSize++;
				context_dictionaryToCreate[context_c] = true;
			}
		}
		
		context_wc = context_w + context_c;
		if (context_dictionary[context_wc] == null) {
			context_w = context_wc;
		} else {
			if (context_dictionaryToCreate[context_w] == null) {
				if (context_w.charCodeAt(0) < 256) {
					for (i in 0...context_numBits) {
						context_data_val = (context_data_val << 1);
						if (context_data_position == bitsPerChar-1) {
							context_data_position = 0;
							context_data.push(getCharFromInt(context_data_val));
							context_data_val = 0;
						} else {
							context_data_position++;
						}
					}
				}
			}
		}
		
		return context_data.join('');
	}
}