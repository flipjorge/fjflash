package simplewebsite {
	
	import fj.facebook.controller.commands.FJFBGetFriendsCommand;
	import fj.facebook.controller.commands.FJFBInitCommand;
	import fj.facebook.controller.commands.FJFBLoginCommand;
	import fj.facebook.controller.commands.FJFBPostPhotoCommand;
	import fj.facebook.controller.commands.FJFBStreamPublishCommand;
	import fj.facebook.controller.events.FJFBGetFriendsEvent;
	import fj.facebook.controller.events.FJFBInitEvent;
	import fj.facebook.controller.events.FJFBLoginEvent;
	import fj.facebook.controller.events.FJFBPostPhotoEvent;
	import fj.facebook.controller.events.FJFBStreamPublishEvent;
	import fj.site.controller.commands.FJFinishChangingScene;
	import fj.site.controller.commands.FJStartChangingLanguage;
	import fj.site.controller.commands.FJStartChangingScene;
	import fj.site.controller.events.FJChangeLanguageEvent;
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.controller.events.FJSceneOutEvent;
	import fj.site.model.models.FJLanguageModel;
	import fj.site.model.models.FJScenesModel;
	import fj.site.view.mediators.FJScenesContainerMediator;
	import fj.site.view.views.FJScene;
	import fj.site.view.views.FJScenesContainer;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import simplewebsite.controller.commands.SearchTermCommand;
	import simplewebsite.controller.events.SearchTermEvent;
	import simplewebsite.remote.services.ISearchService;
	import simplewebsite.remote.services.TwitterSearch;
	import simplewebsite.view.mediators.MenuLanguagesMediator;
	import simplewebsite.view.mediators.MenuMediator;
	import simplewebsite.view.mediators.SceneOneMediator;
	import simplewebsite.view.mediators.SceneThreeMediator;
	import simplewebsite.view.mediators.SceneTwoMediator;
	import simplewebsite.view.views.Menu;
	import simplewebsite.view.views.MenuLanguages;
	import simplewebsite.view.views.SceneOne;
	import simplewebsite.view.views.SceneThree;
	import simplewebsite.view.views.SceneTwo;

	public class SimpleWebsiteContext extends Context
	{
		
		public function SimpleWebsiteContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void
		{
			commandMap.mapEvent(FJChangeSceneEvent.START_CHANGING, FJStartChangingScene);
			commandMap.mapEvent(FJSceneOutEvent.OUT_COMPLETE, FJFinishChangingScene);
			commandMap.mapEvent(FJChangeLanguageEvent.START_CHANGING, FJStartChangingLanguage);
			
			commandMap.mapEvent(FJFBInitEvent.INIT, FJFBInitCommand);
			commandMap.mapEvent(FJFBLoginEvent.LOGIN, FJFBLoginCommand);
			commandMap.mapEvent(FJFBGetFriendsEvent.GET, FJFBGetFriendsCommand);
			commandMap.mapEvent(FJFBStreamPublishEvent.PUBLISH, FJFBStreamPublishCommand);
			commandMap.mapEvent(FJFBPostPhotoEvent.POST_PHOTO, FJFBPostPhotoCommand);
			
			commandMap.mapEvent(SearchTermEvent.SEARCH, SearchTermCommand);
			
			injector.mapSingleton(FJScenesModel);
			injector.mapSingleton(FJLanguageModel);
			injector.mapSingletonOf(ISearchService, TwitterSearch);
			
			mediatorMap.mapView(Menu, MenuMediator);
			mediatorMap.mapView(MenuLanguages, MenuLanguagesMediator);
			mediatorMap.mapView(FJScenesContainer, FJScenesContainerMediator);
			
			mediatorMap.mapView(SceneOne, SceneOneMediator, FJScene);
			mediatorMap.mapView(SceneTwo, SceneTwoMediator, FJScene);
			mediatorMap.mapView(SceneThree, SceneThreeMediator, FJScene);
			
			for (var i : int = 0; i < contextView.numChildren; i++) {
				mediatorMap.createMediator(contextView.getChildAt(i));
			}
			
			dispatchEvent(new FJChangeLanguageEvent(FJChangeLanguageEvent.START_CHANGING, "en") );
			dispatchEvent(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, new SceneOne() ));
		}

	}
}
