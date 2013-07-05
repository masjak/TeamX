package com.Game.GameScreen
{
	import com.Game.Common.Constants;
	import com.Game.Common.ScreenManager;
	import com.core.Utils.UtilImage;
	
	import flash.display.Bitmap;
	
	import feathers.controls.Button;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class MainScreen extends Sprite
	{
		protected var leftTop:Sprite;
		protected var rightTop:Sprite;
		protected var leftBottom:Sprite;
		protected var rightBottom:Sprite;
		
		protected var btnMainMenu:Button;
		public function MainScreen()
		{
			super();
			init();
		}
		
		public function init():void
		{
			this.width = Constants.STAGE_WIDTH;
			this.height = Constants.STAGE_HEIGHT;
			leftTop = new Sprite;
			rightTop = new Sprite;
			leftBottom = new Sprite;
			rightBottom = new Sprite;
			addChild(leftTop);
			addChild(rightTop);
			addChild(leftBottom);
			addChild(rightBottom);
			layout();
		}
		
		public function layout():void
		{
			btnMainMenu = new Button;
			btnMainMenu.label = "主菜单";
			btnMainMenu.addEventListener(Event.TRIGGERED, onTriggeredMain);
			addChild(btnMainMenu);
			ScreenManager.getTextureByBLock("Dog",getTextureByBLockCompl);
		}
		
		private function getTextureByBLockCompl(t:Texture):void
		{
			btnMainMenu.defaultIcon = new Image(t);
			btnMainMenu.x = (Constants.STAGE_WIDTH - btnMainMenu.defaultIcon.width);
			btnMainMenu.y = (Constants.STAGE_HEIGHT - btnMainMenu.defaultIcon.height);
		}
		
		private function onTriggeredMain(event:Event):void
		{
			ScreenManager.showScreen(Constants.SCREEN_WELCOME);
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
		}
		
		
	}
}