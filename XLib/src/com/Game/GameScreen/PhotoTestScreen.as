package com.Game.GameScreen
{
	import com.core.Common.CameraManager;
	import com.Game.Globel.Constants;
	import com.core.Common.ScreenManager;
	import com.core.Common.Singleton;
	
	import flash.display.Bitmap;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class PhotoTestScreen extends Screen
	{
		
		private var btnOpen:Button;
		private var btnCarema:Button;
		private var btnCanel:Button;
		private var btnClose:Button;
		
		private var img:Image;
		
		public function PhotoTestScreen()
		{
			super();
			init();
		}
		
		
		
		private function init():void 
		{
			// 初始化按钮
			btnOpen = new Button();
			btnOpen.label = "相册";
			btnOpen.validate();
			addChild(btnOpen);
			btnOpen.addEventListener(Event.TRIGGERED, onTriggeredOpen);
			btnOpen.y = (Constants.STAGE_HEIGHT - btnOpen.height)/2;
			
			btnCarema = new Button();
			btnCarema.label = "相机";
			btnCarema.validate();
			addChild(btnCarema);
			btnCarema.addEventListener(Event.TRIGGERED, onTriggeredCarema);
			btnCarema.y = (Constants.STAGE_HEIGHT - btnCarema.height)/2;
			btnCarema.x = 100;
			
			btnCanel = new Button();
			btnCanel.label = "清除相册";
			btnCanel.addEventListener(Event.TRIGGERED, onTriggeredCancle);
			btnCanel.y = (Constants.STAGE_HEIGHT - btnCanel.height)/2;
			btnCanel.x = (Constants.STAGE_WIDTH - btnCanel.width)/2;
			btnCanel.validate();
			addChild(btnCanel);
			
			btnClose = new Button();
			btnClose.label = "关闭";
			btnClose.validate();
			btnClose.addEventListener(Event.TRIGGERED, onTriggeredClose);
			addChild(btnClose);
			btnClose.x = (Constants.STAGE_WIDTH - btnClose.width)/2;

		}
		
		private function onTriggeredOpen(event:Event):void
		{
			// 测试相册功能
			OpenCameraPhoto();
		}
		
		private function onTriggeredCarema(event:Event):void
		{			
			// 测试拍照功能
			OpenCamera();
		}
		
		
		
		private function onTriggeredCancle(event:Event):void
		{
			this.removeChild(img,true);
		}
		
		private function onTriggeredClose(event:Event):void
		{
			ScreenManager.screenNavigator.showScreen(Constants.SCREEN_WELCOME);
			
		}
		
		private function OpenCameraPhoto():void 
		{
			var c:CameraManager = Singleton.camera;
			if(c.isSupportsCaremaPhoto())
			{
				c.OpenCaremaPhoto(browseComplete);
			}
			function browseComplete(b:Bitmap):void
			{
				if(b.width > 2048 || b.height > 2048)
				{
					trace("图片尺寸过大！");
					return;
				}
				if(img != null)
				{
					img.removeFromParent(true);
				}
				img = new Image(Texture.fromBitmap(b));
				addChildAt(img,0);
			}
		}
		
		private function OpenCamera():void 
		{
			var c:CameraManager = Singleton.camera;
			if(c.isSupportsCarema())
			{
				c.OpenCarema(browseComplete);
			}
			function browseComplete(b:Bitmap):void
			{
				if(b.width > 2048 || b.height > 2048)
				{
					trace("图片尺寸过大！");
					return;
				}
				if(img != null)
				{
					img.removeFromParent(true);
				}
				img = new Image(Texture.fromBitmap(b));
				addChildAt(img,0);
			}
		}
		
		
		
	}
}