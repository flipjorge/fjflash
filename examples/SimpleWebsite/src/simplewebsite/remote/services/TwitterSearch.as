package simplewebsite.remote.services
{
	import com.adobe.serialization.json.JSONDecoder;
	
	import fj.remote.utils.FJRequest;
	
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	
	import org.robotlegs.mvcs.Actor;
	
	import simplewebsite.controller.events.SearchTermEvent;
	import simplewebsite.model.models.vo.TweetVO;
	
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
			//parse json
			var json:JSONDecoder = new JSONDecoder( event.target.data, true );
			
			var tweets:Array = new Array();
			var tweet:TweetVO;
			
			for each (var entity:* in Object( json.getValue() ).results)
			{
				tweet = new TweetVO();
				tweet.user = entity.from_user;
				tweet.message = entity.text;
				tweet.picSource = entity.profile_image_url;
				
				tweets.push( tweet );
			}
			
			
			dispatch( new SearchTermEvent( SearchTermEvent.SEARCH_COMPLETE, _lastSearchTerm, tweets ) );
		}
	}
}