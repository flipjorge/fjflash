package fj.site.view.views
{
	import fj.site.view.events.FJSceneEvent;
	import fj.view.events.FJMovieClipEvent;
	import fj.view.views.FJMovieClip;
	
	import flash.events.Event;
	
	public class FJScene extends FJMovieClip implements IScene
	{
		
		public function out():void
		{
			if ( hasEventListener( FJMovieClipEvent.ANIM_COMPLETE ) ) {
				removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _inAnimComplete );
			}
			
			dispatchEvent( new FJSceneEvent(FJSceneEvent.OUT_START) );
			
			if ( checkLabelExists( "out:start" ) && checkLabelExists( "out:end" ) ) {
				gotoAndPlayUntil( "out:start", "out:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
			} else {
				dispatchEvent( new FJSceneEvent(FJSceneEvent.OUT_COMPLETE) );
			}
		}
		
		
		//
		override protected function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage(e);
			
			if ( checkLabelExists( "in:start" ) && checkLabelExists( "in:end" ) ) {
				gotoAndPlayUntil( "in:start", "in:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _inAnimComplete );
			} else {
				dispatchEvent( new FJSceneEvent(FJSceneEvent.IN_COMPLETE) );
			}
		}
		
		
		//
		private function _inAnimComplete(e:FJMovieClipEvent):void 
		{
			removeEventListener(FJMovieClipEvent.ANIM_COMPLETE, _inAnimComplete);
			dispatchEvent( new FJSceneEvent(FJSceneEvent.IN_COMPLETE) );
		}
		private function _outAnimComplete(e:FJMovieClipEvent):void 
		{
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
			dispatchEvent( new FJSceneEvent(FJSceneEvent.OUT_COMPLETE) );
		}
		
	}
}