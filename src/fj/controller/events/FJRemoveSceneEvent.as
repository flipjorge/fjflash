package fj.controller.events {
	
	import fj.view.views.FJScene;
	import flash.events.Event;

	public class FJRemoveSceneEvent extends Event
	{
		public static const REMOVE:String = "fjRemoveSceneRemove";
		
		public var scene:FJScene;
		
		public function FJRemoveSceneEvent(type : String, scene:FJScene, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.scene = scene;
		}

		override public function clone() : Event {
			return new FJRemoveSceneEvent(type, scene, bubbles, cancelable);
		}

	}
}
