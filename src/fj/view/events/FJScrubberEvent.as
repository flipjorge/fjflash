package fj.view.events
{
	import flash.events.Event;
	
	public class FJScrubberEvent extends Event
	{
		public static const START_SCRUBBING:String = "fjScrubberStartScrubbing";
		public static const SCRUBBING_CHANGE:String = "fjScrubberScrubbingChange";
		public static const END_SCRUBBING:String = "fjScrubberEndScrubbing";
		
		public function FJScrubberEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJScrubberEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJScrubberEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}