package fj.media
{
	import com.greensock.TweenLite;
	import com.greensock.loading.MP3Loader;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	public class FJSoundManager
	{	
		private var _soundsDictionary:Dictionary;
		private var _sounds:Array;
		
		private var _isMuted:Boolean;
		private var _masterVolume:Number;
		
		public function FJSoundManager()
		{
			TweenPlugin.activate( [VolumePlugin] );
			
			_soundsDictionary = new Dictionary( true );
			_sounds = new Array();
			_masterVolume = 1;
		}
		
		public function addLibrarySound( linkageID:*, name:String ):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if ( _sounds[i].name == name) return;
			}
			
			var sound:FJSound = new FJSound( name, new linkageID );
			
			_soundsDictionary.put( name, sound );
			_sounds.push( sound );
		}
		
		public function addExternalSound( url:String, name:String, buffer:Number = 1000, checkPolicyFile:Boolean = false ):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if ( _sounds[i].name == name) return;
			}
			
			var context:SoundLoaderContext = new SoundLoaderContext( buffer,  checkPolicyFile );
			var loader:MP3Loader = new MP3Loader( url, { name:name, context:context } );
			loader.load();
			
			var sound:FJSound = new FJSound( name, loader.content );
			
			_soundsDictionary.put( name, sound );
			_sounds.push( sound );
		}
		
		public function addMP3Loader( loader:MP3Loader, name:String ):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if ( _sounds[i].name == name) return;
			}
			
			var soundVO:FJSound = new FJSound( name, loader.content );
			
			_soundsDictionary.put( name, soundVO );
			_sounds.push( soundVO );
		}
		
		public function addSound( sound:Sound, name:String ):void
		{
			for (var i:int = 0; i < this._sounds.length; i++)
			{
				if ( _sounds[i].name == name) return;
			}
			
			var soundVO:FJSound = new FJSound( name, sound );
			
			_soundsDictionary.put( name, soundVO );
			_sounds.push( soundVO );
		}
		
		public function removeSound( name ):void
		{
			//FJArray.remove( _soundsDictionary.getValue( name ), _sounds );
			_soundsDictionary.remove( name );
		}
		
		public function removeAllSounds():void
		{
			var soundVO:FJSound;
			for (var i:int = 0; i < _sounds.length; i++) 
			{
				soundVO = _sounds[i];
				soundVO = null;
			}
			
			_sounds = new Array();
			_soundsDictionary = new Dictionary( true );
		}
		
		public function getSoundProgress( name:String ):Number
		{
			var sound:FJSound = _soundsDictionary.[name] as FJSound;
			
			return sound.sound.bytesLoaded / sound.sound.bytesTotal;
		}
		
		public function playSound( name:String, position:Number = 0, volume:Number = 1, loops:int = 0 ):FJSound
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			
			sound.volume = volume;
			sound.loops = loops;
			
			var dVolume:Number = sound.volume * _masterVolume;
			if ( _isMuted ) dVolume = 0;
			
			if ( sound.paused ) {
				sound.channel = sound.sound.play( sound.position, sound.loops, new SoundTransform( dVolume ) );
			} else {
				sound.channel = sound.sound.play( position, sound.loops, new SoundTransform( dVolume ) );
			}
			
			sound.paused = false;
			
			return sound;
		}
		
		public function pauseSound( name:String ):void
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			
			sound.position = sound.channel.position;
			sound.paused = true;
			sound.channel.stop();
		}
		
		public function pauseAllSounds():void
		{
			var sound:FJSound;
			
			for (var i:int = 0; i < _sounds.length; i++) 
			{
				sound = _sounds[i] as FJSound;
				sound.pausedByAll = true;
				pauseSound( sound.name );
			}
		}
		
		public function stopSound( name:String ):void
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			
			sound.position = 0;
			sound.paused = true;
			sound.channel.stop();
		}
		
		public function stopAllSounds():void
		{
			var sound:FJSound;
			
			for (var i:int = 0; i < _sounds.length; i++) 
			{
				sound = _sounds[i] as FJSound;
				sound.pausedByAll = true;
				stopSound( sound.name );
			}
		}
		
		public function resumeAllSounds():void
		{
			var sound:FJSound;
			
			for (var i:int = 0; i < _sounds.length; i++) 
			{
				sound = _sounds[i] as FJSound;
				if ( sound.pausedByAll ) {
					sound.pausedByAll = false;
					playSound( sound.name, 0, sound.volume, sound.loops );
				}
			}
		}
		
		public function setSoundVolume( name:String, volume:Number, fadeLength:Number = 0 ):void
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			sound.volume = volume;
			
			var dVolume:Number = sound.volume * _masterVolume;
			if ( _isMuted ) dVolume = 0;
			
			TweenLite.to( sound.channel, fadeLength, { volume:dVolume } );
		}
		
		public function getSoundVolume( name:String ):Number
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			return sound.volume;
		}
		
		public function setSoundPosition( name:String, position:int ):void
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			playSound( sound.name, position, sound.volume, sound.loops );
		}
		
		public function getSoundPosition( name:String ):int
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			return sound.channel.position;
		}
		
		public function getSoundDuration( name:String ):int
		{
			var sound:FJSound = _soundsDictionary[name] as FJSound;
			
			return sound.sound.length;
		}
		
		public function setMasterVolume( volume:Number, fadeLenght:Number = 0 ):void
		{
			_masterVolume = volume;
			
			refreshVolumes();
		}
		
		public function getMasterVolume():Number
		{
			return _masterVolume;
		}
		
		public function mute():void
		{
			_isMuted = true;
			
			refreshVolumes();
		}
		
		public function unmute():void
		{
			_isMuted = false;
			
			refreshVolumes();
		}
		
		private function refreshVolumes():void
		{
			var sound:FJSound;
			
			for (var i:int = 0; i < _sounds.length; i++) 
			{
				sound = _sounds[i] as FJSound;
				setSoundVolume( sound.name, sound.volume );
			}
		}
	}
}