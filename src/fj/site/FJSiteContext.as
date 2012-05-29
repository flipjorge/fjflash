package fj.site
{
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
	
	public class FJSiteContext extends Context
	{
		public function FJSiteContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			commandMap.mapEvent(FJChangeSceneEvent.START_CHANGING, FJStartChangingScene);
			commandMap.mapEvent(FJSceneOutEvent.OUT_COMPLETE, FJFinishChangingScene);
			commandMap.mapEvent(FJChangeLanguageEvent.START_CHANGING, FJStartChangingLanguage);
			
			commandMap.mapEvent(FJFBInitEvent.INIT, FJFBInitCommand);
			commandMap.mapEvent(FJFBLoginEvent.LOGIN, FJFBLoginCommand);
			commandMap.mapEvent(FJFBGetFriendsEvent.GET, FJFBGetFriendsCommand);
			commandMap.mapEvent(FJFBStreamPublishEvent.PUBLISH, FJFBStreamPublishCommand);
			commandMap.mapEvent(FJFBPostPhotoEvent.POST_PHOTO, FJFBPostPhotoCommand);
			
			injector.mapSingleton(FJScenesModel);
			injector.mapSingleton(FJLanguageModel);
			
			mediatorMap.mapView(FJScenesContainer, FJScenesContainerMediator);
		}
		
		protected function start( scene:FJScene, language:String = "en" ):void
		{
			for (var i : int = 0; i < contextView.numChildren; i++) {
				mediatorMap.createMediator(contextView.getChildAt(i));
			}
			
			dispatchEvent(new FJChangeLanguageEvent(FJChangeLanguageEvent.START_CHANGING, language) );
			dispatchEvent(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, scene ));
		}
	}
}