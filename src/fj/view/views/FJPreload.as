package fj.view.views
{
	import fj.view.events.FJMovieClipEvent;
	import fj.view.events.FJPreloadEvent;
	
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class FJPreload extends FJMovieClip
	{
		public var art:MovieClip;
		public var progress:TextField;
		
		private var _percent:Number = 0;
		
		public function FJPreload()
		{
			art = searchDisplayObjectByInstanceName( "art", MovieClip, this );
			progress = searchDisplayObjectByInstanceName( "progress", TextField, this );
			show();
		}
		
		public function get value():Number { return _percent; }
		public function set value( p:Number ):void 
		{
			_percent = p;
			if ( art ) art.gotoAndStop( Math.round( _percent * art.totalFrames ) );
			if ( progress ) progress.text = Math.round( _percent * 100 ) + "%";
		}
		
		public function show():void
		{
			visible = true;
			if ( checkLabelExists( "show:start" ) && checkLabelExists( "show:end" ) ) {
				gotoAndPlayUntil( "show:start" , "show:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _showAnimComplete );
			}
		}
		
		public function hide():void
		{
			if ( checkLabelExists( "hide:start" ) && checkLabelExists( "hide:end" ) ) {
				gotoAndPlayUntil( "hide:start" , "hide:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _hideAnimComplete);
			} else {
				visible = false;
				dispatchEvent( new FJPreloadEvent( FJPreloadEvent.OUT_COMPLETE ) );
			}
		}
		
		private function _showAnimComplete( e:FJMovieClipEvent ):void
		{
			if ( checkLabelExists( "stand" ) )
				gotoAndStop( "stand" );
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _showAnimComplete );
		}
		private function _hideAnimComplete( e:FJMovieClipEvent ):void
		{
			visible = false;
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _hideAnimComplete );
			dispatchEvent( new FJPreloadEvent( FJPreloadEvent.OUT_COMPLETE ) );
		}
	}
}