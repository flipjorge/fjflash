package fj.view.events {
	import flash.events.Event;

	public class FJSceneEvent extends Event
	{
		public static const IN_COMPLETE:String = "fjSceneInComplete";
		public static const OUT_START:String = "fjSceneOutStart";
		public static const OUT_COMPLETE:String = "fjSceneOutComplete";
		
		public function FJSceneEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
			
		override public function clone() : Event {
			return new FJSceneEvent(type);
		}
	}
}
