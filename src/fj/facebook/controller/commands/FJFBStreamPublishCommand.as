package fj.facebook.controller.commands
{
	import com.facebook.graph.Facebook;
	
	import fj.facebook.controller.events.FJFBStreamPublishEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FJFBStreamPublishCommand extends Command
	{
		[Inject]
		public var event:FJFBStreamPublishEvent;
		
		override public function execute():void
		{
			var publishData:Object = {
				message: event.streamPublish.message,
				attachment: {
					name: event.streamPublish.name,
					caption: event.streamPublish.caption,
					description: event.streamPublish.description,
					media: [{
						'type':'image',
						'src': event.streamPublish.imageSrc,
						'href': event.streamPublish.href
					}],
					
					href: event.streamPublish.href
				},
				action_links: [
					{ text: event.streamPublish.actionLinkText, href: event.streamPublish.actionLinkHref }
				],
				user_prompt_message: event.streamPublish.userPromptMessage
			};
			
			if ( !isNaN( event.streamPublish.targetID ) ) {
				publishData.target_id = event.streamPublish.targetID;
			}
			
			Facebook.ui( "stream.publish", publishData, null, "iframe" );
		}
	}
}