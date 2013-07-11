/**
 * 可以传递自定义数据的Loader
 */ 
package com.core.loader
{
	import flash.display.Loader;
	
	public class XLoader extends Loader
	{
		/**
		 * 自定义数据的传递
		 */ 
		private var _data:*;
		public function XLoader()
		{
			super();
		}
		
		/**
		 * 挂载在Loader内部的自定义数据
		 */ 
		public function set data(d:*):void
		{
			_data = d;
		}
		
		/**
		 * 挂载在Loader内部的自定义数据
		 */
		public function get data():*
		{
			return _data;
		}
	}
}