package com.Game.Globel
{
	import com.Game.GameScreen.HeaderScreenTest;
	import com.Game.GameScreen.PhotoTestScreen;
	import com.Game.GameScreen.SceneStateTest;
	import com.Game.GameScreen.WelcomeScreen;
	import com.core.Common.ScreenManager;
	import com.core.Common.Singleton;
	
	import flash.filesystem.File;
	
	import feathers.controls.ScreenNavigatorItem;
	import feathers.dragDrop.DragData;
	
	import starling.errors.AbstractClassError;

	public class Constants
	{
		//抽象类 不用具化
		public function Constants(){ throw new AbstractClassError(); }
		
		/***********************可配置变量****************/
		public static var SCENE_ZOOM_MAX:Number  = 1.5;// 场景X方向最大缩放
		public static var SCENE_MASK_COLOR:uint  = 0x0b0c18;// 场景夜晚遮罩颜色
		public static var SCENE_MASK_APHLA:Number  = 0.55;// 场景夜晚遮罩透明度
		public static var GAME_RES_TYPE:String = "atf";		// 游戏使用的资源类型
		public static var GAME_PING_DELAY:int = 5000;		// ping 的间隔
		
		/***********************游戏公有的变量***************/
		
		public static var DRAG_DATA:DragData = new DragData();
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
				_resRoot = File.applicationDirectory.resolvePath("asset").url;
			}
			else  if(Singleton.platform.Platform == Constants.PLATFORM_IOS)
			{
				_resRoot = File.applicationDirectory.resolvePath("asset").url;
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
//			readXml();
			
			ScreenManager.screenNavigator;
			ScreenManager.addScreen(SCREEN_WELCOME,new ScreenNavigatorItem(WelcomeScreen));
			ScreenManager.addScreen(SCREEN_PHOTO_TEST,new ScreenNavigatorItem(PhotoTestScreen));
			ScreenManager.addScreen(SCREEN_HEAD_TEST,new ScreenNavigatorItem(HeaderScreenTest));
			ScreenManager.addScreen(SCREEN_SCENE_STATE_TEST,new ScreenNavigatorItem(SceneStateTest));
		}
		
		/**加载全局配置表*/
		public static function  readXml(xml:XML):void
		{
			SCENE_ZOOM_MAX  		= xml.SCENE_ZOOM_MAX;
			SCENE_MASK_COLOR  		= xml.SCENE_MASK_COLOR;
			SCENE_MASK_APHLA  		=  xml.SCENE_MASK_APHLA;
			GAME_RES_TYPE 				=  xml.GAME_RES_TYPE;
			GAME_PING_DELAY 			=  xml.GAME_PING_DELAY;
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
		public static const SIGNAL_STARLING_INIT:String = "StarlingInit";// starling 初始化完毕
		public static const SIGNAL_SCENE_CREATE_COMPLETE:String = "SceneCreateCompele";// 创建场景完毕
		
		/***********************场景的状态*****************/
		public static const SCENE_STATE_DAY:int = 1;			// 白天
		public static const SCENE_STATE_NIGHT:int = 2;		// 晚上
		
		/***********************点击效果*****************/
		public static const CLICK_EFFECT_SHAKE:int = 1;			// 抖动

		/***********************建筑的事件类型*****************/
		public static const BUILDER_EVENT_TYPE_FIXED:int = 1;			// 固定的
		public static const BUILDER_EVENT_TYPE_FREE:int = 2;			// 自由的
		public static const BUILDER_EVENT_TYPE_DESTORY:int = 4;	// 可被攻击的
		public static const BUILDER_EVENT_TYPE_NODESTORY:int = 8;// 不可被攻击的
		
		/***********************建筑类型*****************/
		public static const BUILDER_FUNCTION_TYPE_DRAGON_FORCE:String = "dragonForce";// 龙穴
		public static const BUILDER_FUNCTION_TYPE_MAGIC_CENTER:String = "magicCenter";			// 魔法研究所
		public static const BUILDER_FUNCTION_TYPE_TRAIN_HP:String = "trainHp";			//耐力训练
		public static const BUILDER_FUNCTION_TYPE_TRAIN_ATTACK:String = "trainAttack";			// 战斗训练营
		public static const BUILDER_FUNCTION_TYPE_PRAY_CENTER:String = "prayCenter";			// 祈祷神殿
		public static const BUILDER_FUNCTION_TYPE_HOUSE:String = "house";			// 民居
		public static const BUILDER_FUNCTION_TYPE_PET_CENTER:String = "petCenter";			// 战争神殿
		public static const BUILDER_FUNCTION_TYPE_SUMMON_CENTER:String = "summonCenter";			// 召唤之门
		public static const BUILDER_FUNCTION_TYPE_INCOME_BUILD:String = "incomeBuild";			// 酒馆
		public static const BUILDER_FUNCTION_TYPE_TOWER:String = "tower";			// 箭塔
		public static const BUILDER_FUNCTION_TYPE_WALL:String = "wall";			// 城墙
		public static const BUILDER_FUNCTION_TYPE_TREASURY:String = "treasury";			// 宝库
		public static const BUILDER_FUNCTION_TYPE_SHOP:String = "shop";			// 商店
		
		/***********************建筑类型*****************/
		public static const BUILDER_RESOURCE_TYPE_GOLD:String = "gold";			// 金币
		public static const BUILDER_RESOURCE_TYPE_ENERGY:String = "magicEnergy";			// 能源
		
		
		
		
		
	}
}