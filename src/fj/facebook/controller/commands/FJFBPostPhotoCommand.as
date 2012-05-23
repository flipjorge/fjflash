package fj.facebook.controller.commands
{
	import com.facebook.graph.Facebook;
	
	import fj.facebook.controller.events.FJFBPostPhotoEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FJFBPostPhotoCommand extends Command
	{
		[Inject]
		public var event:FJFBPostPhotoEvent;
		
		override public function execute():void
		{
			commandMap.detain( this );
			
			var params:Object = new Object();
			params.message = event.message;
			params.image = event.image;
			
			Facebook.api('/me/photos', onUploadComplete, params, 'POST');
		}
		
		private function onUploadComplete( result:Object, fail:Object ):void
		{
			if ( result ) {
				dispatch( new FJFBPostPhotoEvent( FJFBPostPhotoEvent.POSTED ) );
			} else {
				dispatch( new FJFBPostPhotoEvent( FJFBPostPhotoEvent.FAILED, null, null, fail ) );
			}
			
			commandMap.release(this);
		}
	}
}