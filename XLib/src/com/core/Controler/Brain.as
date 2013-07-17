package com.core.Controler
{
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * 大脑。NPC控制器的行动控制中心
	 */ 
	public class Brain
	{
		protected var _ctrl:BaseControler;
		/**
		 * 上一次的思考时间
		 */ 
		private var _lastThink:uint;
		/**
		 * 思考速度
		 */ 
		private var _thinkSpeed:uint;
		
		public function Brain()
		{
			
		}
		
		/**
		 * 
		 */ 
		internal function set ctrl(ctrl:BaseControler):void
		{
			_ctrl = ctrl;
		}
		
		public function think():void
		{
			var t:uint = getTimer();
			if( t -_lastThink>_thinkSpeed)
			{
				_lastThink = t;
				run();
			}
		}
		
		protected function run():void
		{
			
		}
		
	}
}