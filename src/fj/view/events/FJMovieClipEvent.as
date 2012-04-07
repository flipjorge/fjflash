package fj.view.events {
	import flash.events.Event;

	public class FJMovieClipEvent extends Event
	{
		public static const ANIM_COMPLETE:String = "fjMovieClipAnimComplete";
		
		public function FJMovieClipEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			return new FJMovieClipEvent(type);
		}

	}
}