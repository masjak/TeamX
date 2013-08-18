package Test
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XSprite;
	import com.core.Common.Singleton;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	
	public class ParticleTest extends XSprite
	{
		private var mParticleSystems:Vector.<ParticleSystem>;
		private var mParticleSystem:ParticleSystem;
		
		public function ParticleTest()
		{
			super();
			init();
		}
		
		public function init():void
		{
//			mParticleSystems = new <ParticleSystem>[
//				new PDParticleSystem(drugsConfig, drugsTexture),
//				new PDParticleSystem(fireConfig, fireTexture),
//				new PDParticleSystem(sunConfig, sunTexture),
//				new PDParticleSystem(jellyConfig, jellyTexture)
//			];
			
//			var names:Array = [];
//			var len:int = names.length;
//			for(var i:int = 0; i < len; i++)
//			{
//				Singleton.assets.enqueue(names[i]);
//			}
			
			
			var ba:ByteArray = OpenFile.open(new File(Constants.resRoot + "/testRes/media/drugs.pex"));
			var xml:XML = new XML(ba);
			
			ba = OpenFile.open(new File(Constants.resRoot + "/testRes/media/drugs.png"));
//			var particle:ParticleSystem = new ParticleSystem(xml,ba);
				
//			Singleton.assets.loadQueue(onProgress);
//			function onProgress(r:Number):void
//			{
//				if(r == 1)
//				{
//					Singleton.assets.get
//				}
//				
//				
//			}
			
			
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		
		private function startNextParticleSystem():void
		{
			if (mParticleSystem)
			{
				mParticleSystem.stop();
				mParticleSystem.removeFromParent();
				Starling.juggler.remove(mParticleSystem);
			}
			
			mParticleSystem = mParticleSystems.shift();
			mParticleSystems.push(mParticleSystem);
			
			mParticleSystem.emitterX = 320;
			mParticleSystem.emitterY = 240;
			mParticleSystem.start();
			
			addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				mParticleSystem.emitterX = touch.globalX;
				mParticleSystem.emitterY = touch.globalY;
			}
		}
		
	}
}