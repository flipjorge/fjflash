package fj.facebook.controller.events
{
	import fj.facebook.model.vo.FJFBUser;
	
	import flash.events.Event;
	
	public class FJFBChangeUserEvent extends Event
	{
		public static const CHANGED:String = "fjFBChangeUserChanged";
		
		public var user:FJFBUser;
		
		public function FJFBChangeUserEvent(type:String, user:FJFBUser, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.user = user;
		}
		override public function clone():Event
		{
			return new FJFBChangeUserEvent(type, user, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBChangeUserEvent", "type", "user", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}