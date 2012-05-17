package fj.view.events
{
	import flash.events.Event;
	
	public class FJItemEvent extends Event
	{
		public static const LOADED:String = "fjItemLoaded";
		public static const CLICKED:String = "fjItemClicked";
		
		public var item:*;
		
		public function FJItemEvent(type:String, item:*, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.item = item;
		}
		override public function clone():Event
		{
			return new FJItemEvent(type, item, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJItemEvent", "type", "item", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}