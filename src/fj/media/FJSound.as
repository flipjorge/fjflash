package fj.media
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class FJSound
	{
		public var name:String;
		public var sound:Sound;
		public var position:int;
		public var paused:Boolean;
		public var volume:Number;
		public var loops:int;
		public var channel:SoundChannel;
		public var pausedByAll:Boolean;
		
		public function FJSound( name:String, sound:Sound, volume:Number = 1, loops:uint = 0 )
		{
			this.name = name;
			this.sound = sound;
			this.position = 0;
			this.paused = true;
			this.volume = volume;
			this.loops = loops;
			this.channel = new SoundChannel();
		}
		
	}
}