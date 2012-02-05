package simplewebsite.model.models {
	
	import simplewebsite.controller.events.ChangeSceneEvent;
	import flash.display.MovieClip;
	import org.robotlegs.mvcs.Actor;

	public class ScenesModel extends Actor
	{
		private var _currentScene:MovieClip;
		
		public function get currentScene():MovieClip
		{
			return _currentScene;
		}
		
		public function set currentScene( scene:MovieClip ):void
		{
			_currentScene = scene;
			
			dispatch(new ChangeSceneEvent(ChangeSceneEvent.CHANGED, scene.name));
		}
	}
}
