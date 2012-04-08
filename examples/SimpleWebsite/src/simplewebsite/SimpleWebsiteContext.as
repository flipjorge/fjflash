package simplewebsite {
	
	import fj.site.controller.commands.FJFinishChangingScene;
	import fj.site.controller.commands.FJStartChangingScene;
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.controller.events.FJSceneOutEvent;
	import fj.site.model.models.FJScenesModel;
	import fj.site.view.mediators.FJSceneMediator;
	import fj.site.view.mediators.FJScenesContainerMediator;
	import fj.site.view.views.FJScene;
	import fj.site.view.views.FJScenesContainer;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import simplewebsite.view.mediators.MenuMediator;
	import simplewebsite.view.views.Menu;

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
