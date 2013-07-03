package com.Game.Common
{
	import flash.filesystem.File;
	
	import starling.errors.AbstractClassError;

	public class Constants
	{
		//抽象类 不用具化
		public function Constants(){ throw new AbstractClassError(); }
//		public static const S
		
		
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
		
		
	}
}