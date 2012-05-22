package fj.ui
{
	import fj.view.events.FJScrubberEvent;
	import fj.view.views.FJMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class FJScrubber extends FJMovieClip
	{
		public var passiveBar:MovieClip;
		public var activeBar:MovieClip;
		public var handler:MovieClip;
		
		private var _fullWidth:Number;
		private var _scrubbing:Boolean;
		
		public function FJScrubber()
		{
			if ( passiveBar ) {
				_fullWidth = passiveBar.width;
				passiveBar.addEventListener( MouseEvent.MOUSE_DOWN, _barDown );
			}
			if ( activeBar ) activeBar.mouseEnabled = false;
			if ( handler ) handler.x = activeBar.x + activeBar.width;
			if ( !activeBar && !handler ) trace( "\"" + this.name + "\" must have activeBar or handler" );
		}
		
		public function get value():Number
		{
			var prct:Number = ( mouseX - passiveBar.x ) / _fullWidth;
			if ( prct < 0 ) prct = 0;
			if ( prct > 1 ) prct = 1;
			return prct;
		}
		public function set value( prct:Number ):void
		{
			if ( isNaN(prct) ) prct = 0;
			if ( activeBar ) activeBar.scaleX = prct;
			if ( handler ) handler.x = passiveBar.x + activeBar.width;
		}
		public function set percentageLoaded( percentage:Number ):void
		{
			passiveBar.scaleX = percentage;
		}
		//// Override methods ////
		override public function destroy():void
		{
			if( passiveBar.hasEventListener( MouseEvent.MOUSE_DOWN ) ) passiveBar.removeEventListener( MouseEvent.MOUSE_DOWN, _barDown );
			if ( stage.hasEventListener( MouseEvent.MOUSE_MOVE ) ) stage.removeEventListener( MouseEvent.MOUSE_MOVE, _barMove );
			if ( stage.hasEventListener( MouseEvent.MOUSE_UP ) ) stage.removeEventListener( MouseEvent.MOUSE_UP, _barUp );
			super.destroy();
		}
		//// Private methods ////
		private function _barDown( e:MouseEvent ):void
		{
			if ( activeBar ) activeBar.scaleX = value;
			if ( handler ) handler.x = activeBar.x + activeBar.width;
			stage.addEventListener( MouseEvent.MOUSE_MOVE, _barMove );
			stage.addEventListener( MouseEvent.MOUSE_UP, _barUp );
			dispatchEvent( new FJScrubberEvent( FJScrubberEvent.START_SCRUBBING ) );
		}
		private function _barMove( e:MouseEvent ):void
		{
			if ( activeBar ) activeBar.scaleX = value;
			if ( handler ) handler.x = activeBar.x + activeBar.width;
			dispatchEvent( new FJScrubberEvent( FJScrubberEvent.SCRUBBING_CHANGE ) );
		}
		private function _barUp( e:MouseEvent ):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, _barMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP, _barUp );
			dispatchEvent( new FJScrubberEvent( FJScrubberEvent.END_SCRUBBING ) );
		}
	}
}