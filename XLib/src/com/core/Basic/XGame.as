package com.core.Basic
{
	import com.core.Common.Constants;
	import com.core.Common.SceneManager;
	import com.core.Common.ScreenManager;
	import com.core.Common.Singleton;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class XGame extends Sprite
	{	
//		/**主舞台*/
		protected var xStage:XStage;
		
		public function XGame()
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
			
			xStage =new XStage;
			addChild(xStage);
		
		}
		
		
	}
}