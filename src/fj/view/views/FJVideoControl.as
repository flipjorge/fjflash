package fj.ui
{
	import fj.view.events.FJFaderEvent;
	import fj.view.events.FJVideoControlEvent;
	import fj.view.views.FJButton;
	import fj.view.views.FJMovieClip;
	
	import flash.events.MouseEvent;

	public class FJVideoControl extends FJMovieClip
	{
		public var playButton:FJButton;
		public var pauseButton:FJButton;
		public var scrubber:FJScrubber;
		
		public var volumeFader:FJFader;
		
		public var muteButton:FJButton;
		public var unmuteButton:FJButton;
		public var stopButton:FJButton;
		
		private var _volume:Number;
		private var _mute:Boolean;
		
		public function FJVideoControl()
		{
			playButton = searchDisplayObjectByInstanceName( "play", FJButton, this );
			if ( playButton ) {
				playButton.addEventListener( MouseEvent.CLICK, _playClick );
			}
			if ( pauseButton ) {
				pauseButton.addEventListener( MouseEvent.CLICK, _pauseClick );
			}
			scrubber = searchDisplayObjectByClass( FJScrubber, this );
			muteButton = searchDisplayObjectByInstanceName( "mute", FJButton, this );
			if ( muteButton ) {
				muteButton.addEventListener( MouseEvent.CLICK, _muteClick );
			}
			if ( unmuteButton ) {
				unmuteButton.addEventListener( MouseEvent.CLICK, _unmuteClick );
			}
			volumeFader = searchDisplayObjectByInstanceName( "volume", FJFader, this );
			if ( volumeFader ) {
				volumeFader.addEventListener( FJFaderEvent.CHANGED, _volumeFade );
				volumeFader.value = 1;
			} else {
				_volume = 1;
			}
			stopButton = searchDisplayObjectByInstanceName( "stop", FJButton, this );
			if( stopButton ) stopButton.addEventListener( MouseEvent.CLICK, _stopClick );
		}
		
		public function getPlay():Boolean { return playButton.selected }
		
		public function setPlay( boolean:Boolean ):void
		{
			playButton.selected = boolean;
			playButton.visible = !boolean;
			pauseButton.selected = !boolean;
			pauseButton.visible = boolean
			playButton.selected ? dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.PLAY ) ) : dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.PAUSE ) );
		}
		
		public function get position():Number
		{
			if( scrubber )
				return scrubber.value;
			else
				return -1;
		}
		public function set position( position:Number ):void
		{
			if ( scrubber )
				scrubber.value = position;
		}
		
		public function set percentageLoaded( percentage:Number ):void
		{
			if( scrubber )
				scrubber.percentageLoaded = percentage;
		}
		
		public function get volume():Number { return _volume; }
		public function set volume( volume:Number ):void
		{
			volumeFader.value = volume;
			if ( muteButton ) {
				if ( muteButton.selected ) muteButton.selected = false;
			}
		}
		//// Private methods ////
		private function _playClick( e:MouseEvent ):void
		{
			playButton.selected = true;
			playButton.visible = false;
			
			pauseButton.selected = false;
			pauseButton.visible = true;
			
			dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.PLAY ) );
		}
		private function _pauseClick( e:MouseEvent ):void
		{
			playButton.selected = false;
			playButton.visible = true;
			
			pauseButton.selected = true;
			pauseButton.visible = false;
			
			dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.PAUSE ) );
		}
		private function _volumeFade( e:FJFaderEvent ):void
		{
			_volume = e.currentTarget.value;
			if ( _volume > 0 && muteButton.selected ) muteButton.selected = false;
			dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.VOLUME_CHANGED ) );
		}
		private function _muteClick( e:MouseEvent ):void
		{
			muteButton.selected = true;
			muteButton.visible = false;
			
			unmuteButton.selected = false;
			unmuteButton.visible = true;
			
			var tempVolume:Number = _volume;
			if ( volumeFader ) {
				volumeFader.value = 0;
				_volume = tempVolume;
			} else {
				_volume = 0;
				dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.VOLUME_CHANGED ) ) );
			}
			dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.MUTE) );
		}
		private function _unmuteClick( e:MouseEvent ):void
		{
			muteButton.selected = false;
			muteButton.visible = true;
			
			unmuteButton.selected = true;
			unmuteButton.visible = false;
			
			if ( volumeFader ) {
				volumeFader.value = _volume;
			} else {
				_volume = 1;
				dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.VOLUME_CHANGED ) );
			}
			dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.UNMUTE) );
		}
		private function _stopClick( e:MouseEvent ):void
		{
			playButton.selected = false;
			playButton.visible = true;
			
			pauseButton.selected = true;
			pauseButton.visible = false;
			dispatchEvent( new FJVideoControlEvent( FJVideoControlEvent.STOP ) );
		}
	}
}