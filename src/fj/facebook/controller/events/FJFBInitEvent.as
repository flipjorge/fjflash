package fj.facebook.controller.events
{
	import flash.events.Event;
	
	public class FJFBInitEvent extends Event
	{
		public static const INIT:String = "fjfbInitInit";
		public static const INITIALIZED:String = "fjfbInitInitialized";
		public static const FAILED:String = "fjfbInitError";
		
		public var appID:String;
		public var error:Object;
		
		public function FJFBInitEvent(type:String, appID:String = null, error:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.appID = appID;
			this.error = error;
		}
		override public function clone():Event
		{
			return new FJFBInitEvent(type, appID, error, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBInitEvent", "type", "appID", "error", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}