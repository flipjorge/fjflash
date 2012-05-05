package fj.site.view.mediators {
	
	import fj.site.controller.events.FJSceneOutEvent;
	import fj.site.model.models.FJLanguageModel;
	import fj.site.view.events.FJSceneEvent;
	import fj.site.view.views.FJScene;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	public class FJSceneMediator extends Mediator {
		
		[Inject]
		public var sceneView:FJScene;
		
		[Inject]
		public var languageModel:FJLanguageModel;
		
		override public function onRegister():void
		{
			addContextListener(FJSceneOutEvent.OUT, onSceneOut);
			
			addViewListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addViewListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addViewListener(FJSceneEvent.IN_COMPLETE, onInComplete);
			addViewListener(FJSceneEvent.OUT_START, onOutStart);
			addViewListener(FJSceneEvent.OUT_COMPLETE, onOutComplete);
		}

		private function onSceneOut(e:FJSceneOutEvent):void
		{
			sceneView.out();
		}
		
		//
		protected function onAddedToStage( event:Event ):void{}
		protected function onRemovedFromStage( event:Event ):void{}
		protected function onInComplete( event:FJSceneEvent ):void{}
		protected function onOutStart( event:FJSceneEvent ):void{}
		
		protected function onOutComplete( event:FJSceneEvent ):void
		{
			dispatch( new FJSceneOutEvent( FJSceneOutEvent.OUT_COMPLETE, sceneView ) );
		}

	}
}
