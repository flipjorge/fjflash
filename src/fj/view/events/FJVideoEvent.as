package fj.view.events
{
	import flash.events.Event;
	
	public class FJVideoEvent extends Event
	{
		public static const STOPPED:String = "fjVideoStopped";
		
		public function FJVideoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJVideoEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJVideoEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}