package com.core.Common
{
	import com.Game.Globel.Constants;
	
	import dragonBones.factorys.StarlingFactory;
	
	import feathers.controls.ScreenNavigator;
	
	import starling.utils.AssetManager;

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
		
		/***装饰管理器 */		
		private static var _decorates:DecoratesManager;
		
		/***单位管理器 */		
		private static var _units:UnitManager;
		
		/***灯光管理器 */		
		private static var _lights:LightManager;
		
		/***帧监听 */		
		private static var _enterFrame:EnterFrameManager;
		
		/***网络管理器 */		
		private static var _socket:SocketManager;
		
		/***自动更新管理器 */		
		private static var _update:UpDateManager;
		
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
		
		/***装饰 对象 */
		public static function get decorates():DecoratesManager
		{
			if(_decorates == null)
			{
				_decorates = new DecoratesManager;
			}
			return _decorates;
		}
		
		/***单位对象 */
		public static function get units():UnitManager
		{
			if(_units == null) 
			{
				_units = new UnitManager;
			}
			return _units;
		}
		
		/***灯光 对象 */
		public static function get lights():LightManager
		{
			if(_lights == null)
			{
				_lights = new LightManager;
			}
			return _lights;
		}
		
		/***帧监听 对象 */
		public static function get enterFrame():EnterFrameManager
		{
			if(_enterFrame == null)
			{
				_enterFrame = new EnterFrameManager;
				_enterFrame.start();
			}
			return _enterFrame;
		}
		
		/***网络协议 对象 */
		public static function get socket():SocketManager
		{
			if(_socket == null)
			{
				_socket = new SocketManager;
			}
			return _socket;
		}	
		
		/***自动更新管理器 */
		public static function get update():UpDateManager
		{
			if(_update == null)
			{
				_update = new UpDateManager;
			}
			return _update;
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
			
			if(_decorates != null)
			{
				_decorates.dispose();
				_decorates = null;
			}
			
			if(_builders != null)
			{
				_builders.dispose();
				_builders = null;
			}
			
			if(_units != null)
			{
				_units.dispose();
				_units = null;
			}
			
			if(_lights != null)
			{
				_lights.dispose();
				_lights = null;
			}
			
			if(_enterFrame != null)
			{
				_enterFrame.dispose();
				_enterFrame.stop();
				_enterFrame = null;
			}
			
			if(_socket != null)
			{
				_socket.dispose();
				_socket = null;
			}
			
			if(_update != null)
			{
				_update.dispose();
				_update = null;
			}
			
			ScreenManager.dispose();
		}
		
	}
}