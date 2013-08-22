package com.core.Common
{
	import com.Game.Globel.Constants;
	
	import dragonBones.factorys.StarlingFactory;
	
	import feathers.controls.ScreenNavigator;
	
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
		
		/***相册相机管理 对象 */		
		private static var _camera:CameraManager;
		
		/***信号槽管理器 */		
		private static var _signal:SignalManager;
		
		/***建筑管理器 */		
		private static var _builders:BuilderManager;
		
		/***帧监听 */		
		private static var _enterFrame:EnterFrameManager;
		
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

		/***资源管理 对象 */
		public static function get assets():AssetManager
		{
			if(_asset == null)
			{
				var scaleFactor:int = Constants.STAGE_WIDTH < 480 ? 1 : 2; // midway between 320 and 640
				_asset = new AssetManager(scaleFactor);
			}
			return _asset;
		}
		
		/***相册相机管理 对象 */
		public static function get camera():CameraManager
		{
			if(_camera == null)
			{
				_camera = new CameraManager;
			}
			return _camera;
		}
		
		/***相册相机管理 对象 */
		public static function get signal():SignalManager
		{
			if(_signal == null)
			{
				_signal = new SignalManager;
			}
			return _signal;
		}
		
		/***屏幕场景管理 */
		public static function get screen():ScreenNavigator
		{
			
			return ScreenManager.screenNavigator;
		}
		
		/***建筑 对象 */
		public static function get builders():BuilderManager
		{
			if(_builders == null)
			{
				_builders = new BuilderManager;
			}
			return _builders;
		}
		
		/***建筑 对象 */
		public static function get enterFrame():EnterFrameManager
		{
			if(_enterFrame == null)
			{
				_enterFrame = new EnterFrameManager;
				_enterFrame.start();
			}
			return _enterFrame;
		}
		
		/***销毁 */
		public static function dispose():void
		{
			if(_platform != null)
			{
				_platform.dispose();
				_platform = null;
			}
			
			if(_factory != null)
			{
				_factory.dispose();
				_factory = null;
			}
			
			if(_asset != null)
			{
				_asset.dispose();
				_asset = null;
			}
			
			if(_camera != null)
			{
				_camera.dispose();
				_camera = null;
			}
			
			if(_signal != null)
			{
				_signal.dispose();
				_signal = null;
			}
			
			if(_builders != null)
			{
				_builders.dispose();
				_builders = null;
			}
			
			if(_enterFrame != null)
			{
				_enterFrame.dispose();
				_enterFrame.stop();
				_enterFrame = null;
			}
			
			ScreenManager.dispose();
		}
		
	}
}