package fj.facebook.controller.events
{
	import flash.events.Event;
	
	public class FJFBLoginEvent extends Event
	{
		public static const LOGIN:String = "fjFBLoginLogin";
		
		public function FJFBLoginEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJFBLoginEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBLoginEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}