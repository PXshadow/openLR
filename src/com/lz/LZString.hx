package com.lz;

import openfl.utils.Object;

/**
 * ...
 * @author Kaelan Evans
 */

/*
class LZString 
{
	//var f = String.fromCharCode();
	var keyStrBase64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	var keyStrUriSafe = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-$";
	var baseReverseDic = {};
	public function new() 
	{
		
	}
	function compressToBase64(input):String {
		if (input == null) {
			return("");
		}
		var res:String = this._compress(input, 6, function(a):String {return (this.keyStrBase64.charAt(a)); });
		switch (res.length % 4) {
			default: return "Failure"; // this is apparently impossible?
			case 0 : return res;
			case 1 : return res+"===";
			case 2 : return res+"==";
			case 3 : return res+"=";
		}
	}
	
	function _compress(uncompressed:Object, bitsPerChar:Int, getCharFromInt:Dynamic):String
	{
		if (uncompressed == null) {
			return("");
		}
		var i;
		var value;
        var context_dictionary:Object = {};
        var context_dictionaryToCreate:Object = {};
        var context_c:String = "";
        var context_wc:String = "";
        var context_w:String = "";
        var context_enlargeIn:Int = 2; // Compensate for the first entry which should not count
        var context_dictSize:Int = 3;
        var context_numBits:Int = 2;
        var context_data:Array<Dynamic> = new Array<Dynamic>();
        var context_data_val:Int = 0;
        var context_data_position:Int = 0;
        var ii:Int = 0;

		while (ii < uncompressed.length) {
			context_c = uncompressed.charAt(ii);
			if (!Object.prototype.hasOwnProperty.call(context_dictionary,context_c)) {
				context_dictionary[context_c] = context_dictSize++;
				context_dictionaryToCreate[context_c] = true;
			}

			context_wc = context_w + context_c;
			if (Object.prototype.hasOwnProperty.call(context_dictionary,context_wc)) {
				context_w = context_wc;
			} else {
				if (Object.prototype.hasOwnProperty.call(context_dictionaryToCreate,context_w)) {
					if (context_w.charCodeAt(0)<256) {
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
						value = context_w.charCodeAt(0);
						for (i in 0...8) {
							context_data_val = (context_data_val << 1) | (value&1);
								if (context_data_position == bitsPerChar-1) {
									context_data_position = 0;
									context_data.push(getCharFromInt(context_data_val));
									context_data_val = 0;
								} else {
									context_data_position++;
								}
								value = value >> 1;
							}
						} else {
							value = 1;
							for (i in 0...context_numBits) {
								context_data_val = (context_data_val << 1) | value;
								if (context_data_position ==bitsPerChar-1) {
									context_data_position = 0;
									context_data.push(getCharFromInt(context_data_val));
									context_data_val = 0;
								} else {
									context_data_position++;
								}
								value = 0;
							}
							value = context_w.charCodeAt(0);
            for (i in 0...16) {
              context_data_val = (context_data_val << 1) | (value&1);
              if (context_data_position == bitsPerChar-1) {
                context_data_position = 0;
                context_data.push(getCharFromInt(context_data_val));
                context_data_val = 0;
              } else {
                context_data_position++;
              }
              value = value >> 1;
            }
          }
          context_enlargeIn--;
          if (context_enlargeIn == 0) {
            context_enlargeIn = Math.pow(2, context_numBits);
            context_numBits++;
          }
          context_dictionaryToCreate[context_w] = null;
        } else {
          value = context_dictionary[context_w];
          for (i in 0...context_numBits) {
            context_data_val = (context_data_val << 1) | (value&1);
            if (context_data_position == bitsPerChar-1) {
              context_data_position = 0;
              context_data.push(getCharFromInt(context_data_val));
              context_data_val = 0;
            } else {
              context_data_position++;
            }
            value = value >> 1;
          }


        }
        context_enlargeIn--;
        if (context_enlargeIn == 0) {
          context_enlargeIn = Math.pow(2, context_numBits);
          context_numBits++;
        }
        // Add wc to the dictionary.
        context_dictionary[context_wc] = context_dictSize++;
        context_w = String(context_c);
      }
    }

    // Output the code for w.
    if (context_w != "") {
      if (Object.prototype.hasOwnProperty.call(context_dictionaryToCreate,context_w)) {
        if (context_w.charCodeAt(0)<256) {
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
          value = context_w.charCodeAt(0);
          for (i in 0...8) {
            context_data_val = (context_data_val << 1) | (value&1);
            if (context_data_position == bitsPerChar-1) {
              context_data_position = 0;
              context_data.push(getCharFromInt(context_data_val));
              context_data_val = 0;
            } else {
              context_data_position++;
            }
            value = value >> 1;
          }
        } else {
          value = 1;
          for (i in 0...context_numBits) {
            context_data_val = (context_data_val << 1) | value;
            if (context_data_position == bitsPerChar-1) {
              context_data_position = 0;
              context_data.push(getCharFromInt(context_data_val));
              context_data_val = 0;
            } else {
              context_data_position++;
            }
            value = 0;
          }
          value = context_w.charCodeAt(0);
          for (i=0 ; i<16 ; i++) {
            context_data_val = (context_data_val << 1) | (value&1);
            if (context_data_position == bitsPerChar-1) {
              context_data_position = 0;
              context_data.push(getCharFromInt(context_data_val));
              context_data_val = 0;
            } else {
              context_data_position++;
            }
            value = value >> 1;
          }
        }
        context_enlargeIn--;
        if (context_enlargeIn == 0) {
          context_enlargeIn = Math.pow(2, context_numBits);
          context_numBits++;
        }
        delete context_dictionaryToCreate[context_w];
      } else {
        value = context_dictionary[context_w];
        for (i=0 ; i<context_numBits ; i++) {
          context_data_val = (context_data_val << 1) | (value&1);
          if (context_data_position == bitsPerChar-1) {
            context_data_position = 0;
            context_data.push(getCharFromInt(context_data_val));
            context_data_val = 0;
          } else {
            context_data_position++;
          }
          value = value >> 1;
        }


      }
      context_enlargeIn--;
      if (context_enlargeIn == 0) {
        context_enlargeIn = Math.pow(2, context_numBits);
        context_numBits++;
      }
    }

    // Mark the end of the stream
    value = 2;
    for (i=0 ; i<context_numBits ; i++) {
      context_data_val = (context_data_val << 1) | (value&1);
      if (context_data_position == bitsPerChar-1) {
        context_data_position = 0;
        context_data.push(getCharFromInt(context_data_val));
        context_data_val = 0;
      } else {
        context_data_position++;
      }
      value = value >> 1;
    }

    // Flush the last char
    while (true) {
      context_data_val = (context_data_val << 1);
      if (context_data_position == bitsPerChar-1) {
        context_data.push(getCharFromInt(context_data_val));
        break;
      }
      else context_data_position++;
    }
	ii += 1
    return context_data.join('');
	}
	private function getBaseValue(alphabet, character) {
		
	}
}
*/