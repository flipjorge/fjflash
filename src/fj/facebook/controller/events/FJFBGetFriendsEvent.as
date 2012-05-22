package fj.facebook.controller.events
{
	import flash.events.Event;
	
	public class FJFBGetFriendsEvent extends Event
	{
		public static const GET:String = "fjFBGetFriendsGet";
		
		public var fields:Array;
		
		public function FJFBGetFriendsEvent(type:String, fields:Array, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.fields = fields;
		}
		override public function clone():Event
		{
			return new FJFBGetFriendsEvent(type, fields, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBGetFriendsEvent", "type", "fields", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}