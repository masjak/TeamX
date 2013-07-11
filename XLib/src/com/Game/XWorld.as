package com.Game
{
	import com.Game.Common.Constants;
	import com.Game.Common.SceneManager;
	import com.core.Basic.XCamera;
	import com.core.Map.XScene;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	
	public class XWorld extends Sprite
	{
		/**场景实例*/	
		public static var instance:XWorld;
		
		protected var _scene:XScene;
		protected var _camera:XCamera;
		
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
		
		public function init():void
		{
			_scene = SceneManager.createTileScene("485");
			addChild(scene);
			_camera = new XCamera(_scene);
			_scene.setUp();
		}
		
	
		public function get scene():XScene{return _scene;}
		public function get camera():XCamera{return _camera;}
		
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