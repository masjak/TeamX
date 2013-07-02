package com.Game.Common
{
	import com.Game.GameUI.WelcomeUI;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;

	public class ScreenManager 
	{
		protected static var _navigator:ScreenNavigator;
		
		public function ScreenManager()
		{
		}
		
		
		public static function init():void
		{
			addScreen("Welcome",new ScreenNavigatorItem(WelcomeUI));
		}
		
		public static function addScreen(id:String, item:ScreenNavigatorItem):void
		{
			ScreenManager.screenNavigator.addScreen(id,item);
		}
		
		public static function showScreen(id:String):void
		{
			ScreenManager.screenNavigator.showScreen(id);
		}
		
		public static function removeScreen(id:String):void
		{
			ScreenManager.screenNavigator.removeScreen(id);
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