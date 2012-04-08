package fj.site.controller.commands {
	
	import fj.site.controller.events.FJAddSceneEvent;
	import fj.site.controller.events.FJRemoveSceneEvent;
	import fj.site.model.models.FJScenesModel;
	
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
