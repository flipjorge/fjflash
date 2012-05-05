package fj.site.model.models
{
	import fj.site.controller.events.FJChangeLanguageEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FJLanguageModel extends Actor
	{
		private var _language:String;
		
		public function get currentLanguage():String
		{
			return _language;
		}
		
		public function set currentLanguage( lang:String ):void
		{
			_language = lang;
			
			dispatch( new FJChangeLanguageEvent( FJChangeLanguageEvent.CHANGED, _language ) );
		}
		
	}
}