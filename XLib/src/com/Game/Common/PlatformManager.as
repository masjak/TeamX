package com.Game.Common
{
	import flash.system.Capabilities;

	/**
	 * 平台管理
	 * @author haog 2013-06-26
	 * 
	 */	
	
	public class PlatformManager implements IDispose
	{
		public static const PLATFORM_UNKNOW:int = 0;
		public static const PLATFORM_ANDROID:int = 1;
		public static const PLATFORM_IOS:int = 2;
		public static const PLATFORM_WINDOW:int = 3;
		public static const PLATFORM_MAC:int = 4;
		
		public function PlatformManager()
		{
		}
		
		/**是否是DEBG模式*/		
		public function get Debug():Boolean
		{
			return Capabilities.isDebugger;
		}
		
		/**获取当前运行平台*/
		public function get Platform():int
		{
			var strOS:String = Capabilities.manufacturer;
			if(strOS.indexOf("iOS") != -1)
			{
				return PLATFORM_IOS;
			}
			else if(strOS.indexOf("Windows") != -1)
			{
				return PLATFORM_WINDOW;
			}
			else if(strOS.indexOf("Macintosh") != -1)
			{
				return PLATFORM_MAC;
			}
			else if(strOS.indexOf("Android") != -1)
			{
				return PLATFORM_ANDROID;
			}
			
			return PLATFORM_UNKNOW;
		}
		
		public function dispose():void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		
	}
}