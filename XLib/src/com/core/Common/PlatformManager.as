package com.core.Common
{
	import flash.system.Capabilities;
	import com.Game.Globel.Constants;

	/**
	 * 平台管理
	 * @author haog 2013-06-26
	 * 
	 */	
	
	public class PlatformManager implements IDispose
	{
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
				return Constants.PLATFORM_IOS;
			}
			else if(strOS.indexOf("Windows") != -1)
			{
				return Constants.PLATFORM_WINDOW;
			}
			else if(strOS.indexOf("Macintosh") != -1)
			{
				return Constants.PLATFORM_MAC;
			}
			else if(strOS.indexOf("Android") != -1)
			{
				return Constants.PLATFORM_ANDROID;
			}
			
			return Constants.PLATFORM_UNKNOW;
		}
		
		public function dispose():void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		
	}
}