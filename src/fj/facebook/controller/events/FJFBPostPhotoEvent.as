package fj.facebook.controller.events
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	public class FJFBPostPhotoEvent extends Event
	{
		public static const POST_PHOTO:String = "fjfbPostPhotoPost";
		public static const POSTED:String = "fjfbPostPhotoPosted";
		public static const FAILED:String = "fjfbPostPhotoFailed";
		
		public var message:String;
		public var image:BitmapData;
		public var error:Object;
		
		public function FJFBPostPhotoEvent(type:String, message:String = null, image:BitmapData = null, error:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.message = message;
			this.image = image;
			this.error = error;
		}
		override public function clone():Event
		{
			return new FJFBPostPhotoEvent(type, message, image, error, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJFBPostPhotoEvent", "type", "message", "image", "error", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}