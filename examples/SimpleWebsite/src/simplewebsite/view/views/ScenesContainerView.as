package simplewebsite.view.views {
	import flash.display.MovieClip;

	public class ScenesContainerView extends MovieClip
	{
		public function ScenesContainerView()
		{
			
		}
		
		public function addScene( scene:MovieClip ):void
		{
			addChild( scene );
		}
		
		public function removeScene( scene:MovieClip ):void
		{
			removeChild( scene );
		}
	}
}
