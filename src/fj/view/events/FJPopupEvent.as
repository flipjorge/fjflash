package fj.view.events
{
	import flash.events.Event;
	
	public class FJPopupEvent extends Event
	{
		public static const OPENED:String = "fjPopupOpened";
		public static const CLOSED:String = "fjPopupClosed";
		
		public function FJPopupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJPopupEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJPopupEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}