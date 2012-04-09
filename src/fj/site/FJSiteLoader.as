package fj.site
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	
	import fj.view.events.FJPreloadEvent;
	import fj.view.views.FJMovieClip;
	import fj.view.views.FJPreload;
	
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class FJSiteLoader extends FJMovieClip
	{
		public var preload:FJPreload;
		
		protected var loader:LoaderMax;
		
		public function FJSiteLoader()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			preload = searchDisplayObjectByClass( FJPreload, this );
			if ( preload ) {
				if ( root.loaderInfo.bytesLoaded < root.loaderInfo.bytesTotal ) {
					root.loaderInfo.addEventListener( Event.COMPLETE, _rootComplete );
				} else {
					_loadSite();
				}
			} else {
				_loadSite();
			}
		}
		
		
		protected function loadAssets():void {}
		protected function loadComplete():void {}
		
		
		private function _rootComplete(e:Event):void 
		{
			_loadSite();
		}
		private function _loadSite():void
		{
			loader = new LoaderMax( { onComplete:_loaderComplete, onProgress:_loaderProgress } );
			
			if( preload ) preload.value = 0;
			
			loadAssets();
			
			loader.load();
		}
		private function _loaderProgress( e:LoaderEvent ):void 
		{
			if( preload ) preload.value = e.target.progress;
		}
		private function _loaderComplete( e:Event ):void 
		{
			if( preload ){
				preload.addEventListener( FJPreloadEvent.OUT_COMPLETE, _preloadOut );
				preload.hide();
			} else {
				loadComplete();
			}
			 
		}
		private function _preloadOut( e:FJPreloadEvent ):void 
		{
			removeChild( preload );
			loadComplete();
		}
	}
}