package com.Game.Common
{
	import com.Game.GameScreen.HeaderScreenTest;
	import com.Game.GameScreen.PhotoTestScreen;
	import com.Game.GameScreen.WelcomeScreen;
	
	import flash.filesystem.File;
	
	import feathers.controls.ScreenNavigatorItem;
	
	import starling.errors.AbstractClassError;

	public class Constants
	{
		//抽象类 不用具化
		public function Constants(){ throw new AbstractClassError(); }
		
		
		/**舞台宽*/		
		public static var STAGE_WIDTH:int  = 800;
		/**舞台高*/
		public static var STAGE_HEIGHT:int = 600;
		/**获取资源路径*/
		private static var _resRoot:String;
		public static function get resRoot():String
		{
			if(Singleton.platform.Platform == Constants.PLATFORM_MAC)
			{
				_resRoot = "/Users/mf02/workplace/XLib/TeamX/TeamX_Moblie/src/asset";
			}
			else if(Singleton.platform.Platform == Constants.PLATFORM_WINDOW)
			{
				// home 开发环境
				_resRoot = "F:/workpath/work/XLib/TeamX/TeamX_Moblie/sr/asset";
				// MF开发环境
				_resRoot = "F:/workPath/work/TeamX/trunk/TeamX_Moblie/src/asset";
			}
			else  if(Singleton.platform.Platform == Constants.PLATFORM_IOS)
			{
				_resRoot = File.applicationDirectory.resolvePath("asset").nativePath;
			}
			else  if(Singleton.platform.Platform == Constants.PLATFORM_ANDROID)
			{
				_resRoot = File.applicationDirectory.resolvePath("asset").nativePath;
			}
			return _resRoot;
		}
		
		public static function  init():void
		{
			ScreenManager.screenNavigator;
			ScreenManager.addScreen(SCREEN_WELCOME,new ScreenNavigatorItem(WelcomeScreen));
			ScreenManager.addScreen(SCREEN_PHOTO_TEST,new ScreenNavigatorItem(PhotoTestScreen));
			ScreenManager.addScreen(SCREEN_HEAD_TEST,new ScreenNavigatorItem(HeaderScreenTest));
		}
		/***********************静态常量配置 UISCREEN屏幕*****************/
		public static const SCREEN_WELCOME:String = "Welcome";
		public static const SCREEN_PHOTO_TEST:String = "PhotoTest";
		public static const SCREEN_HEAD_TEST:String = "HeadTest";
		
		
		/***********************游戏运行平台类型*****************/
		public static const PLATFORM_UNKNOW:int = 0;
		public static const PLATFORM_ANDROID:int = 1;
		public static const PLATFORM_IOS:int = 2;
		public static const PLATFORM_WINDOW:int = 3;
		public static const PLATFORM_MAC:int = 4;
		
		
		/***********************静态常量配置 信号事件*****************/
		public static const SIGNAL_STARLING_INIT:String = "StarlingInit";
		
		
		
		
		
		
		
	}
}