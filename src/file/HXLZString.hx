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
	static function decompressFromBase64(input:String)
	{
		
	}
}