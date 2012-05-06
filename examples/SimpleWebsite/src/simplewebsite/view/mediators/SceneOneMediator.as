package simplewebsite.view.mediators
{
	import fj.site.view.mediators.FJSceneMediator;
	
	import simplewebsite.controller.events.SearchTermEvent;
	import simplewebsite.view.events.SceneOneSearchEvent;
	import simplewebsite.view.views.SceneOne;
	
	public class SceneOneMediator extends FJSceneMediator
	{
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( SceneOneSearchEvent.SEARCH_CLICK, onSearchClick);
			addContextListener( SearchTermEvent.SEARCH_COMPLETE, onSearchComplete );
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			removeViewListener( SceneOneSearchEvent.SEARCH_CLICK, onSearchClick);
			removeContextListener( SearchTermEvent.SEARCH_COMPLETE, onSearchComplete );
		}
		
		private function onSearchClick( event:SceneOneSearchEvent ):void
		{
			SceneOne( sceneView ).busy = true;
			
			dispatch( new SearchTermEvent( SearchTermEvent.SEARCH, event.searchTerm ) );
		}
		
		private function onSearchComplete( event:SearchTermEvent ):void
		{
			SceneOne( sceneView ).busy = false;
			
			trace(event.searchTerm, event.results);
		}
	}
}