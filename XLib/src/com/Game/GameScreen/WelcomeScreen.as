package com.Game.GameScreen
{
	import com.Game.Common.Constants;
	import com.Game.Common.SceneManager;
	import com.Game.Common.ScreenManager;
	import com.core.Basic.XScene;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class WelcomeScreen extends Screen
	{
		
		protected var btnMap:Button;
		protected var btnOpen:Button;
		protected var btnClose:Button;
		
		
		public function WelcomeScreen()
		{
			super();
			init();
		}
		
		
		
		public function init():void 
		{
			// 初始化按钮
			btnOpen = new Button();
			btnOpen.label = "打开相册";
			addChild(btnOpen);
			btnOpen.addEventListener(Event.TRIGGERED, onTriggeredOpen);
			btnOpen.y = (Constants.STAGE_HEIGHT - btnOpen.height)/2;
			btnOpen.x = (Constants.STAGE_WIDTH - btnOpen.width)/2;
			btnOpen.validate();
			addChild(btnOpen);
			
			btnMap = new Button();
			btnMap.label = "地图测试";
			addChild(btnMap);
			btnMap.addEventListener(Event.TRIGGERED, onTriggeredMap);
			btnMap.x = btnOpen.width +10;
			btnMap.validate();
			addChild(btnMap);

			btnClose = new Button();
			btnClose.label = "关闭";
			addChild(btnClose);
			btnClose.addEventListener(Event.TRIGGERED, onTriggeredClose);
			btnClose.x =600;
			addChild(btnClose);
			
			
		}
		
		private function onTriggeredMap(event:Event):void
		{
			
		} 
		
		private function onTriggeredOpen(event:Event):void
		{	
			ScreenManager.showScreen(Constants.SCREEN_PHOTO_TEST);
		}
		
		private function onTriggeredClose(event:Event):void
		{
			ScreenManager.clearScreen();
		}
		
		
		override public function dispose():void
		{
			
		}
		
	}
}