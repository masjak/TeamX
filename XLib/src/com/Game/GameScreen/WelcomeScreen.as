package com.Game.GameScreen
{
	import com.Game.Common.Constants;
	import com.Game.Common.SceneManager;
	import com.Game.Common.ScreenManager;
	import com.core.TileMap.TileScene;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class WelcomeScreen extends Screen
	{
		
		protected var btnMap:Button;
		protected var btnOpen:Button;
		
		private var img:Image;
		
		public function WelcomeScreen()
		{
			super();
			init();
			this.width = 400;
		}
		
		
		
		private function init():void 
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

		}
		
		private function onTriggeredMap(event:Event):void
		{
			var scene:TileScene = SceneManager.createTileScene("1");
			addChild(scene);
		}
		
		private function onTriggeredOpen(event:Event):void
		{	
			ScreenManager.screenNavigator.showScreen(Constants.SCREEN_PHOTO_TEST);
		}
		
	
		
		
		
	}
}