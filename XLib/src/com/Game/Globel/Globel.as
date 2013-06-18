package com.Game.Globel
{
	import flash.events.Event;
	
	import dragonBones.animation.WorldClock;
	import dragonBones.factorys.StarlingFactory;
	
	import starling.events.EnterFrameEvent;

	/**
	 * 全局设定管理器
	 * @author haog 2013-06-17
	 * 
	 */	
	
	public class Globel
	{
		/***Globel 实例对象 的对象管理器 */
		private static var instance:Globel;
		
		/***dragonbones 的对象管理器 */		
		private var _factory:StarlingFactory;
		
		public function Globel()
		{
			init();
		}
		
		/***获取Globel 实例对象 */
		public static function instacne():Globel
		{
			if(instance == null)
			{
				instance = new Globel();
			}
			return instance;
		}
		
		public function init():void
		{
			factory = new StarlingFactory();
		}

		public function get factory():StarlingFactory
		{
			return _factory;
		}

		public function set factory(value:StarlingFactory):void
		{
			_factory = value;
		}

		
	}
}