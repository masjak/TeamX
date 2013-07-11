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
	public class XStage extends Sprite
	{
		/**舞台实例*/	
		protected static var inst:XStage;
		
		/**场景层*/	
		protected var _world:XWorld;
		
		/**UI层*/	
		protected var _hud:XHud;
		
		/**feathers UI 主题 */		
		protected var theme:MetalWorksMobileTheme;
		
		public function XStage()
		{
			super();
			inst = this;
			_world = new XWorld;
			_hud = new XHud;
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
			
			// 场景层在最下面 UI在最上面
			addChild(_world);
			addChild(_hud);
		}
		
		/**获取场景层*/		
		public function get world():XWorld{return _world;}
		/**获取UI层*/		
		public function get hud():XHud{return _hud;}
		
		/**获取stage实例*/		
		public static function instance():XStage
		{
			return inst;
		}
		
		/**销毁*/		
		override public function dispose():void
		{
			if(_world != null)
			{
				_world.dispose();
				_world = null;
			}
			
			if(_hud != null)
			{
				_hud.dispose();
				_hud = null;
			}
		}
		
	}
}