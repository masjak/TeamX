package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.SceneManager;
	import com.core.Common.Singleton;
	
	import org.osflash.signals.events.GenericEvent;
	
	import starling.display.Sprite;
	
	public class XWorld extends Sprite
	{
		/**场景实例*/	
		public static var instance:XWorld;
		
		protected var _scene:XScene;
//		protected var _camera:XCamera;
		
		public function XWorld()
		{
			if(instance != null)
			{
				instance.dispose();
			}
			instance = this;
			super();
			init();
		}
		
		public function enterScene(id:String):void
		{
			Singleton.signal.addSignal(Constants.SIGNAL_SCENE_CREATE_COMPLETE,this);
			Singleton.signal.registerSignalListener(Constants.SIGNAL_SCENE_CREATE_COMPLETE,sceneCreateComplete);
			SceneManager.enterScene(id);
		}
		
		public function init():void
		{
//			enterScene("1");
		}
		
		// 引擎初始化完毕
		private function sceneCreateComplete(e:GenericEvent,o:Object):void
		{
			
			_scene = o as XScene;
			if(_scene != null)
			{
				addChild(_scene);
			}
			Singleton.signal.removeSignal(Constants.SIGNAL_SCENE_CREATE_COMPLETE);
		}
		
	
		public function get scene():XScene{return _scene;}
//		public function get camera():XCamera{return _camera;}
		
		override public function dispose():void
		{
			if(scene != null)
			{
				scene.dispose();
				_scene = null;
			}
		}

		

	}
}