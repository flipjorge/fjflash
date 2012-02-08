package fj.view.mediators {
	
	import fj.controller.events.FJRemoveSceneEvent;
	import fj.controller.events.FJAddSceneEvent;
	import fj.view.views.FJScenesContainer;
	import org.robotlegs.mvcs.Mediator;

	public class FJScenesContainerMediator extends Mediator
	{
		[Inject]
		public var scenesContainerView:FJScenesContainer;

		override public function onRegister() : void {
			
			addContextListener(FJAddSceneEvent.ADD, onAddScene);
			addContextListener(FJRemoveSceneEvent.REMOVE, onRemoveScene);
			
		}

		private function onAddScene(e:FJAddSceneEvent) : void {
			
			scenesContainerView.addScene(e.scene);
			
		}
		
		private function onRemoveScene(e:FJRemoveSceneEvent) : void {
			
			scenesContainerView.removeScene(e.scene);
			
		}

	}
}
