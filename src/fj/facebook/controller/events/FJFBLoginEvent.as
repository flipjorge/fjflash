package fj.facebook.controller.events
{
	import flash.events.Event;
	
	public class FJFBLoginEvent extends Event
	{
		public static const LOGIN:String = "fjFBLoginLogin";
		
		public var appID:String;
		
		public function FJFBLoginEvent(type:String, appID:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.appID = appID;
		}
		override public function clone():Event
		{
			return new FJFBLoginEvent(type, appID, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBLoginEvent", "type", "appID", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}