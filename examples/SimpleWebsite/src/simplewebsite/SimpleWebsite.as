package simplewebsite{
	
	import simplewebsite.view.views.ScenesContainerView;
	import simplewebsite.view.views.Menu;
	import flash.display.MovieClip;
	
	public class SimpleWebsite extends MovieClip
	{
		public var menu:Menu;
		public var scenesContainer:ScenesContainerView;
		
		private var _context:SimpleWebsiteContext;
		
		public function SimpleWebsite()
		{
			
			_context = new SimpleWebsiteContext(this);
			
		}
	}
}
