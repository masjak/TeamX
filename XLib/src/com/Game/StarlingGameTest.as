package com.Game
{
	import com.Game.Common.Constants;
	import com.Game.Common.ScreenManager;
	import com.Game.Common.Singleton;
	import com.core.TileMap.TileScene;
	
	import Test.Scene.ResManager;
	
	import feathers.controls.Button;
	import feathers.themes.MetalWorksMobileTheme;
	
	import org.osflash.signals.events.GenericEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingGameTest extends Sprite
	{	
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
			
			init();
		}
		
		private function init():void 
		{
			// 初始化屏幕管理
			ScreenManager.init();
			addChild(ScreenManager.screenNavigator);
			
			
			
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
			Singleton.signal.addSignal("test",this);
			Singleton.signal.registerSignalListener("test",signalTest)
			
			if(ScreenManager.screenNavigator.activeScreenID != "Welcome")
			{
				ScreenManager.screenNavigator.showScreen("Welcome");
			}
			else
			{
				ScreenManager.screenNavigator.clearScreen();
			}
		}
		
		private function signalTest(e:GenericEvent,o:Object):void
		{
			
			trace("捕捉到回调");
			
		}
		
		
	}
}