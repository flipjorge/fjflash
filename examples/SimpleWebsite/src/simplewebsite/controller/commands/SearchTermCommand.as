package simplewebsite.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import simplewebsite.controller.events.SearchTermEvent;
	import simplewebsite.remote.services.ISearchService;
	
	public class SearchTermCommand extends Command
	{
		[Inject]
		public var event:SearchTermEvent;
		
		[Inject]
		public var service:ISearchService;
		
		override public function execute():void
		{
			service.search( event.searchTerm );
		}
	}
}