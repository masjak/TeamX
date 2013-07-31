package com.core.Basic
{
	import com.core.Common.Constants;
	import com.core.Common.Singleton;
	import com.Game.GameScreen.MainScreen;
	
	import starling.display.Sprite;

	public class XHud extends Sprite
	{
		protected var _mainScreen:MainScreen;
		public function XHud()
		{
			init();
		}
		
		public function init():void
		{
			
			_mainScreen = new MainScreen;
			addChild(mainScreen);
			addChild(Singleton.screen);
			
			// 初始化完成之后 通知主屏幕
			Singleton.signal.dispatchSignal(Constants.SIGNAL_STARLING_INIT,null);
			
			// 显示第一个界面
//			ScreenManager.showScreen(Constants.SCREEN_WELCOME);
		}	

		public function get mainScreen():MainScreen
		{
			return _mainScreen;
		}

	}
}