package com.Game
{
	import com.Game.Common.Constants;
	import com.Game.Common.ScreenManager;
	import com.Game.Common.Singleton;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;

	public class GameScreenLayer extends Sprite
	{
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		
		public function GameScreenLayer()
		{
			init();
		}
		
		public function init():void
		{
			theme = new MetalWorksMobileTheme(Singleton.screen,false);
			addChild(Singleton.screen);
			
			// 初始化完成之后 通知主屏幕
			Singleton.signal.dispatchSignal(Constants.SIGNAL_STARLING_INIT,null);
			
			// 显示第一个界面
			ScreenManager.showScreen(Constants.SCREEN_WELCOME);
		}
	}
}