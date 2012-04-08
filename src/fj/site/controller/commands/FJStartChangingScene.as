package fj.site.controller.commands {
	
	import fj.site.model.models.FJScenesModel;
	import fj.site.controller.events.FJChangeSceneEvent;
	import fj.site.controller.events.FJSceneOutEvent;
	
	import org.robotlegs.mvcs.Command;

	public class FJStartChangingScene extends Command
	{
		[Inject]
		public var event:FJChangeSceneEvent;
		
		[Inject]
		public var scenesModel:FJScenesModel;
		
		override public function execute() : void {
			
			scenesModel.nextScene = event.scene;
			
			if( scenesModel.currentScene ){
				dispatch( new FJSceneOutEvent(FJSceneOutEvent.OUT, scenesModel.currentScene) );
			} else {
				dispatch( new FJSceneOutEvent(FJSceneOutEvent.OUT_COMPLETE, null) );
			}
		}
		
	}
}
