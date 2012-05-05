package simplewebsite.view.mediators
{
	import fj.site.controller.events.FJChangeLanguageEvent;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import simplewebsite.view.views.MenuLanguages;
	
	public class MenuLanguagesMediator extends Mediator
	{
		[Inject]
		public var menuLanguages:MenuLanguages;
		
		override public function onRegister():void
		{
			menuLanguages.en.addEventListener(MouseEvent.CLICK, onLanguageClick);
			menuLanguages.pt.addEventListener(MouseEvent.CLICK, onLanguageClick);
		}
		
		override public function onRemove():void
		{
			menuLanguages.en.removeEventListener(MouseEvent.CLICK, onLanguageClick);
			menuLanguages.pt.removeEventListener(MouseEvent.CLICK, onLanguageClick);
		}
		
		protected function onLanguageClick(event:MouseEvent):void
		{
			dispatch( new FJChangeLanguageEvent( FJChangeLanguageEvent.START_CHANGING, event.currentTarget.name ) );
		}
	}
}