package com.Game.Common
{
	import dragonBones.factorys.StarlingFactory;
	
	import starling.utils.AssetManager;
	import starling.utils.ScaleMode;

	/**
	 * 单例管理器
	 * @author haog 2013-06-17
	 * 
	 */	
	
	public class Singleton
	{
		/***平台管理 实例对象  */
		private static var _platform:PlatformManager;
		
		/***dragonbones 的对象 */		
		private static var _factory:StarlingFactory;
		
		/***资源管理 对象 */		
		private static var _asset:AssetManager;
		
		public function Singleton()
		{
			
		}
		
		/***获取平台管理 实例对象 */
		public static function get platform():PlatformManager
		{
			if(_platform == null)
			{
				_platform = new PlatformManager();
			}
			return _platform;
		}
		
		/***dragonbones 的对象创建器 */
		public static function get starlingFactory():StarlingFactory
		{
			if(_factory == null)
			{
				_factory = new StarlingFactory();
			}
			return _factory;
		}

		/***dragonbones 的对象创建器 */
		public static function get assets():AssetManager
		{
			if(_asset == null)
			{
				var scaleFactor:int = Constants.STAGE_WIDTH < 480 ? 1 : 2; // midway between 320 and 640
				_asset = new AssetManager(scaleFactor);
			}
			return _asset;
		}
		
		/***销毁 */
		public static function dispose():void
		{
			_platform = null;
			_factory = null;
		}
		
	}
}