package fj.facebook.controller.commands
{
	import com.facebook.graph.Facebook;
	
	import fj.facebook.controller.events.FJFBLoginEvent;
	import fj.facebook.model.models.FJFacebookModel;
	import fj.facebook.model.vo.FJFBUser;
	
	import org.robotlegs.mvcs.Command;
	
	public class FJFBLoginCommand extends Command
	{
		[Inject]
		public var event:FJFBLoginEvent;
		
		[Inject]
		public var facebookModel:FJFacebookModel;
		
		override public function execute():void
		{
			commandMap.detain(this);
			
			Facebook.init( event.appID, onLoginComplete );
		}
		
		private function onLoginComplete( result:Object, fail:Object ):void
		{
			Facebook.api( "/me", onMeInfo );
		}
		
		private function onMeInfo( result:Object, fail:Object ):void
		{
			var fbUser:FJFBUser = new FJFBUser();
			fbUser.id = result.id;
			fbUser.name = result.name;
			fbUser.idiom = result.locale;
			
			if ( result.location ) {
				fbUser.location = result.location.name;
			}
			
			facebookModel.loggedUser = fbUser;
			
			commandMap.release( this );
		}
	}
}