package simplewebsite.view.mediators {
	import simplewebsite.controller.events.RemoveSceneEvent;
	import simplewebsite.controller.events.AddSceneEvent;
	import simplewebsite.view.views.ScenesContainerView;
	import org.robotlegs.mvcs.Mediator;

	public class ScenesContainerMediator extends Mediator
	{
		[Inject]
		public var scenesContainerView:ScenesContainerView;

		override public function onRegister() : void {
			
			addContextListener(AddSceneEvent.ADD, onAddScene);
			addContextListener(RemoveSceneEvent.REMOVE, onRemoveScene);
			
		}

		private function onAddScene(e:AddSceneEvent) : void {
			
			scenesContainerView.addScene(e.scene);
			
		}
		
		private function onRemoveScene(e:RemoveSceneEvent) : void {
			
			scenesContainerView.removeScene(e.scene);
			
		}

	}
}
