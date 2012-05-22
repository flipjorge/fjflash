package fj.facebook.controller.commands
{
	import com.facebook.graph.Facebook;
	
	import fj.facebook.controller.events.FJFBGetFriendsEvent;
	import fj.facebook.model.models.FJFacebookModel;
	import fj.facebook.model.vo.FJFBUser;
	
	import flash.utils.flash_proxy;
	
	import org.robotlegs.mvcs.Command;
	
	public class FJFBGetFriendsCommand extends Command
	{
		[Inject]
		public var event:FJFBGetFriendsEvent;
		
		[Inject]
		public var facebookModel:FJFacebookModel;
		
		override public function execute():void
		{
			commandMap.detain(this);
			
			if( event.fields ){
				Facebook.api( "me/friends/fields="+event.fields.join(","), onGetFriendsComplete );
			} else {
				Facebook.api( "me/friends/", onGetFriendsComplete );
			}
		}
		
		private function onGetFriendsComplete( result:Object, fail:Object ):void
		{
			var friendsResult:Array = result as Array;
			var friends:Array = new Array();
			var friend:FJFBUser;
			
			for (var i:int = 0; i < friendsResult.length; i++) 
			{
				friend = new FJFBUser();
				friend.id = friendsResult[i].id;
				friend.name = friendsResult[i].name;
				
				friends.push( friend );
			}
			
			facebookModel.userFriends = friends;
			
			commandMap.release( this );
		}
	}
}