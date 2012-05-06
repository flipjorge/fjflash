package simplewebsite.remote.services
{
	import fj.remote.utils.FJRequest;
	
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	
	import org.robotlegs.mvcs.Actor;
	
	import simplewebsite.controller.events.SearchTermEvent;
	
	public class TwitterSearch extends Actor implements ISearchService
	{
		public static const SEARCH_URL:String = "http://search.twitter.com/search.json";
		
		private var _lastSearchTerm:String;
		
		public function search( searchTerm:String ):void
		{
			_lastSearchTerm = searchTerm;
			
			var request:FJRequest = new FJRequest();
			request.method = URLRequestMethod.GET;
			request.addEventListener( Event.COMPLETE, onSearchComplete );
			request.load( SEARCH_URL, {q:searchTerm} );
		}
		
		protected function onSearchComplete(event:Event):void
		{
			dispatch( new SearchTermEvent( SearchTermEvent.SEARCH_COMPLETE, _lastSearchTerm, event.currentTarget.data ) );
		}
	}
}