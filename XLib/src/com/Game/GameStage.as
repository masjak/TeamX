package com.Game
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * 游戏总场景
	 * @author haog 2013-7-4
	 * 
	 */	
	public class GameStage extends Sprite
	{
		/**场景实例*/	
		protected var instance:GameStage;
		
		/**场景层*/	
		protected var gameScene:GameSceneLayer;
		
		/**UI层*/	
		protected var gameScreen:GameScreenLayer;
		
		public function GameStage()
		{
			super();
			if(instance != null)
			{
				instance.dispose();
			}
			instance = this;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			init();
		}
		
		/**初始化*/		
		public function init():void
		{
			gameScene = new GameSceneLayer;
			gameScreen = new GameScreenLayer;
			
			// 场景层在最下面 UI在最上面
			addChild(gameScene);
			addChild(gameScreen);
		}
	}
}