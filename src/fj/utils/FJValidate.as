package fj.utils
{
	
	public class FJValidate
	{
		public static function email( string:String ):Boolean
		{
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var result:Object = pattern.exec( string );
			if ( result != null )
				return true;
			else
				return false;
		}
	}
}