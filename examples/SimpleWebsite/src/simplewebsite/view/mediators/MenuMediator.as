package simplewebsite.view.mediators {
	
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.view.views.FJScene;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import org.robotlegs.mvcs.Mediator;
	
	import simplewebsite.view.views.Menu;
	import simplewebsite.view.views.SceneOne;

	public class MenuMediator extends Mediator
	{
		[Inject]
		public var menuView:Menu;
		

		override public function onRegister() : void {
			
			menuView.SceneOne.addEventListener(MouseEvent.CLICK, onMenuButtonClick);
			menuView.SceneTwo.addEventListener(MouseEvent.CLICK, onMenuButtonClick);
			menuView.SceneThree.addEventListener(MouseEvent.CLICK, onMenuButtonClick);
			
		}
		
		override public function onRemove() : void {
			
			menuView.SceneOne.removeEventListener(MouseEvent.CLICK, onMenuButtonClick);
			menuView.SceneTwo.removeEventListener(MouseEvent.CLICK, onMenuButtonClick);
			menuView.SceneThree.removeEventListener(MouseEvent.CLICK, onMenuButtonClick);
			
		}

		private function onMenuButtonClick(event:MouseEvent) : void {
			
			switch( event.currentTarget ){
				case menuView.SceneOne:
					dispatch(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, new SceneOne()));
					break;
				default:
					var sceneName:String = MovieClip( event.currentTarget ).name;
					var sceneClass:Class = getDefinitionByName(sceneName) as Class;
					var scene:FJScene = new sceneClass() as FJScene;
					
					dispatch(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, scene));
					break;
			}
			
		}

	}
}
