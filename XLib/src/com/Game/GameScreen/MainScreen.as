package com.Game.GameScreen
{
	import com.Game.Globel.Constants;
	import com.core.Common.ScreenManager;
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
			btnMainMenu.validate();
			btnMainMenu.addEventListener(Event.TRIGGERED, onTriggeredMain);
			btnMainMenu.x = (Constants.STAGE_WIDTH - Constants.STAGE_WIDTH*0.15);
			btnMainMenu.y = (Constants.STAGE_HEIGHT - Constants.STAGE_HEIGHT*0.1);
			addChild(btnMainMenu);
//			ScreenManager.getTextureByBLock("Dog",getTextureByBLockCompl);
		}
		
//		private function getTextureByBLockCompl(t:Texture):void
//		{
//			btnMainMenu.defaultIcon = new Image(t);
//			btnMainMenu.x = (Constants.STAGE_WIDTH - btnMainMenu.defaultIcon.width);
//			btnMainMenu.y = (Constants.STAGE_HEIGHT - btnMainMenu.defaultIcon.height);
//		}
		
		private function onTriggeredMain(event:Event):void
		{
			ScreenManager.showScreen(Constants.SCREEN_SCENE_STATE_TEST);
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
		}
		
		
	}
}