package fj.site.controller.commands
{
	import fj.site.controller.events.FJChangeLanguageEvent;
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.model.models.FJLanguageModel;
	import fj.site.model.models.FJScenesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class FJStartChangingLanguage extends Command
	{
		[Inject]
		public var event:FJChangeLanguageEvent;
		
		[Inject]
		public var languageModel:FJLanguageModel;
		
		[Inject]
		public var scenesModel:FJScenesModel;
		
		override public function execute():void
		{
			languageModel.currentLanguage = event.language;
			
			if( scenesModel.currentScene ){
				dispatch( new FJChangeSceneEvent( FJChangeSceneEvent.START_CHANGING, scenesModel.currentScene ) );
			}
		}
	}
}