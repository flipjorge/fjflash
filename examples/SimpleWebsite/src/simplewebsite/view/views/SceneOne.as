package simplewebsite.view.views
{
	import fj.site.view.views.FJScene;
	import fj.view.views.FJButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import simplewebsite.view.events.SceneOneSearchEvent;
	
	public class SceneOne extends FJScene
	{
		public var tSearch:TextField;
		public var bSearch:FJButton;
		
		private var _busy:Boolean;
		
		public function SceneOne()
		{
			super();
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			
			bSearch.addEventListener(MouseEvent.CLICK, onSearchClick);
		}
		override protected function onRemovedFromStage(e:Event):void
		{
			super.onRemovedFromStage(e);
			
			bSearch.removeEventListener(MouseEvent.CLICK, onSearchClick);
		}
		
		public function get busy():Boolean { return _busy };
		public function set busy( b:Boolean ):void
		{
			_busy = b;
			
			if( _busy )
				bSearch.disabled = true;
			else
				bSearch.disabled = false;
		}
		
		protected function onSearchClick(event:MouseEvent):void
		{
			dispatchEvent( new SceneOneSearchEvent( SceneOneSearchEvent.SEARCH_CLICK, tSearch.text ) );
		}
	}
}