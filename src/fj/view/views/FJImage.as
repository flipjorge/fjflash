package fj.media
{	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.LoaderStatus;
	
	import fj.view.events.FJImageEvent;
	import fj.view.views.FJMovieClip;
	import fj.view.views.FJPreload;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	public class FJImage extends FJMovieClip
	{
		public static const FIT:String = "adjustFit";
		public static const FILL:String = "adjustFill";
		
		public var target:MovieClip;
		
		public var preload:FJPreload;
		//// Private properties ////
		private var _imageLoader:ImageLoader;
		private var _source:String;
		private var _urlImagem:String;
		private var _ratio:Number;
		private var _constrain:Boolean;
		private var _constrainType:String;
		private var _adjustType:String;
		private var _widthOriginal:Number;
		private var _heightOriginal:Number;
		private var _width:Number;
		private var _height:Number;
		private var _limits:Boolean;
		private var _limitWidth:Number;
		private var _limitHeight:Number;
		
		private var assetsManager:FJAssets;
		
		public function FJImage()
		{
			assetsManager = FJAssets.getInstance();
			
			_constrain = true;
			_constrainType = "h";
			_adjustType = FIT;
			_ratio = 1;
			preload = searchDisplayObjectByClass( FJPreload, this );
			if ( preload ) preload.visible = false;
			target = searchDisplayObjectByInstanceName( "target", MovieClip, this );
			if ( !target ) {
				target = new MovieClip();
				addChild( target );
			}
		}
		
		public function setImageFromURL( url:String ):void
		{
			_urlImagem = url;
			unload();
			_imageLoader = LoaderMax.getLoader( url ) as ImageLoader;
			if ( _imageLoader ) {
				if ( _imageLoader.status == LoaderStatus.COMPLETED ) {
					_addImageLoaded();
				} else {
					_imageLoader.addEventListener( LoaderEvent.OPEN, onImageLoaderOpen );
					_imageLoader.addEventListener( LoaderEvent.PROGRESS, onImageLoaderProgress );
					_imageLoader.addEventListener( LoaderEvent.COMPLETE, onImageLoaderComplete );
					_imageLoader.prioritize();
				}
			} else {
				_imageLoader = assetsManager.images.append( new ImageLoader( url, { name: url } ) ) as ImageLoader;
				_imageLoader.addEventListener( LoaderEvent.OPEN, onImageLoaderOpen );
				_imageLoader.addEventListener( LoaderEvent.PROGRESS, onImageLoaderProgress );
				_imageLoader.addEventListener( LoaderEvent.COMPLETE, onImageLoaderComplete );
				_imageLoader.prioritize();
			}
		}
		public function setImageFromBitmapData( bitmapData:BitmapData ):void
		{
			unload();
			target.addChild( new Bitmap( bitmapData, "auto", true ) );
			
			_widthOriginal = bitmapData.width;
			_heightOriginal = bitmapData.height;
			if ( isNaN( _width ) ) _width = _widthOriginal;
			if ( isNaN( _height ) ) _height = _heightOriginal;
			_ratio = _widthOriginal / _heightOriginal;
			
			_adjust();
			
			dispatchEvent( new FJImageEvent( FJImageEvent.LOADED ) );
		}
		public function setPivotAtCenter():void
		{
			target.x = -_width/ 2;
			target.y = - _height / 2;
		}
		
		public function get constrain():Boolean { return _constrain; }
		public function set constrain( b:Boolean ):void
		{
			_constrain = b;
			_adjust();
		}
		
		public function setLimits( width:Number, height:Number ):void
		{
			_limits = true;
			_limitWidth = width;
			_limitHeight = height;
			if ( _source ) _adjust();
		}
		
		public function set imageWidth( width:Number ):void
		{
			_constrainType = "h";
			_width = width;
			
			if ( _source ) _adjust();
		}
		
		public function set imageHeight( height:Number ):void
		{
			_constrainType = "v";
			_height = height;
			if ( _source ) _adjust();
		}
		
		public function get imageRect():Rectangle
		{
			return target.getRect(this);
		}
		
		public function get adjustType():String
		{
			return _adjustType;
		}
		public function set adjustType( type:String ):void
		{
			_adjustType = type;
			if ( _source ) _adjust();
		}
		
		public function get bitmapData():BitmapData
		{
			var bitmapData:BitmapData = new BitmapData( _imageLoader.content.width, _imageLoader.content.height, true );
			bitmapData.draw( _imageLoader.content, null, null, null, null, true );
			
			return bitmapData;
		}
		
		public function unload():void
		{
			if ( _imageLoader ) {
				_imageLoader.removeEventListener( LoaderEvent.OPEN, onImageLoaderOpen );
				_imageLoader.removeEventListener( LoaderEvent.PROGRESS, onImageLoaderProgress );
				_imageLoader.removeEventListener( LoaderEvent.COMPLETE, onImageLoaderComplete );
				_imageLoader.unload();
			}
			while ( target.numChildren > 0 ) {
				target.removeChild( target.getChildAt(0) );
			}
		}
		//// Override methods ////
		
		override public function destroy():void
		{
			unload();
			super.destroy();
		}
		//// Private methods ////
		private function onImageLoaderOpen(e:LoaderEvent):void 
		{
			if ( preload ) preload.show();
		}
		private function onImageLoaderProgress(e:LoaderEvent):void 
		{
			if( preload ) preload.value = _imageLoader.bytesLoaded / _imageLoader.bytesTotal * 100;
		}
		private function onImageLoaderComplete(e:LoaderEvent):void 
		{
			_addImageLoaded();
		}
		private function _addImageLoaded():void
		{
			try {
				var bitmapData:BitmapData = new BitmapData( _imageLoader.content.width, _imageLoader.content.height, true );
				bitmapData.draw( _imageLoader.content, null, null, null, null, true );
				target.addChild( new Bitmap( bitmapData ) );
			} catch (error) {
				target.addChild( _imageLoader.content );
			}
			
			if ( preload ) preload.hide();
			_widthOriginal = _imageLoader.content.width;
			_heightOriginal = _imageLoader.content.height;
			if ( isNaN( _width ) ) _width = _widthOriginal;
			if ( isNaN( _height ) ) _height = _heightOriginal;
			_ratio = _widthOriginal / _heightOriginal;
			
			_adjust();
			
			dispatchEvent( new FJImageEvent( FJImageEvent.LOADED ) );
		}
		private function _adjust():void
		{
			var _x:Number = 0;
			var _y:Number = 0;
			if ( _limits  ) {
				if ( _constrainType == "h" ) {
					if ( _width > _limitWidth ) _width = _limitWidth;
					if ( _constrain ) _height = _width / _ratio;
					if ( _height > _limitHeight ) _height = _limitHeight;
					if ( _constrain ) _width = _height * _ratio;
				} else {
					if ( _height > _limitHeight ) _height = _limitHeight;
					if ( _constrain ) _width = _height * _ratio;
					if ( _width > _limitWidth )  _width = _limitWidth;
					if ( _constrain ) _height = _width / _ratio;
				}
				if ( _adjustType == FILL ) {
					if ( _width < _limitWidth ) {
						_width =  _limitWidth;
						_height = _width / _ratio;
					} else if ( _height < _limitHeight ) {
						_height = _limitHeight;
						_width = _height * _ratio;
					}
				}
				_x = ( _limitWidth - _width ) / 2
				_y = ( _limitHeight - _height ) / 2
			} else {
				if( _constrainType == "h" ){
					if( _width ){
						if ( _constrain ) _height = _width / _ratio;
					}
				} else {
					if ( _constrain ) _width = _height * _ratio;
				}
			}
			target.x = _x;
			target.y = _y;
			target.width = _width;
			target.height = _height;
		}
	}
}