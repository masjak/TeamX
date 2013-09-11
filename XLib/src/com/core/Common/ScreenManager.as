package com.core.Common
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;

	public class ScreenManager 
	{
		protected static var _navigator:ScreenNavigator;
		
		public function ScreenManager()
		{
		}
		
		/** 初始化列表*/		
		public static function init():void
		{
			
		}
		
		
		public static function addScreen(id:String, item:ScreenNavigatorItem):void
		{
			_navigator.addScreen(id,item);
		}
		
		public static function showScreen(id:String):void
		{
			_navigator.showScreen(id);
		}
		
		public static function removeScreen(id:String):void
		{
			_navigator.removeScreen(id);
		}
		
		public static function clearScreen():void
		{
			_navigator.clearScreen();
		}
		
		public static function get screenNavigator():ScreenNavigator
		{
			if(_navigator == null)
			{
				_navigator = new ScreenNavigator;
			}
			return _navigator;
		}
		
		/** 释放资源*/
		public static function dispose():void
		{
			if(_navigator != null)
			{
				_navigator.clearScreen();
				_navigator.dispose();
				_navigator = null;
			}
			
		}
	}
}