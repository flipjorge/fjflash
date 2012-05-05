package simplewebsite.view.mediators
{
	import fj.site.model.models.FJLanguageModel;
	import fj.site.view.mediators.FJSceneMediator;
	
	import flash.events.Event;
	
	public class SceneOneMediator extends FJSceneMediator
	{
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		override protected function onAddedToStage(event:Event):void
		{
			trace(languageModel.currentLanguage);
		}
	}
}