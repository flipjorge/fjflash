package fj.view.views
{
	import fj.view.events.FJMovieClipEvent;
	import fj.view.events.FJPopupEvent;
	
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;

	public class FJPopup extends FJMovieClip
	{
		public var closeButton:InteractiveObject;
		
		public function FJPopup()
		{
			closeButton = searchDisplayObjectByInstanceName( "close", InteractiveObject, this );
			if ( closeButton ) {
				closeButton.addEventListener( MouseEvent.CLICK, _closeClick);
			}
		}
		
		public function open():void
		{
			if ( checkLabelExists( "open:start" ) && checkLabelExists( "open:end" ) ) {
				gotoAndPlayUntil( "open:start", "open:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _openComplete );
			} else {
				dispatchEvent( new FJPopupEvent(FJPopupEvent.OPENED) );
			}
		}
		
		public function close():void
		{
			if ( checkLabelExists( "close:start" ) && checkLabelExists( "close:end" ) ) {
				gotoAndPlayUntil( "close:start", "close:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _closeComplete );
			} else {
				dispatchEvent( new FJPopupEvent( FJPopupEvent.CLOSED ) );
			}
		}
		
		
		private function _closeClick(e:MouseEvent):void
		{
			close();
		}
		private function _openComplete(e:FJMovieClipEvent):void 
		{
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _openComplete );
			dispatchEvent( new FJPopupEvent( FJPopupEvent.OPENED ) );
		}
		private function _closeComplete(e:FJMovieClipEvent):void 
		{
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _closeComplete );
			dispatchEvent( new FJPopupEvent( FJPopupEvent.CLOSED ) );
		}
	}
}