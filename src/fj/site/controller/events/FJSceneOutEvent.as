package fj.site.controller.events {
	
	import fj.site.view.views.IScene;
	
	import flash.events.Event;

	public class FJSceneOutEvent extends Event
	{
		public static const OUT:String = "fjSceneOutOut";
		public static const OUT_COMPLETE:String = "fjSceneOutOutComplete";
		
		public var scene:IScene;
		
		public function FJSceneOutEvent(type : String, scene:IScene, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.scene = scene;
		}
		
		override public function clone() : Event {
			return new FJSceneOutEvent(type, scene);
		}
	}
}
