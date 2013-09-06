package com.core.Common
{
	public class NetDataManager implements IDispose
	{
		protected static var _data:Object = {};
		public function NetDataManager()
		{
		}
		
		/**网络模块数据*/
		protected function get Data():Object {return _data;}
		
		
		
		public function dispose():void
		{
		}
	}
}