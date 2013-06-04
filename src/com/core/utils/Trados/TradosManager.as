package com.knr.utils.Trados
{
	/**
	 * 本地化字符管理工具
	 * @author haog
	 * 2013-5-23
	 */	

	public class TradosManager
	{
		public function TradosManager()
		{
		}
		
		
		/**
		 * 格式化字符串
		 * @param format
		 * @param args
		 * @return 
		 * 
		 */		
		public static function formatString(format:String, ...args):String
		{
			for (var i:int=0; i<args.length; ++i)
			{
				format = format.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
				
			return format;
		}
		
	}
}