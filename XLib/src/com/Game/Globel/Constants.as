package com.Game.Globel
{
	import com.Game.GameScreen.HeaderScreenTest;
	import com.Game.GameScreen.PhotoTestScreen;
	import com.Game.GameScreen.SceneStateTest;
	import com.Game.GameScreen.WelcomeScreen;
	
	import flash.filesystem.File;
	
	import feathers.controls.ScreenNavigatorItem;
	
	import starling.errors.AbstractClassError;
	import com.core.Common.ScreenManager;
	import com.core.Common.Singleton;

	public class Constants
	{
		//抽象类 不用具化
		public function Constants(){ throw new AbstractClassError(); }
		
		/***********************可配置变量****************/
		public static var SCENE_ZOOM_MAX:Number  = 1.5;// 场景X方向最大缩放
		public static var SCENE_MASK_COLOR:uint  = 0x0b0c18;// 场景夜晚遮罩颜色
		public static var SCENE_MASK_APHLA:Number  = 0.55;// 场景夜晚遮罩透明度
		
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
				_resRoot = "E:/workpath/work/XLib/TeamX/TeamX_Moblie/src/asset";
				// MF开发环境
//				_resRoot = "F:/workplace/work/XLIB/trunk/TeamX_Moblie/src/asset";
			}
			else  if(Singleton.platform.Platform == Constants.PLATFORM_IOS)
			{
				_resRoot = File.applicationDirectory.resolvePath("asset").nativePath;
			}
			else  if(Singleton.platform.Platform == Constants.PLATFORM_ANDROID)
			{
				_resRoot = File.applicationDirectory.resolvePath("asset").url;
			}
			return _resRoot;
		}
		
		/**初始化常量配置*/		
		public static function  init():void
		{
			loadConfig();
			
			ScreenManager.screenNavigator;
			ScreenManager.addScreen(SCREEN_WELCOME,new ScreenNavigatorItem(WelcomeScreen));
			ScreenManager.addScreen(SCREEN_PHOTO_TEST,new ScreenNavigatorItem(PhotoTestScreen));
			ScreenManager.addScreen(SCREEN_HEAD_TEST,new ScreenNavigatorItem(HeaderScreenTest));
			ScreenManager.addScreen(SCREEN_SCENE_STATE_TEST,new ScreenNavigatorItem(SceneStateTest));
		}
		
		/**加载全局配置表*/
		public static function  loadConfig():void
		{
			// 加载全局配置xml
		}
		
		/***********************静态常量配置 UISCREEN屏幕*****************/
		public static const SCREEN_WELCOME:String = "Welcome";
		public static const SCREEN_PHOTO_TEST:String = "PhotoTest";
		public static const SCREEN_HEAD_TEST:String = "HeadTest";
		public static const SCREEN_SCENE_STATE_TEST:String = "SceneStateTest";
		
		/***********************游戏运行平台类型*****************/
		public static const PLATFORM_UNKNOW:int = 0;
		public static const PLATFORM_ANDROID:int = 1;// 安卓平台
		public static const PLATFORM_IOS:int = 2;			// IOS平台
		public static const PLATFORM_WINDOW:int = 3;// window平台
		public static const PLATFORM_MAC:int = 4;		// mac平台
		
		
		/***********************静态常量配置 信号事件*****************/
		public static const SIGNAL_STARLING_INIT:String = "StarlingInit";
		
		
		/***********************场景的状态*****************/
		public static const SCENE_STATE_DAY:int = 1;			// 白天
		public static const SCENE_STATE_NIGHT:int = 2;			// 晚上
		
		
	}
}