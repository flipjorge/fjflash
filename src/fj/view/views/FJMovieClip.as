package fj.view.views
{
	import fj.view.events.FJMovieClipEvent;
	import flash.display.FrameLabel;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class FJMovieClip extends MovieClip implements IDestroyable
	{
		private var _isPlaying:Boolean;
		private var _isReversing:Boolean;
		private var _frameStart:int;
		private var _frameEnd:int;
		
		public function FJMovieClip()
		{
			super.stop();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}		
		
		
		//
		public function playUntil( destinationFrame:Object ):void
		{
			stop();
			if( destinationFrame is String ){
				_frameEnd = _getFrameNumber( destinationFrame as String );
			} else {
				_frameEnd = int( destinationFrame );
			}
			if( _frameEnd != -1 && _frameEnd != 0 ){
				_isPlaying = true;
				super.play();
				addEventListener( Event.ENTER_FRAME, _playUntilLoop );
			} else {
				throw new Error( "\"" + destinationFrame + "\" Frame not found." );
			}
		}
		
		public function gotoAndPlayUntil( startFrame:Object, destinationFrame:Object ):void
		{
			stop();
			
			if( startFrame is String ) {
				_frameStart = _getFrameNumber( startFrame as String );
			} else {
				_frameStart = int( startFrame );
			}
			
			if( destinationFrame is String ) {
				_frameEnd = _getFrameNumber( destinationFrame as String );
			} else {
				_frameEnd = int( destinationFrame );
			}
			
			if( _frameStart != -1 && _frameEnd != -1 && _frameStart != 0 && _frameEnd != 0 ){
				_isPlaying = true;
				super.gotoAndPlay( _frameStart );
				addEventListener( Event.ENTER_FRAME, _playUntilLoop );
			} else {
				throw new Error( "\"" + startFrame + "\" or \"" + destinationFrame + "\" Frame not found." );
			}
		}
		
		public function playReversed():void
		{
			stop();
			_isReversing = true;
			addEventListener( Event.ENTER_FRAME, _reverseLoop );
		}
		
		public function gotoAndPlayReversed( startFrame:Object ):void
		{
			stop();
			
			if( startFrame is String ){
				_frameStart = _getFrameNumber( startFrame as String );
			} else {
				_frameStart = int( startFrame );
			}
			
			if ( _frameStart != -1 || _frameStart != 0 ) {
				_isReversing = true;
				super.gotoAndStop( startFrame );
				addEventListener( Event.ENTER_FRAME, _reverseLoop );
			} else {
				throw new Error( "\"" + startFrame + "\" Frame not found." );
			}
		}
		
		
		//
		public function checkLabelExists( label:String ):Boolean
		{
			for (var i:int = 0; i < currentLabels.length; i++)
			{
				var frameLabel:FrameLabel = currentLabels[i] as FrameLabel;
				if ( label == frameLabel.name )
					return true;
			}
			
			return false;
		}
		
		
		//
		public function forceResizeCall():void
		{
			onStageResize( null );
		}
		
		
		//
		public function destroy():void
		{
			stop();
			
			var child:DisplayObject;
			while ( numChildren > 0 )
			{
				child = getChildAt(0) as DisplayObject;
				if ( child is IDestroyable ){
					IDestroyable( child ).destroy();
				}
				removeChild( child );
			}
		}
		
		
		//
		override public function play():void {
			_stop();
			super.play();
		}
		
		override public function stop():void {
			_stop();
			super.stop();
		}
		
		override public function gotoAndPlay( frame:Object, scene:String = null ):void {
			_stop();
			super.gotoAndPlay( frame, scene );
		}
		
		override public function gotoAndStop( frame:Object, scene:String = null ):void {
			_stop();
			super.gotoAndStop( frame, scene );
		}
		
		
		//
		protected function searchDisplayObjectByInstanceName( instanceName:String, instanceClass:Class, container:DisplayObjectContainer, searchAtChilds:Boolean = true ):*
		{
			var reg:RegExp = new RegExp( ".*"+instanceName+".*", "i" );
			
			var child:DisplayObject;
			
			for(var i:uint = 0; i < container.numChildren; i++){
				child = container.getChildAt(i);
				if( child is instanceClass ){
					var valid:Boolean = reg.exec( child.name );
					if ( valid )
						return child as instanceClass;
				}
			}
			
			if ( searchAtChilds ) {
				for ( i = 0; i < container.numChildren; i++ ) 
				{
					child = container.getChildAt(i);
					if ( child is DisplayObjectContainer ) {
						var _child:DisplayObject = searchDisplayObjectByInstanceName( instanceName, instanceClass, child as DisplayObjectContainer );
						if( _child )
							return _child as instanceClass;
					}
				}
			}
			
			return null;
		}
		
		protected function searchDisplayObjectByClass( instanceClass:Class, container:DisplayObjectContainer, searchAtChilds:Boolean = true ):*
		{
			var i:uint;
			var child:DisplayObject;
			
			for ( i = 0; i < container.numChildren; i++ )
			{
				child = container.getChildAt(i);
				if( child is instanceClass )
					return child as instanceClass;
			}
			
			if ( searchAtChilds ) {
				for ( i = 0; i < container.numChildren; i++ ) 
				{
					child = container.getChildAt(i);
					if ( child is DisplayObjectContainer ) {
						var _child:DisplayObject = searchDisplayObjectByClass( instanceClass, child as DisplayObjectContainer );
						if( _child )
							return _child as instanceClass;
					}
				}
			}
			
			return null;
		}
		
		
		//
		protected function onAddedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			onStageResize( null );
			stage.addEventListener( Event.RESIZE, onStageResize );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		protected function onRemovedFromStage( e:Event ):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			stage.removeEventListener( Event.RESIZE, onStageResize );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onStageResize(e:Event):void { }
		
		
		//
		private function _playUntilLoop( e:Event ):void
		{
			if ( currentFrame == _frameEnd ) {
				stop();
				dispatchEvent( new FJMovieClipEvent( FJMovieClipEvent.ANIM_COMPLETE ) );
			} else if( currentFrame > _frameEnd ){
				prevFrame();
			}
		}
		private function _reverseLoop( e:Event ):void
		{
			currentFrame == 1 ? super.gotoAndStop( totalFrames ) : prevFrame();
		}
		private function _stop():void
		{
			if( _isReversing ){
				_isReversing = false;
				removeEventListener( Event.ENTER_FRAME, _reverseLoop );
			}
			
			if( _isPlaying ){
				_isPlaying = false;
				removeEventListener( Event.ENTER_FRAME, _playUntilLoop );
			}
		}
		private function _getFrameNumber( label:String ):int
		{
			for( var i:uint = 0; i < currentLabels.length; i++ ){
				if ( FrameLabel( currentLabels[i] ).name == label ) return FrameLabel( currentLabels[i] ).frame;
			}
			
			return -1;
		}
	}
}