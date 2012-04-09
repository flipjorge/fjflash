package simplewebsite{
	
	
	import fj.site.view.views.FJScenesContainer;
	import fj.view.views.FJMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import simplewebsite.view.views.Menu;
	
	public class SimpleWebsite extends FJMovieClip
	{
		public var menu:Menu;
		public var scenesContainer:FJScenesContainer;
		
		private var _context:SimpleWebsiteContext;
		
		override protected function onAddedToStage(e:Event):void
		{
			_context = new SimpleWebsiteContext(this);
		}
	}
}
