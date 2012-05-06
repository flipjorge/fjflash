package simplewebsite.controller.events
{
	import flash.events.Event;
	
	public class SearchTermEvent extends Event
	{
		public static const SEARCH:String = "searchTermSearch";
		public static const SEARCH_COMPLETE:String = "searchTermSearchComplete";
		
		public var searchTerm:String;
		public var results:String;
		
		public function SearchTermEvent(type:String, searchTerm:String, results:String = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.searchTerm = searchTerm;
			this.results = results;
		}
		override public function clone():Event
		{
			return new SearchTermEvent(type, searchTerm, results, bubbles, cancelable);
		}
		
	}
}