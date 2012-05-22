package fj.view.events
{
	import flash.events.Event;
	
	public class FJFaderEvent extends Event
	{
		public static const CHANGED:String = "fjFaderChanged";
		
		public function FJFaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJFaderEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFaderEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}