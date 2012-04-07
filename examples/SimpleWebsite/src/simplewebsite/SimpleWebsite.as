package simplewebsite{
	
	import fj.view.views.FJScenesContainer;
	
	import flash.display.MovieClip;
	
	import simplewebsite.view.views.Menu;
	
	public class SimpleWebsite extends MovieClip
	{
		public var menu:Menu;
		public var scenesContainer:FJScenesContainer;
		
		private var _context:SimpleWebsiteContext;
		
		public function SimpleWebsite()
		{
			
			_context = new SimpleWebsiteContext(this);
			
		}
	}
}
