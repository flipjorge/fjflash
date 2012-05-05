package fj.site.model.models
{
	import fj.site.controller.events.FJChangeLanguageEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FJLanguageModel extends Actor
	{
		private var _currentLanguage:String;
		
		public function get currentLanguage():String
		{
			return _currentLanguage;
		}
		
		public function set currentLanguage( language:String ):void
		{
			_currentLanguage = language;
			
			dispatch( new FJChangeLanguageEvent( FJChangeLanguageEvent.CHANGED, _currentLanguage ) );
		}
		
	}
}