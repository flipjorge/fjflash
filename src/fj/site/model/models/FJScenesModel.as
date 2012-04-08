package fj.site.model.models {
	
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.view.views.FJScene;
	
	import org.robotlegs.mvcs.Actor;

	public class FJScenesModel extends Actor
	{
		private var _currentScene:FJScene;
		private var _nextScene:FJScene;
		
		public function get currentScene():FJScene
		{
			return _currentScene;
		}
		
		public function set currentScene( scene:FJScene ):void
		{
			_currentScene = scene;
			
			dispatch( new FJChangeSceneEvent(FJChangeSceneEvent.CHANGED, _currentScene) );
		}
		
		public function get nextScene():FJScene
		{
			return _nextScene;
		}
		
		public function set nextScene( scene:FJScene ):void
		{
			_nextScene = scene;
		}
	}
}
