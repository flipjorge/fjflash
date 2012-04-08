package fj.site.controller.events {
	
	
	import fj.site.view.views.FJScene;
	
	import flash.events.Event;

	public class FJAddSceneEvent extends Event
	{
		public static const ADD:String = "fjAddSceneAdd";
		
		public var scene:FJScene;
		
		public function FJAddSceneEvent(type : String, scene:FJScene, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.scene = scene;
		}
		
		override public function clone() : Event {
			return new FJAddSceneEvent(type, scene, bubbles, cancelable);
		}
	}
}
