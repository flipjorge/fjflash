package fj.site.view.mediators {
	
	import fj.site.controller.events.FJSceneOutEvent;
	import fj.site.view.events.FJSceneEvent;
	import fj.site.view.views.FJScene;
	
	import org.robotlegs.mvcs.Mediator;

	public class FJSceneMediator extends Mediator {
		
		[Inject]
		public var sceneView:FJScene;
		
		override public function onRegister():void
		{
			addContextListener(FJSceneOutEvent.OUT, onSceneOut);
			
			addViewListener(FJSceneEvent.IN_COMPLETE, onInComplete);
			addViewListener(FJSceneEvent.OUT_START, onOutStart);
			addViewListener(FJSceneEvent.OUT_COMPLETE, onOutComplete);
		}

		private function onSceneOut(e:FJSceneOutEvent):void
		{
			sceneView.out();
		}
		
		//
		protected function onInComplete( e:FJSceneEvent ):void{}
		protected function onOutStart( e:FJSceneEvent ):void{}
		
		protected function onOutComplete( e:FJSceneEvent ):void
		{
			dispatch( new FJSceneOutEvent( FJSceneOutEvent.OUT_COMPLETE, sceneView ) );
		}

	}
}
