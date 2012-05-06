package simplewebsite.view.mediators
{
	import fj.site.view.mediators.FJSceneMediator;
	
	import flash.events.Event;
	
	public class SceneTwoMediator extends FJSceneMediator
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
			//trace(languageModel.currentLanguage);
		}
	}
}