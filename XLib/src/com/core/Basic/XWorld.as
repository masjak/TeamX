package com.core.Basic
{
	import com.Game.Globel.Constants;
	import com.core.Common.SceneManager;
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
		
		public function enterScene(id:String):void
		{
			var s:XScene = SceneManager.enterScene(id);
			
			if(s != null)
			{
				_scene = s;
				addChild(scene);
				_camera = new XCamera(_scene);
				_scene.setUp();
			}
			
		}
		
		public function init():void
		{
//			enterScene("1");
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