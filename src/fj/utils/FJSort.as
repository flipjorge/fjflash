package fj.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class FJSort
	{
		
		public static function y( container:DisplayObjectContainer ):void
		{
			var nChilds:uint = container.numChildren;
			if( nChilds > 1 ){
				var index:int = 0;
				var obj:DisplayObject;
				var arrayChilds:Array = new Array();
					
				for( var i:int = 0; i < container.numChildren; i++){
					obj = container.getChildAt( i );
					arrayChilds.push( obj );
				}
				arrayChilds.sortOn( "y", Array.NUMERIC );
				for each( obj in arrayChilds ){
					container.setChildIndex( obj, index++ );
				}
				arrayChilds = null;
			}
		}
		
		public static function z( container:DisplayObjectContainer ):void
		{
			var nChilds:uint = container.numChildren;
			if( nChilds > 1 ){
				var index:int = 0;
				var obj:DisplayObject;
				var arrayChilds:Array = new Array();
					
				for( var i:int = 0; i < container.numChildren; i++ ){
					obj = container.getChildAt( i );
					arrayChilds.push( obj );
				}
				arrayChilds.sortOn( "z", Array.NUMERIC | Array.DESCENDING );
				for each( obj in arrayChilds ){
					container.setChildIndex( obj, index++ );
				}
				arrayChilds = null;
			}
		}
	}
}