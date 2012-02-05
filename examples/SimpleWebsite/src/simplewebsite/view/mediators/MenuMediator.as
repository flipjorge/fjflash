package simplewebsite.view.mediators {
	
	import flash.display.MovieClip;
	import simplewebsite.controller.events.ChangeSceneEvent;
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
			
			dispatch(new ChangeSceneEvent(ChangeSceneEvent.START_CHANGE, sceneName));
			
		}

	}
}
