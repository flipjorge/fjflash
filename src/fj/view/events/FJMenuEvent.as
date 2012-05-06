package fj.view.events
{
	import flash.events.Event;
	
	public class FJMenuEvent extends Event
	{
		public static const SELECTION_CHANGED:String = "fjMenuEventSelectionChanged";
		
		public var selectionName:String;
		
		public function FJMenuEvent(type:String, selectionName:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.selectionName = selectionName;
		}
		
		override public function clone():Event
		{
			return new FJMenuEvent( type, selectionName, bubbles, cancelable );
		}
	}
}