package fj.site.controller.events
{
	import flash.events.Event;
	
	public class FJChangeLanguageEvent extends Event
	{
		public static const START_CHANGING:String = "fjChangeLanguageStartChanging";
		public static const CHANGED:String = "fjChangeLanguageChanged";
		
		public var language:String;
		
		public function FJChangeLanguageEvent(type:String, language:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.language = language;
		}
		
		override public function clone() : Event {
			return new FJChangeLanguageEvent(type, language, bubbles, cancelable);
		}
	}
}