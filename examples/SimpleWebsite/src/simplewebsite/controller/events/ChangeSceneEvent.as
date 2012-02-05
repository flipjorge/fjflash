package simplewebsite.controller.events {
	import flash.events.Event;

	public class ChangeSceneEvent extends Event
	{
		public static const START_CHANGE:String = "changeSceneStartChange";
		public static const CHANGED:String = "changeSceneChanged";
		
		public var sceneName:String;
		
		public function ChangeSceneEvent(type : String, sceneName:String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.sceneName = sceneName;
		}
		
		override public function clone() : Event {
			return new ChangeSceneEvent(type, sceneName, bubbles, cancelable);
		}
	}
}
