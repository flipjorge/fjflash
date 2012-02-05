package simplewebsite.controller.events {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class RemoveSceneEvent extends Event
	{
		public static const REMOVE:String = "removeSceneRemove";
		
		public var scene:MovieClip;
		
		public function RemoveSceneEvent(type : String, scene:MovieClip, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.scene = scene;
		}

		override public function clone() : Event {
			return new RemoveSceneEvent(type, scene, bubbles, cancelable);
		}

	}
}
