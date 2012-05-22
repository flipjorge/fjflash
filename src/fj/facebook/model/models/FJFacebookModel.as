package fj.facebook.model.models
{
	import fj.facebook.controller.events.FJFBChangeUserEvent;
	import fj.facebook.model.vo.FJFBUser;
	import fj.utils.FJArray;
	
	import org.robotlegs.mvcs.Actor;
	
	public class FJFacebookModel extends Actor
	{
		private var _loggedUser:FJFBUser;
		private var _userFriends:FJArray;

		public function get loggedUser():FJFBUser
		{
			return _loggedUser;
		}

		public function set loggedUser(user:FJFBUser):void
		{
			_loggedUser = user;
			
			dispatch( new FJFBChangeUserEvent( FJFBChangeUserEvent.CHANGED, _loggedUser ) );
		}
		
		public function get userFriends():FJArray
		{
			return _userFriends;
		}
		
		public function set userFriends(friends:FJArray):void
		{
			_userFriends = friends;
		}

	}
}