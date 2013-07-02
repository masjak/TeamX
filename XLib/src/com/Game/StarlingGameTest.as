package com.Game
{
	import com.Game.Common.CameraManager;
	import com.Game.Common.Constants;
	import com.Game.Common.ScreenManager;
	import com.Game.Common.Singleton;
	import com.Game.GameUI.WelcomeUI;
	import com.core.TileMap.TileMap;
	import com.core.TileMap.TileScene;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.system.System;
	import flash.utils.getTimer;
	
	import Test.Scene.ResManager;
	
	import dragonBones.Armature;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class StarlingGameTest extends Sprite
	{
		private var knight:Armature;
		private var cyborg:Armature;
		private var dargon:Armature;
		
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		protected var btnMap:Button;
		
		public function StarlingGameTest()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			theme = new MetalWorksMobileTheme(this.stage);
			
			// 初始化屏幕管理
			ScreenManager.init();
			addChild(ScreenManager.screenNavigator);
			init();
		}
		
		private function init():void 
		{
//			addscene();
			
			Constants.STAGE_WIDTH = this.stage.stageWidth;
			Constants.STAGE_HEIGHT = this.stage.stageHeight;
			
			var btnOpen:Button = new Button();
			btnOpen.label = "打开相册";
			addChild(btnOpen);
			btnOpen.addEventListener(Event.TRIGGERED, onTriggeredOpen);
			btnOpen.y = (Constants.STAGE_HEIGHT - btnOpen.height)/2;
			btnOpen.x = (Constants.STAGE_WIDTH - btnOpen.width)/2;
			btnOpen.validate();
			addChild(btnOpen);
			
			btnMap = new Button();
			btnMap.label = "测试加载";
			addChild(btnMap);
			btnMap.addEventListener(Event.TRIGGERED, onTriggeredMap);
			btnMap.x = btnOpen.width +10;
			btnMap.validate();
			addChild(btnMap);
		}
		
		private function onTriggeredMap(event:Event):void
		{
			var scene:TileScene = new TileScene;
//			scene.scaleX = scene.scaleY = 0.3;
			addChild(scene);
		}
		
		private function onTriggeredOpen(event:Event):void
		{
			if(ScreenManager.screenNavigator.activeScreenID != "Welcome")
			{
				ScreenManager.screenNavigator.showScreen("Welcome");
			}
			else
			{
				ScreenManager.screenNavigator.clearScreen();
			}
		}
		
		private function addscene():void 
		{	
			ResManager.initBlock();
			for(var i:int = 0; i < 10; i++)
			{
				var name:String = "block" + (i%7 +1);
				var img:Image = ResManager.getImageByName(name);
				img.x = 100*i;
				addChild(img);
			}
		}
	}
}