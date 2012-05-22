package fj.facebook.model.vo 
{
	public class FJFBUser
	{
		public var id:String;
		public var name:String;
		public var idiom:String;
		public var location:String;
		
		public function getFirstName():String
		{
			var space:int = name.indexOf( " " );
			
			return name.substr(0, space);
		}
		
		public function getLastName():String
		{
			var space:int = name.lastIndexOf( " " );
			
			return name.substr(space+1);
		}
		
		public function getCity():String
		{
			if ( location ) {
				var comma:int = location.indexOf( "," );
				
				return location.substr(0, comma);
			} else {
				return null;
			}
		}
		
		public function getCountry():String
		{
			if ( location ) {
				var comma:int = location.lastIndexOf( "," );
				
				return location.substr(comma + 2);
			} else {
				return null;
			}
		}
	}
}