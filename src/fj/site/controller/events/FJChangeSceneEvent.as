package fj.site.controller.events {
	
	import fj.site.view.views.FJScene;
	
	import flash.events.Event;

	public class FJChangeSceneEvent extends Event
	{
		public static const START_CHANGING:String = "fjChangeSceneStartChanging";
		public static const CHANGED:String = "fjChangeSceneChanged";
		
		public var scene:FJScene;
		
		public function FJChangeSceneEvent(type : String, scene:FJScene, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.scene = scene;
		}
		
		override public function clone() : Event {
			return new FJChangeSceneEvent(type, scene, bubbles, cancelable);
		}
	}
}
