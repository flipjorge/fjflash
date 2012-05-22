package fj.view.events
{
	import flash.events.Event;
	
	public class FJImageEvent extends Event
	{
		public static const LOADED:String = "fjImageLoaded";
		
		public function FJImageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJImageEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJImageEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}