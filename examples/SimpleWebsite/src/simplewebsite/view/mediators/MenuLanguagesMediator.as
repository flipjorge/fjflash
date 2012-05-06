package simplewebsite.view.mediators
{
	import fj.site.controller.events.FJChangeLanguageEvent;
	import fj.view.events.FJMenuEvent;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import simplewebsite.view.views.MenuLanguages;
	
	public class MenuLanguagesMediator extends Mediator
	{
		[Inject]
		public var menuLanguages:MenuLanguages;
		
		override public function onRegister():void
		{
			addContextListener(FJChangeLanguageEvent.CHANGED, onLanguageChanged);
			addViewListener(FJMenuEvent.SELECTION_CHANGED, onMenuChanged);
		}
		
		override public function onRemove():void
		{
			removeContextListener(FJChangeLanguageEvent.CHANGED, onLanguageChanged);
			removeViewListener(FJMenuEvent.SELECTION_CHANGED, onMenuChanged);
		}
		
		private function onLanguageChanged(event:FJChangeLanguageEvent):void
		{
			switch( event.language ){
				case "en":
					menuLanguages.selected = "en";
					break;
				case "pt":
					menuLanguages.selected = "pt";
					break;
			}
		}
		
		private function onMenuChanged(event:FJMenuEvent):void
		{
			dispatch( new FJChangeLanguageEvent( FJChangeLanguageEvent.START_CHANGING, event.selectionName ) );
		}
		
	}
}