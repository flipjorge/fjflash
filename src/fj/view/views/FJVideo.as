package fj.media
{
	import fj.view.events.FJVideoEvent;
	import fj.view.views.FJMovieClip;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class FJVideo extends FJMovieClip
	{
		
		public var video:Video;
		
		public var autoPlay:Boolean;
		
		private var _nc:NetConnection;
		private var _ns:NetStream;
		private var _soundTransform:SoundTransform;
		private var _duration:Number;
		private var _source:String;
		private var _running:Boolean;
		
		public function FJVideo()
		{
			_nc = new NetConnection();
			_nc.connect( null );
			_ns = new NetStream( _nc );
			_ns.client = this;
			_soundTransform = new SoundTransform();
			video = searchDisplayObjectByClass( Video, this );
			if ( video ) {
				video.smoothing = true;
				video.attachNetStream( _ns );
			} else {
				throw new Error( "\"video\" Video not found" );
			}
			_ns.addEventListener( NetStatusEvent.NET_STATUS, _netStatus );
		}
		
		public function get run():Boolean { return _running; }
		public function set run( b:Boolean ):void
		{
			_running = b;
			if( _source )
				_running ? _ns.resume() : _ns.pause();
		}
		
		public function get position():Number
		{
			return _ns.time / _duration
		}
		public function set position( b:Number ):void
		{
			_ns.seek( b * _duration );
		}
		
		public function get source():String { return _source; }
		public function set source( url:String ):void
		{
			_source = url;
			_ns.play( url );
			if ( !autoPlay ) _ns.pause();
		}
		
		public function get duration():Number { return _duration; }
		
		public function get loaded():Number
		{
			return _ns.bytesLoaded / _ns.bytesTotal;
		}
		
		public function get bitmapData():BitmapData
		{
			var bitmapData:BitmapData = new BitmapData( video.width, video.height );
			bitmapData.draw( video );
			return bitmapData;
		}
		
		public function get bitmap():Bitmap
		{
			var bitmapData:BitmapData = new BitmapData( video.width, video.height );
			bitmapData.draw( video );
			return new Bitmap( bitmapData , "auto", true );
		}
		
		public function get volume():Number { return _soundTransform.volume; }
		public function set volume( vol:Number ):void
		{
			_soundTransform.volume = vol;
			_ns.soundTransform = _soundTransform;
		}
		
		public function resolution( width:Number, height:Number ):void
		{
			video.width = width;
			video.height = height;
		}
		
		public function onMetaData( obj:Object ):void
		{
			_duration = obj.duration;
		}
		//// Override methods ////
		override public function destroy():void 
		{
			_ns.removeEventListener( NetStatusEvent.NET_STATUS, _netStatus );
			_ns = null;
			_nc = null;
			_soundTransform = null;
			video = null;
			super.destroy();
		}
		//// Private methods ////
		private function _netStatus( e:NetStatusEvent ):void
		{
			//trace( e.info.code );
			switch( e.info.code ){
				case "NetStream.Play.Stop":
					dispatchEvent( new FJVideoEvent( FJVideoEvent.STOPPED ) );
					break;
			}
		}
	}
}