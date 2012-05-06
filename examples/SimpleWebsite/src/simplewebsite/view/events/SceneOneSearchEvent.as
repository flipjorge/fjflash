package simplewebsite.view.events
{
	import flash.events.Event;
	
	public class SceneOneSearchEvent extends Event
	{
		public static const SEARCH_CLICK:String = "sceneOneSearchClick";
		
		public var searchTerm:String;
		
		public function SceneOneSearchEvent(type:String, searchTerm:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.searchTerm = searchTerm;
		}
		override public function clone():Event
		{
			return new SceneOneSearchEvent(type, searchTerm, bubbles, cancelable);
		}
	}
}