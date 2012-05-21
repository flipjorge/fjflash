package fj.media
{
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.VideoLoader;

	public class FJAssets
	{
		private static var _instance:FJAssets;
		
		public function FJAssets()
		{
			if ( _instance != null ) throw new Error( "Use FJAssets.getInstance()" );
			
			images = new LoaderMax();
			videos = new LoaderMax();
			sounds = new LoaderMax();
			
			_instance = this;
		}
		public static function getInstance():FJAssets 
		{
			if ( FJAssets._instance == null ) 
			{
				FJAssets._instance = new FJAssets();
			}
			return FJAssets._instance;
		}
		
		public var images:LoaderMax;
		public var videos:LoaderMax;
		public var sounds:LoaderMax;
		
		public static function loadImageAsset( url:String ):void
		{
			var imageLoader = LoaderMax.getLoader( url ) as ImageLoader;
			
			if ( !imageLoader ) {
				imageLoader = _instance.images.append( new ImageLoader( url, { name: url } ) ) as ImageLoader;
				imageLoader.prioritize();
			}
		}
		
		public static function loadVideoAsset( url:String ):void
		{
			var videoLoader = LoaderMax.getLoader( url ) as VideoLoader;
			
			if ( !videoLoader ) {
				videoLoader = _instance.videos.append( new VideoLoader( url, { name: url } ) ) as VideoLoader;
				videoLoader.prioritize();
			}
		}
		
		public static function loadSoundAsset( url:String ):void
		{
			var soundLoader = LoaderMax.getLoader( url ) as MP3Loader;
			
			if ( !soundLoader ) {
				soundLoader = _instance.sounds.append( new MP3Loader( url, { name: url } ) ) as MP3Loader;
				soundLoader.prioritize();
			}
		}
	}
}