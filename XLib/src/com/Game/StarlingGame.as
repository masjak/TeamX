package com.Game
{
	import com.Game.Common.Singleton;
	import com.core.Utils.File.OpenFile;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import assets.AssetsManager;
	
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.factorys.StarlingFactory;
	import dragonBones.utils.dragonBones_internal;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	
	public class StarlingGame extends Sprite
	{
		private var knight:Armature;
		private var cyborg:Armature;
		private var dargon:Armature;
		public function StarlingGame()
		{
			DragonInit();
			
			var factory:StarlingFactory = Singleton.starlingFactory;
			
//			factory.parseData(new AssetsManager.KnightData());
//			factory.parseData(new AssetsManager.CyborgData());
//			factory.parseData(new AssetsManager.DragonData());
			factory.addEventListener(Event.COMPLETE, textureCompleteHandler);
			
//			OpenFile.write(new AssetsManager.ResourcesData(),File.applicationDirectory.nativePath + "/ResourcesData.bin");
			test();
		}
		
		private function textureCompleteHandler(e:Event):void 
		{
			var factory:StarlingFactory = Singleton.starlingFactory;
//			knight = factory.buildArmature("knight");
//			knight.display.x = 350;
//			knight.display.y = 400;
//			knight.animation.gotoAndPlay("run");
//			addChild(knight.display as Sprite);
//
//			// 换装
//			var _bone:Bone = knight.getBone("clothes"); 
////			_bone.display.dispose();
////			_bone.display = _image;
//			
//			cyborg = factory.buildArmature("cyborg");
//			cyborg.display.x = 550;
//			cyborg.display.y = 400;
//			cyborg.animation.gotoAndPlay("run");
//			addChild(cyborg.display as Sprite);
			
			for(var i:int = 0; i < 100; i++)
			{
//				var dargon:Armature= factory.buildArmature("Dragon");
//				dargon.display.x = 20*i;
////				dargon.display.y = 400;
//				dargon.display.scaleX = dargon.display.scaleY = 0.25;
//				dargon.animation.gotoAndPlay("walk");
//				addChild(dargon.display as Sprite);
//				WorldClock.clock.add(dargon);
			}
			
//			dargon = factory.buildArmature("Dragon");
//			dargon.display.x = 200;
//			dargon.display.y = 400;
//			dargon.display.scaleX = -1;
//			dargon.animation.gotoAndPlay("walk");
//			addChild(dargon.display as Sprite);
			
//			WorldClock.clock.add(knight);
			WorldClock.clock.add(cyborg);
			WorldClock.clock.add(dargon);
			
			
		}
		
		
		private function DragonInit():void 
		{	
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
			
			function onEnterFrameHandler(_e:EnterFrameEvent):void 
			{
				WorldClock.clock.advanceTime(-1);
			}
		}
		
		private function test():void 
		{
			addscene();
		}

		private function addscene():void 
		{
//			for(var i:int = 0; i < 100; i++)
//			{
//				var img:Image = new Image(Texture.fromBitmap(new AssetsManager.ZombieData()));
//				img.x = i;
//				addChild(img);
//			}
//			
//			
//			var img:Image = new Image(Texture.fromBitmap(new AssetsManager.ZombieData()));
//			addChild(img);
			
			
		}
	}
}