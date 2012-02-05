package simplewebsite {
	
	import simplewebsite.view.mediators.ScenesContainerMediator;
	import simplewebsite.view.views.ScenesContainerView;
	import simplewebsite.view.mediators.MenuMediator;
	import simplewebsite.view.views.Menu;
	import simplewebsite.model.models.ScenesModel;
	import simplewebsite.controller.commands.ChangeSceneCommand;
	import simplewebsite.controller.events.ChangeSceneEvent;
	import org.robotlegs.mvcs.Context;
	import flash.display.DisplayObjectContainer;

	public class SimpleWebsiteContext extends Context
	{
		
		public function SimpleWebsiteContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void
		{
			commandMap.mapEvent(ChangeSceneEvent.START_CHANGE, ChangeSceneCommand);
			
			injector.mapSingleton(ScenesModel);
			
			mediatorMap.mapView(Menu, MenuMediator);
			mediatorMap.mapView(ScenesContainerView, ScenesContainerMediator);
			
			for (var i : int = 0; i < contextView.numChildren; i++) {
				mediatorMap.createMediator(contextView.getChildAt(i));
			}
			
			dispatchEvent(new ChangeSceneEvent(ChangeSceneEvent.START_CHANGE, "SceneOne"));
		}

	}
}
