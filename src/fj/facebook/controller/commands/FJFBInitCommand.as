package fj.facebook.controller.commands
{
	import com.facebook.graph.Facebook;
	
	import fj.facebook.controller.events.FJFBInitEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FJFBInitCommand extends Command
	{
		[Inject]
		public var event:FJFBInitEvent;
		
		override public function execute():void
		{
			commandMap.detain( this );
			
			Facebook.init( event.appID, onInitialized );
		}
		
		private function onInitialized( result:Object, fail:Object ):void
		{
			if( result ){
				dispatch( new FJFBInitEvent( FJFBInitEvent.INITIALIZED ) );
			} else {
				dispatch( new FJFBInitEvent( FJFBInitEvent.FAILED ) );
			}
			
			commandMap.release( this );
		}
	}
}