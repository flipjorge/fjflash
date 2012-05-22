package fj.media
{
	import fj.ui.FJScrubber;
	import fj.ui.FJVideoControl;
	import fj.view.events.FJScrubberEvent;
	import fj.view.events.FJVideoControlEvent;
	import fj.view.events.FJVideoEvent;
	import fj.view.views.FJMovieClip;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	public class FJVideoPlayer extends FJMovieClip
	{
		public var video:FJVideo;
		public var videoControl:FJVideoControl;
		
		public var scrubber:FJScrubber;
		
		public var autoPlay:Boolean;
		
		private var _screen:Sprite;
		private var _source:String;
		private var _scrubbing:Boolean;
		private var _playing:Boolean;
		private var _urlScreen:String;
		private var _screenState:Boolean;
		private var _lScreen:Loader;
		
		public function FJVideoPlayer()
		{
			video = searchDisplayObjectByClass( FJVideo, this );
			if ( video )
				video.addEventListener( FJVideoEvent.STOPPED, _videoStop );
			else
				throw new Error( "FJVideo not found" );
			videoControl = searchDisplayObjectByClass( FJVideoControl, this );
			if ( videoControl ) {
				videoControl.position = 0;
				videoControl.mouseChildren = false;
				videoControl.addEventListener( FJVideoControlEvent.PLAY, _videoControlPlay );
				videoControl.addEventListener( FJVideoControlEvent.PAUSE , _videoControlPause );
				videoControl.addEventListener( FJVideoControlEvent.STOP, _videoControlStop );
				videoControl.addEventListener( FJVideoControlEvent.VOLUME_CHANGED, _videoControlVolume );
			} else {
				throw new Error( "FJVideoControl not found" );
			}
			scrubber = searchDisplayObjectByClass( FJScrubber, videoControl );
			if ( scrubber ) {
				scrubber.addEventListener( FJScrubberEvent.START_SCRUBBING, _videoControlScrubbStart );
				scrubber.addEventListener( FJScrubberEvent.SCRUBBING_CHANGE, _videoControlScrubb );
				scrubber.addEventListener( FJScrubberEvent.END_SCRUBBING, _videoControlScrubbEnd );
			}
			_screen = searchDisplayObjectByInstanceName( "screen", MovieClip, this );
			if ( !_screen ) {
				_screen = new Sprite();
				_screen.visible = false;
				_screen.x = video.x;
				_screen.y = video.y;
				addChild( _screen );
			}
			_screen.buttonMode = true;
		}
		
		public function get preview():String { return _urlScreen; }
		public function set preview( url:String ):void
		{
			_urlScreen = url;
			_screenState = true;
			autoPlay = true;
			if( _lScreen ){
				_lScreen.unload();
				_lScreen.removeEventListener( Event.COMPLETE, _screenComplete );
				_lScreen = null;
			}
			_screen.visible = true;
			videoControl.mouseChildren = false;
			
			_lScreen = new Loader();
			_lScreen.load( new URLRequest( url ) );
			_lScreen.contentLoaderInfo.addEventListener( Event.COMPLETE, _screenComplete );
			_screen.addEventListener( MouseEvent.CLICK, _screenClick );
		}
		
		public function get source():String { return _source; }
		public function set source( url:String ):void
		{
			_source = url;
			if ( !_screenState ) {
				if ( _source ) {
					video.source = url;
					videoControl.position = 0;
					videoControl.mouseChildren = true;
					if( autoPlay ){
						videoControl.setPlay( true );
						video.run = true;
						addEventListener( Event.ENTER_FRAME, _loopRun );
					}
					addEventListener( Event.ENTER_FRAME, _loadedLoop );
				} else {
					throw new Error( "source must be defined" );
				}
			}
		}
		
		public function stopVideo():void
		{
			video.run = false;
		}
		//// Override methods ////
		override public function destroy():void 
		{
			video = null;
			_screen = null;
			videoControl = null;
			_lScreen = null;
			super.destroy();
		}
		//// Private methods ////
		private function _videoControlPlay( e:FJVideoControlEvent ):void
		{
			video.run = true;
			addEventListener( Event.ENTER_FRAME, _loopRun );
		}
		private function _videoControlPause( e:FJVideoControlEvent ):void
		{
			video.run = false;
			removeEventListener( Event.ENTER_FRAME, _loopRun );
		}
		private function _loopRun( e:Event ):void
		{
			videoControl.position = video.position;
		}
		private function _loadedLoop( e:Event ):void
		{
			videoControl.percentageLoaded = video.loaded;
			if( video.loaded == 1 ){
				removeEventListener( Event.ENTER_FRAME, _loadedLoop );
			}
		}
		private function _videoControlStop( e:FJVideoControlEvent ):void
		{
			video.run = false;
			video.position = 0;
		}
		private function _videoControlScrubbStart( e:FJScrubberEvent ):void
		{
			_playing = video.run;
			video.run = false;
			video.position = videoControl.position;
			removeEventListener( Event.ENTER_FRAME, _loopRun );
		}
		private function _videoControlScrubb( e:FJScrubberEvent ):void
		{
			video.position = videoControl.position;
		}
		private function _videoControlScrubbEnd( e:FJScrubberEvent ):void
		{
			if( _playing ){
				video.run = true;
				addEventListener( Event.ENTER_FRAME, _loopRun );
			}
			video.position = videoControl.position;
		}
		private function _videoControlVolume( e:FJVideoControlEvent ):void
		{
			video.volume = videoControl.volume;
		}
		private function _videoStop( e:FJScrubberEvent ):void
		{
			videoControl.setPlay( false );
			video.position = 0;
		}
		private function _screenComplete( e:Event ):void
		{
			_screen.addChild( _lScreen );
			_lScreen.width = video.width;
			_lScreen.height = video.height;
		}
		private function _screenClick( e:MouseEvent ):void
		{
			_screen.visible = false;
			_screenState = false;
			source = _source;
		}
	}
}