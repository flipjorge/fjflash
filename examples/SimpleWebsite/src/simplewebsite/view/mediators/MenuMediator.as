package simplewebsite.view.mediators {
	
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.view.views.FJScene;
	import fj.view.events.FJMenuEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.mvcs.Mediator;
	
	import simplewebsite.view.views.Menu;
	import simplewebsite.view.views.SceneOne;
	import simplewebsite.view.views.SceneThree;
	import simplewebsite.view.views.SceneTwo;

	public class MenuMediator extends Mediator
	{
		[Inject]
		public var menuView:Menu;

		override public function onRegister() : void
		{
			addContextListener(FJChangeSceneEvent.CHANGED, onSceneChanged);
			addViewListener(FJMenuEvent.SELECTION_CHANGED, onMenuChanged);
		}
		
		override public function onRemove() : void
		{
			removeContextListener(FJChangeSceneEvent.CHANGED, onSceneChanged);
			removeViewListener(FJMenuEvent.SELECTION_CHANGED, onMenuChanged);
		}

		private function onSceneChanged(event:FJChangeSceneEvent):void
		{
			switch( getDefinitionByName( getQualifiedClassName(event.scene) ) )
			{
				case SceneOne:
				{
					menuView.selected = "SceneOne";
					break;
				}
					
				case SceneTwo:
				{
					menuView.selected = "SceneTwo";
					break;
				}
					
				case SceneThree:
				{
					menuView.selected = "SceneThree";
					break;
				}
				
			} 
		}
		
		private function onMenuChanged(event:FJMenuEvent):void
		{
			switch(event.selectionName)
			{
				case menuView.SceneOne.name:
				{
					dispatch(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, new SceneOne()));
					break;
				}
				
				case menuView.SceneTwo.name:
				{
					dispatch(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, new SceneTwo()));
					break;
				}
				
				case menuView.SceneThree.name:
				{
					dispatch(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, new SceneThree()));
					break;
				}
			}
		}

	}
}
