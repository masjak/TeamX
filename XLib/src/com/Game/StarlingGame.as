package com.Game
{
	import com.core.Utils.File.OpenFile;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import Assets.AssetsManager;
	
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.factorys.StarlingFactory;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	public class StarlingGame extends Sprite
	{
		
		private var factory:StarlingFactory;
		private var knight:Armature;
		private var cyborg:Armature;
		private var dargon:Armature;
		public function StarlingGame()
		{
			DragonInit();

			
//			var file:File = new File(File.applicationDirectory.nativePath + "/KnightData.bin");
//			var b:ByteArray = OpenFile.open(file);
//			factory.parseData(b);
//			
//			factory.parseData(new AssetsManager.CyborgData());
//			
//			file = new File(File.applicationDirectory.nativePath + "/ResourcesData.bin");
//			b= OpenFile.open(file);
//			
//			factory.parseData(b);
			
			
//			OpenFile.write(new AssetsManager.ResourcesData(),File.applicationDirectory.nativePath + "/ResourcesData.bin");
			test();
		}
		
		private function textureCompleteHandler(e:Event):void 
		{
			knight = factory.buildArmature("knight");
			knight.display.x = 350;
			knight.display.y = 400;
			knight.animation.gotoAndPlay("run");
			addChild(knight.display as Sprite);

			// 换装
			var _bone:Bone = knight.getBone("clothes"); 
//			_bone.display.dispose();
//			_bone.display = _image;
			
			cyborg = factory.buildArmature("cyborg");
			cyborg.display.x = 550;
			cyborg.display.y = 400;
			cyborg.animation.gotoAndPlay("run");
			addChild(cyborg.display as Sprite);
			
			
			dargon = factory.buildArmature("Dragon");
			dargon.display.x = 200;
			dargon.display.y = 400;
			dargon.display.scaleX = -1;
			dargon.animation.gotoAndPlay("walk");
			addChild(dargon.display as Sprite);
			
			WorldClock.clock.add(knight);
			WorldClock.clock.add(cyborg);
			WorldClock.clock.add(dargon);
			
			
		}
		
		
		private function DragonInit():void 
		{
			factory = new StarlingFactory();
			factory.addEventListener(Event.COMPLETE, textureCompleteHandler);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
			
			function onEnterFrameHandler(_e:EnterFrameEvent):void 
			{
				WorldClock.clock.advanceTime(-1);
			}
		}
		
		private function test():void 
		{
			packageRes(File.applicationDirectory.nativePath);
		}
		
		private function packageRes(path:String):void 
		{
			var file:File = new File(path);
			var files:Array = file.getDirectoryListing();
			for each (var f:File in files)
			{
				if(f.isDirectory)
				{
					packageRes(f.nativePath)
				}
				else
				{
					trace(f.nativePath);
				}
			}
			
		}
		
	}
}