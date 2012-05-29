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
	import fj.site.FJSiteContext;
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

	public class SimpleWebsiteContext extends FJSiteContext
	{
		
		public function SimpleWebsiteContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) {
			super(contextView, autoStartup);
		}

		override public function startup() : void
		{
			super.startup();
			
			commandMap.mapEvent(SearchTermEvent.SEARCH, SearchTermCommand);
			
			injector.mapSingletonOf(ISearchService, TwitterSearch);
			
			mediatorMap.mapView(Menu, MenuMediator);
			mediatorMap.mapView(MenuLanguages, MenuLanguagesMediator);
			
			mediatorMap.mapView(SceneOne, SceneOneMediator, FJScene);
			mediatorMap.mapView(SceneTwo, SceneTwoMediator, FJScene);
			mediatorMap.mapView(SceneThree, SceneThreeMediator, FJScene);
			
			start( new SceneOne() );
		}

	}
}
