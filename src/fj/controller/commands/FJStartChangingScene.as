package fj.controller.commands {
	
	import fj.controller.events.FJSceneOutEvent;
	import fj.controller.events.FJChangeSceneEvent;
	import fj.model.models.FJScenesModel;
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
