package simplewebsite {
	
	import fj.view.mediators.FJSceneMediator;
	import fj.view.views.FJScene;
	import fj.view.mediators.FJScenesContainerMediator;
	import fj.view.views.FJScenesContainer;
	import fj.model.models.FJScenesModel;
	import fj.controller.commands.FJFinishChangingScene;
	import fj.controller.events.FJSceneOutEvent;
	import fj.controller.commands.FJStartChangingScene;
	import fj.controller.events.FJChangeSceneEvent;
	import simplewebsite.view.mediators.MenuMediator;
	import simplewebsite.view.views.Menu;
	import org.robotlegs.mvcs.Context;
	import flash.display.DisplayObjectContainer;

	public class SimpleWebsiteContext extends Context
	{
		
		public function SimpleWebsiteContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void
		{
			commandMap.mapEvent(FJChangeSceneEvent.START_CHANGING, FJStartChangingScene);
			commandMap.mapEvent(FJSceneOutEvent.OUT_COMPLETE, FJFinishChangingScene);
			
			injector.mapSingleton(FJScenesModel);
			
			mediatorMap.mapView(Menu, MenuMediator);
			mediatorMap.mapView(FJScenesContainer, FJScenesContainerMediator);
			//mediatorMap.mapView(FJScene, FJSceneMediator);
			
			mediatorMap.mapView(SceneOne, FJSceneMediator, FJScene);
			mediatorMap.mapView(SceneTwo, FJSceneMediator, FJScene);
			mediatorMap.mapView(SceneThree, FJSceneMediator, FJScene);
			
			for (var i : int = 0; i < contextView.numChildren; i++) {
				mediatorMap.createMediator(contextView.getChildAt(i));
			}
			
			dispatchEvent(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, new SceneOne() ));
		}

	}
}
