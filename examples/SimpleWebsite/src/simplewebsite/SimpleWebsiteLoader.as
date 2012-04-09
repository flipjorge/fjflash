package simplewebsite
{
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import fj.site.FJSiteLoader;
	
	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;
	import flash.system.LoaderContext;
	
	public class SimpleWebsiteLoader extends FJSiteLoader
	{
		override protected function loadAssets():void
		{
			var siteContext:LoaderContext = new LoaderContext();
			siteContext.parameters = root.loaderInfo.parameters;
			
			var siteLoader:SWFLoader = new SWFLoader("SimpleWebsite.swf", {name:"site", context:siteContext} );
			
			loader.append( siteLoader );
		}
		
		override protected function loadComplete():void
		{
			addChild( loader.getContent( "site" ) );
		}
		
	}
}