package fj.ui
{
	import fj.view.events.FJFaderEvent;
	import fj.view.views.FJMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class FJFader extends FJMovieClip
	{
		public var handler:MovieClip;
		public var rail:MovieClip;
		
		private var _value:Number;
		
		public function FJFader():void
		{
			if ( handler ) {
				_value = (handler.x - rail.x) / rail.width;
				handler.buttonMode = true;
				handler.addEventListener( MouseEvent.MOUSE_DOWN, _handlerDown );
			} else {
				throw new Error( "\"handler\" MovieClip not found" );
			}
			if( !rail ) throw new Error( "\"rail\" MovieClip not found" );
		}
		
		public function get value():Number { return _value; }
		public function set value( n:Number ):void
		{
			_value = n;
			handler.x = rail.x + _value * rail.width ;
			dispatchEvent( new FJFaderEvent( FJFaderEvent.CHANGED ) );
		}
		//// Override methods ////
		override public function destroy():void
		{
			if( handler.hasEventListener( MouseEvent.MOUSE_DOWN ) ){
				handler.removeEventListener( MouseEvent.MOUSE_DOWN, _handlerDown );
			}
			if ( stage.hasEventListener( MouseEvent.MOUSE_MOVE ) ) {
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, _handlerMove );
			}
			if ( stage.hasEventListener( MouseEvent.MOUSE_UP ) ) {
				stage.removeEventListener( MouseEvent.MOUSE_UP, _handlerUp );
			}
			super.destroy();
		}
		//// Private methods ////
		private function _handlerDown( e:MouseEvent ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_MOVE, _handlerMove );
			stage.addEventListener( MouseEvent.MOUSE_UP, _handlerUp );
		}
		private function _handlerUp( e:MouseEvent ):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, _handlerMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP, _handlerUp );
		}
		private function _handlerMove( e:MouseEvent ):void
		{
			handler.x = mouseX;
			if ( handler.x < rail.x ) handler.x = rail.x;
			if ( handler.x > rail.x + rail.width ) handler.x = rail.x + rail.width;
			_value = ( handler.x - rail.x ) / ( rail.width );
			dispatchEvent( new FJFaderEvent( FJFaderEvent.CHANGED ) );
		}
	}
}