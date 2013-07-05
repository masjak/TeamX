package com.Game
{
	import com.Game.Common.Constants;
	import com.Game.Common.ScreenManager;
	import com.Game.Common.Singleton;
	import com.Game.GameScreen.MainScreen;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;

	public class GameScreenLayer extends Sprite
	{
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		
		protected var _mainScreen:MainScreen;
		public function GameScreenLayer()
		{
			init();
		}
		
		public function init():void
		{
			theme = new MetalWorksMobileTheme(Singleton.screen);
			_mainScreen = new MainScreen;
			addChild(mainScreen);
			Singleton.screen.visible = false;
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