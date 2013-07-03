package com.Game.Common
{
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
			if(Singleton.platform.Platform == PlatformManager.PLATFORM_MAC)
			{
				_resRoot = "/Users/mf02/workplace/XLib/TeamX/TeamX_Moblie/src/Resouce";
			}
			else if(Singleton.platform.Platform == PlatformManager.PLATFORM_WINDOW)
			{
				_resRoot = "F:/workpath/work/XLibTeamX/TeamX_Moblie/src/Resouce";
			}
			else
			{
				_resRoot = File.applicationDirectory.resolvePath("Resouce").nativePath;
			}
			return _resRoot;
		}
		
		public static function  init():void
		{
			ScreenManager.screenNavigator;
			ScreenManager.addScreen(Constants.SCREEN_WELCOME,new ScreenNavigatorItem(WelcomeScreen));
			ScreenManager.addScreen(Constants.SCREEN_PHOTO_TEST,new ScreenNavigatorItem(PhotoTestScreen));
		}
		
		
		
		/***********************静态常量配置 信号事件*****************/
		public static const SIGNAL_STARLING_INIT:String = "StarlingInit";
		
		
		
		
		
		/***********************静态常量配置 UISCREEN屏幕*****************/
		public static const SCREEN_WELCOME:String = "Welcome";
		public static const SCREEN_PHOTO_TEST:String = "PhotoTest";
		
	}
}