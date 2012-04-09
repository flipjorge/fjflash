package fj.view.events
{
	import flash.events.Event;
	
	public class FJPreloadEvent extends Event
	{
		public static const OUT_COMPLETE:String = "fjPreloadOutComplete";
		
		public function FJPreloadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event 
		{ 
			return new FJPreloadEvent( type, bubbles, cancelable );
		}
		
		public override function toString():String 
		{ 
			return formatToString( "FJPreloadEvent", "type", "bubbles", "cancelable", "eventPhase" ); 
		}
		
	}
}