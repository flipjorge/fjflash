package simplewebsite.controller.events {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class AddSceneEvent extends Event
	{
		public static const ADD:String = "addSceneAdd";
		
		public var scene:MovieClip;
		
		public function AddSceneEvent(type : String, scene:MovieClip, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.scene = scene;
		}
		
		
		override public function clone() : Event {
			return new AddSceneEvent(type, scene, bubbles, cancelable);
		}
	}
}
