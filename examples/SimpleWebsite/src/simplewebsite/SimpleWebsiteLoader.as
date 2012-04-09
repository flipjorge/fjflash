package simplewebsite
{
	import com.greensock.loading.SWFLoader;
	
	import fj.site.FJSiteLoader;
	
	public class SimpleWebsiteLoader extends FJSiteLoader
	{
		override protected function loadAssets():void
		{
			loader.append( new SWFLoader( "SimpleWebsite.swf", {name:"site"} ) );
		}
		
		override protected function loadComplete():void
		{
			addChild( loader.getContent( "site" ) );
		}
		
	}
}