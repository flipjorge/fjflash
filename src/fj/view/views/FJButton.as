package fj.view.views
{
	import fj.view.events.FJMovieClipEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	public class FJButton extends FJMovieClip
	{
		public var hit:MovieClip;
		
		private var _tLabel:TextField;
		
		private var _label:String;
		private var _selected:Boolean;
		private var _disabled:Boolean;
		private var _over:Boolean;
		
		public function FJButton()
		{
			hit = searchDisplayObjectByInstanceName( "hit", MovieClip, this, false );
			if ( !hit ) {
				hit = new MovieClip();
				hit.graphics.beginFill( 0x000000, 0 );
				var rect:Rectangle = getRect(this);
				hit.graphics.drawRect( rect.x, rect.y, rect.width, rect.height );
				addChild(hit);
			}
			
			hit.buttonMode = true;
			hit.addEventListener( MouseEvent.MOUSE_OVER, _hitOver );
			hit.addEventListener( MouseEvent.MOUSE_OUT, _hitOut );
			
			_tLabel = searchDisplayObjectByInstanceName( "label", TextField, this ) as TextField;
		}
		
		public function get label():String { return _label; }
		public function set label( s:String ):void
		{
			_label = s;
			if ( _tLabel ){
				_tLabel.text = _label;
			}
		}
		
		public function get selected():Boolean { return _selected; }
		public function set selected( b:Boolean ):void 
		{
			_selected = b;
			_disabled = false;
			if ( _selected ) {
				
				if ( checkLabelExists( "over:start" ) && checkLabelExists( "over:end" ) ) {
					gotoAndPlayUntil( "over:start", "over:end" );
					addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _overAnimComplete );
				} else if( checkLabelExists( "selected" ) ) {
					gotoAndStop( "selected" );
				} else if ( checkLabelExists( "over" ) ) {
					gotoAndStop( "over");
				}
				
				mouseEnabled = false;
				mouseChildren = false;
				hit.removeEventListener( MouseEvent.MOUSE_OVER, _hitOver );
				hit.removeEventListener( MouseEvent.MOUSE_OUT, _hitOut );
					
				if ( _over ) _over = false;
				
			} else {
				
				if ( checkLabelExists( "out:start" ) && checkLabelExists( "out:end" ) ) {
					gotoAndPlayUntil( "out:start", "out:end" );
					addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
				} else if ( checkLabelExists( "over:end" ) && checkLabelExists( "over:start" ) ) {
					gotoAndPlayUntil( "over:end", "over:start" );
					addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
				} else {
					gotoAndStop( 1 );
				}
				
				mouseEnabled = true;
				mouseChildren = true;
				hit.addEventListener( MouseEvent.MOUSE_OVER, _hitOver );
				hit.addEventListener( MouseEvent.MOUSE_OUT, _hitOut );
			}
		}
		
		public function get disabled():Boolean { return _disabled; }
		public function set disabled( b:Boolean):void 
		{
			_disabled = b;
			_selected = false;
			if ( _disabled ) {
				if ( checkLabelExists( "disabled") )
					gotoAndStop( "disabled" );
				mouseEnabled = false;
				mouseChildren = false;
				hit.removeEventListener( MouseEvent.MOUSE_OVER, _hitOver );
				hit.removeEventListener( MouseEvent.MOUSE_OUT, _hitOut );
			} else {
				gotoAndStop( 1 );
				mouseEnabled = true;
				mouseChildren = true;
				hit.addEventListener( MouseEvent.MOUSE_OVER, _hitOver );
				hit.addEventListener( MouseEvent.MOUSE_OUT, _hitOut );
			}
		}
		
		//
		override public function destroy():void
		{
			if( hit.hasEventListener( MouseEvent.MOUSE_OVER ) ) hit.removeEventListener( MouseEvent.MOUSE_OVER, _hitOver );
			if ( hit.hasEventListener( MouseEvent.MOUSE_OUT ) ) hit.removeEventListener( MouseEvent.MOUSE_OUT, _hitOut );
			super.destroy();
		}
		
		//
		private function _hitOver(e:MouseEvent):void 
		{
			if ( hasEventListener( FJMovieClipEvent.ANIM_COMPLETE ) ) removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
			
			_over = true;
			
			if ( checkLabelExists( "over:start" ) && checkLabelExists( "over:end") ) {
				gotoAndPlayUntil( "over:start", "over:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _overAnimComplete );
			} else if ( checkLabelExists( "over" ) ) {
				gotoAndStop( "over" );
			} else if( checkLabelExists( "selected" ) ) {
				gotoAndStop( "selected" );
			}
			
		}
		private function _hitOut(e:MouseEvent):void
		{
			if ( hasEventListener( FJMovieClipEvent.ANIM_COMPLETE ) ) removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _overAnimComplete );
			
			_over = false;
			
			if ( checkLabelExists( "out:start" ) && checkLabelExists( "out:end" ) ) {
				gotoAndPlayUntil( "out:start", "out:end" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
			} else if ( checkLabelExists( "over:start" ) && checkLabelExists( "over:end" ) ) {
				gotoAndPlayUntil( "over:end", "over:start" );
				addEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
			} else {
				gotoAndStop( 1 );
			}
		}
		private function _overAnimComplete( e:FJMovieClipEvent ):void
		{
			if ( checkLabelExists( "selected" ) )
				gotoAndStop( "selected" );
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _overAnimComplete );
		}
		private function _outAnimComplete(e:FJMovieClipEvent):void 
		{
			gotoAndStop( 1 );
			removeEventListener( FJMovieClipEvent.ANIM_COMPLETE, _outAnimComplete );
		}
	}
}