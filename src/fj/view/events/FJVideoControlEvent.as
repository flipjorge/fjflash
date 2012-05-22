package fj.view.events
{
	import flash.events.Event;
	
	public class FJVideoControlEvent extends Event
	{
		public static const PLAY:String = "fjVideoControlPlay";
		public static const PAUSE:String = "fjVideoControlPause";
		public static const STOP:String = "fjVideoControlStop";
		public static const VOLUME_CHANGED:String = "fjVideoControlVolumeChanged";
		public static const MUTE:String = "fjVideoControlMute";
		public static const UNMUTE:String = "fjVideoControlUnMute";
		
		public function FJVideoControlEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new FJVideoControlEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("FJVideoControlEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}