package fj.facebook.controller.events
{
	import fj.facebook.model.vo.FJFBStreamPublish;
	
	import flash.events.Event;
	
	public class FJFBStreamPublishEvent extends Event
	{
		public static const PUBLISH:String = "fjfbStreamPublish";
		
		public var streamPublish:FJFBStreamPublish;
		
		public function FJFBStreamPublishEvent(type:String, streamPublish:FJFBStreamPublish, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.streamPublish = streamPublish;
		}
		override public function clone():Event
		{
			return new FJFBStreamPublishEvent(type, streamPublish, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBStreamPublish", "type", "streamPublish", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}