package fj.utils 
{
	public class FJArray 
	{
		public static function cleanEmptyFields( array:Array ):Array
		{
			var newArray:Array = new Array();
			var tempObj:Object;
			for (var i:int = 0; i < array.length; i++) 
			{
				tempObj = array[i] as Object;
				if ( tempObj != null )
					newArray.push( tempObj );
			}
			return newArray;
		}
		public static function clone( array:Array ):Array
		{
			var tempArray:Array = new Array();
			for( var i:int = 0; i < array.length; i++ ){
				tempArray.push( array[i] );
			}
			return tempArray;
		}
		public static function exists( obj:Object, array:Array ):Boolean
		{
			var tempObj:Object;
			for (var i:int = 0; i < array.length; i++) 
			{
				tempObj = array[i] as Object;
				if ( tempObj == obj )
					return true;
			}
			return false;
		}
		public static function findIndex( obj:Object, array:Array ):int
		{
			var tempObj:Object;
			for (var i:int = 0; i < array.length; i++) 
			{
				tempObj = array[i] as Object;
				if ( tempObj == obj )
					return i;
			}
			return -1;
		}
		
		public static function shuffle( array:Array ):Array
		{
			var newArray:Array = new Array();
			var nRandom:uint;
			while( array.length > 0 ){
				nRandom = Math.random() * array.length;
				newArray.push( array.splice( nRandom, 1 )[0] );
			}
			return newArray;
		}
		
		public static function remove( obj:Object, array:Array ):void
		{
			var tempObj:Object;
			for (var i:int = 0; i < array.length; i++) 
			{
				tempObj = array[i] as Object;
				if ( tempObj == obj )
					array.splice( i, 1 );
			}
		}
		
		public static function invert( array:Array ):Array
		{
			var newArray:Array = new Array();
			while( array.length > 0 ){
				newArray.push( array.pop() );
			}
			return newArray;
		}
	}
}