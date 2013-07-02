package com.Game.Common
{
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
				_resRoot = "/Users/mf02/workplace/XLib/TeamX/Resouce";
			}
			else if(Singleton.platform.Platform == PlatformManager.PLATFORM_WINDOW)
			{
				_resRoot = "F:/工作路径/work/XLib/Resouce";
			}
			else
			{
				_resRoot = "https://github.com/haog/TeamX/blob/master/Resouce";
			}
			return _resRoot;
		}
		
		
	}
}