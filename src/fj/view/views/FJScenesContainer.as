package fj.view.views {
	
	import flash.display.MovieClip;

	public class FJScenesContainer extends MovieClip
	{	
		public function addScene( scene:FJScene ):void
		{
			addChild( scene );
		}
		
		public function removeScene( scene:FJScene ):void
		{
			removeChild( scene );
		}
	}
}
