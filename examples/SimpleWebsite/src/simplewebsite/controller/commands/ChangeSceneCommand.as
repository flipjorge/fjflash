package simplewebsite.controller.commands {
	
	import flash.utils.getDefinitionByName;
	import simplewebsite.controller.events.AddSceneEvent;
	import simplewebsite.controller.events.RemoveSceneEvent;
	import flash.display.MovieClip;
	import simplewebsite.model.models.ScenesModel;
	import simplewebsite.controller.events.ChangeSceneEvent;
	import org.robotlegs.mvcs.Command;
	
	public class ChangeSceneCommand extends Command {
		
		[Inject]
		public var changeSceneEvent:ChangeSceneEvent;	
		
		[Inject]
		public var scenesModel:ScenesModel;
		
		override public function execute() : void {
			
			var currentScene:MovieClip = scenesModel.currentScene;
			
			if( currentScene ){
				dispatch(new RemoveSceneEvent(RemoveSceneEvent.REMOVE, currentScene));
			}
			
			var newSceneClass:Class = getDefinitionByName(changeSceneEvent.sceneName) as Class;
			var newScene:MovieClip = new newSceneClass();
			
			dispatch(new AddSceneEvent(AddSceneEvent.ADD, newScene));
			
			scenesModel.currentScene = newScene;
			
		}
	}
}
