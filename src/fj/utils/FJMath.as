package fj.utils
{
	public class FJMath
	{
		public static function leadingZeros( number:int, length:uint ):String
		{
			var sNumber:String = String( number );
			while ( sNumber.length < length ) {
				sNumber = "0" + sNumber;
			}
			return sNumber;
		}
	}
}