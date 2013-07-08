package com.Game
{
	import com.Game.Common.Constants;
	import com.Game.Common.SceneManager;
	import com.Game.Common.ScreenManager;
	import com.Game.Common.Singleton;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingGame extends Sprite
	{	
//		/**主舞台*/
//		protected var gameStage:GameStage;
		
		public function StarlingGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			init();
		}
		
		private function init():void 
		{
			// 初始化常量数据
			Constants.init();
			// 始化屏幕管理
			ScreenManager.init();
			// 初始化场景数据
			SceneManager.init();

			addChild(GameStage.instance);
		
		}
		
		
	}
}