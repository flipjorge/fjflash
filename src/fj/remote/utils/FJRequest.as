package fj.remote.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class FJRequest extends EventDispatcher implements IEventDispatcher
	{
		public var method:String = URLRequestMethod.POST;
		public var preventCache:Boolean = true;
		
		private var _urlLoader:URLLoader;
		private var _urlRequest:URLRequest;
		private var _urlVariables:URLVariables;
		private var _data:Object;
		
		public function load( url:String, vars:Object = null ):void
		{
			_urlLoader = new URLLoader();
			_urlRequest = new URLRequest( url );
			_urlVariables = new URLVariables();
			
			_urlRequest.method = method;
			for ( var i:* in vars ){
				_urlVariables[i] = vars[i];
			}
			
			if ( preventCache ) {
				var date:Date = new Date();
				_urlVariables.noCache = date.getMinutes() + "" + date.getSeconds();
			}
			
			_urlRequest.data = _urlVariables;
			_urlLoader.load( _urlRequest );
			
			_urlLoader.addEventListener( Event.COMPLETE, _sendComplete );
			_urlLoader.addEventListener( IOErrorEvent.IO_ERROR, _sendIOError );
			_urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _sendSecurityError );
		}
		
		public function get data():Object { return _data; }
		
		override public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true ):void {
			super.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		//// Private methods ////
		private function _sendComplete( event:Event ):void
		{
			_urlLoader.removeEventListener( Event.COMPLETE, _sendComplete );
			_urlLoader.removeEventListener( IOErrorEvent.IO_ERROR, _sendIOError );
			_urlLoader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _sendSecurityError );
			
			_data = event.currentTarget.data;
			dispatchEvent( event );
		}
		private function _sendIOError( event:IOErrorEvent ):void 
		{
			_urlLoader.removeEventListener( Event.COMPLETE, _sendComplete );
			_urlLoader.removeEventListener( IOErrorEvent.IO_ERROR, _sendIOError );
			_urlLoader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _sendSecurityError );
			
			dispatchEvent( event );
		}
		private function _sendSecurityError( event:SecurityErrorEvent ):void 
		{
			_urlLoader.removeEventListener( Event.COMPLETE, _sendComplete );
			_urlLoader.removeEventListener( IOErrorEvent.IO_ERROR, _sendIOError );
			_urlLoader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _sendSecurityError );
			
			dispatchEvent( event );
		}
	}
}