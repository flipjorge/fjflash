package fj.utils 
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.symmetric.ICipher;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	import flash.utils.ByteArray;
	
	public class FJSecurity
	{
		
		public static function encrypt( string:String, key:String, type:String = "rc4" ):String
		{
			var hexKey = Hex.toArray(Hex.fromString(key));
			
			var data:ByteArray = Hex.toArray(Hex.fromString(string));
			var pad:IPad = new PKCS5;
			var mode:ICipher = Crypto.getCipher(type, hexKey, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);
			
			return Base64.encodeByteArray(data);
		}
		public static function decrypt( string:String, key:String, type:String = "rc4" ):String
		{
			var hexKey = Hex.toArray(Hex.fromString(key));
			
			var data:ByteArray = Base64.decodeToByteArray(string);
			var pad:IPad = new PKCS5;
			var mode:ICipher = Crypto.getCipher(type, hexKey, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.decrypt(data);
			
			return Hex.toString(Hex.fromArray(data));
		}
	}
}