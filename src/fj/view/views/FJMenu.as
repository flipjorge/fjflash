package fj.view.views
{
	import fj.view.events.FJMenuEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	public class FJMenu extends FJMovieClip
	{
		protected var buttons:Array;
		private var _selected:String;
		
		public function FJMenu()
		{
			buttons = new Array();
			for ( var i:int = 0; i < numChildren; i++ )
			{
				var child:DisplayObject = getChildAt( i );
				if ( child is ISelectable ) {
					buttons.push( child );
					child.addEventListener( MouseEvent.CLICK, _menuClick );
				}
			}
		}
		
		public function get selected ():String { return _selected; }
		public function set selected ( name:String ):void
		{
			if( _selected != name ){
				_selected = name;
				for ( var i:int = 0; i < buttons.length; i++ )
				{
					var button:ISelectable = buttons[i] as ISelectable;
					if( button.selected ) button.selected = false;
				}
				if ( name ) {
					var buttonSelected:ISelectable = getChildByName( name ) as ISelectable;
					if ( buttonSelected )
						buttonSelected.selected = true;
					else
						_selected = null;
				}
			}
			
		}
		
		override public function destroy():void
		{
			for (var i:int = 0; i < buttons.length; i++) 
			{
				var button:FJMovieClip = buttons[i] as FJMovieClip;
				button.removeEventListener( MouseEvent.CLICK, _menuClick );
			}
			super.destroy();
		}
		
		//
		private function _menuClick( e:MouseEvent ):void
		{
			selected = e.currentTarget.name;
			dispatchEvent( new FJMenuEvent( FJMenuEvent.SELECTION_CHANGED, e.currentTarget.name ) );
		}
	}
}