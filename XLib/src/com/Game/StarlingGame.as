package com.Game
{
	import com.Game.Common.Constants;
	import com.Game.Common.ScreenManager;
	import com.Game.Common.Singleton;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingGame extends Sprite
	{	
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		
		public function StarlingGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			theme = new MetalWorksMobileTheme(this.stage);
			
			init();
		}
		
		private function init():void 
		{
			// 初始化屏幕管理
			Constants.init();
			addChild(Singleton.screen);
		
			// 调整舞台宽高
			Constants.STAGE_WIDTH = this.stage.stageWidth;
			Constants.STAGE_HEIGHT = this.stage.stageHeight;
			
			// 初始化完成之后 通知主屏幕
			Singleton.signal.dispatchSignal(Constants.SIGNAL_STARLING_INIT,null);
			
			// 显示第一个界面
			ScreenManager.showScreen(Constants.SCREEN_WELCOME);
		}
		
		
	}
}