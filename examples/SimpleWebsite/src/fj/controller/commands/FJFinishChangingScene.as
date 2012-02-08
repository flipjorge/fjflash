package fj.controller.commands {
	
	import fj.controller.events.FJRemoveSceneEvent;
	import fj.controller.events.FJAddSceneEvent;
	import fj.model.models.FJScenesModel;
	import org.robotlegs.mvcs.Command;

	public class FJFinishChangingScene extends Command
	{
		
		[Inject]
		public var scenesModel:FJScenesModel;

		override public function execute() : void {
			
			if( scenesModel.currentScene ){
				dispatch( new FJRemoveSceneEvent(FJRemoveSceneEvent.REMOVE, scenesModel.currentScene ) );
			}
			
			dispatch( new FJAddSceneEvent(FJAddSceneEvent.ADD, scenesModel.nextScene) );
			scenesModel.currentScene = scenesModel.nextScene;
			scenesModel.nextScene = null;
			
		}

	}
}
