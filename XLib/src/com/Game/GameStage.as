package com.Game
{
	import feathers.themes.MetalWorksMobileTheme;
	
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
		private static var inst:GameStage;
		
		/**场景层*/	
		protected var gameScene:GameSceneLayer;
		
		/**UI层*/	
		protected var gameScreen:GameScreenLayer;
		
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		
		public function GameStage()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			theme = new MetalWorksMobileTheme(this);
			init();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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
		
		/**获取场景层*/		
		public function get scene():GameSceneLayer
		{
			return gameScene;
		}
		
		/**获取UI层*/		
		public function get screen():GameScreenLayer
		{
			return gameScreen;
		}
		
		/**获取stage实例*/		
		public static function get instance():GameStage
		{
			if(inst == null)
			{
				inst = new GameStage;
			}
			return inst;
		}
		
		/**销毁*/		
		override public function dispose():void
		{
			if(gameScene != null)
			{
				gameScene.dispose();
				gameScene = null;
			}
			
			if(gameScreen != null)
			{
				gameScreen.dispose();
				gameScreen = null;
			}
		}
		
	}
}