package simplewebsite.view.mediators {
	
	import fj.view.views.FJScene;
	import flash.utils.getDefinitionByName;
	import fj.controller.events.FJChangeSceneEvent;
	import flash.display.MovieClip;
	
	import simplewebsite.view.views.Menu;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;

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

		private function onMenuButtonClick(e:MouseEvent) : void {
			
			var sceneName:String = MovieClip( e.currentTarget ).name;
			var sceneClass:Class = getDefinitionByName(sceneName) as Class;
			var scene:FJScene = new sceneClass() as FJScene;
			
			dispatch(new FJChangeSceneEvent(FJChangeSceneEvent.START_CHANGING, scene));
			
		}

	}
}
