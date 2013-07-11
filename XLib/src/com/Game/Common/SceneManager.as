package com.Game.Common
{
	import com.Game.Common.DataStruct.SceneStruct;
	import com.core.Map.XScene;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;

	public class SceneManager
	{
		/**保存当前场景ID*/	
		protected static var currentId:String;
		/**保存当前场景*/	
		protected static var currentTileScence:XScene;
		
		function SceneManager(){}
		
		public static function init():void
		{
			var f:File = new File(Constants.resRoot + "/Scene/SceneList.xml");
			var xml:XML = new XML(OpenFile.open(f));
			var len:int = xml.scene.length();
			for(var i:int = 0; i < len; i++)
			{
				
			}
		}
		
		/**
		 * 生成一个场景
		 * @param id
		 * 
		 */		
		public static function createTileScene(id:String):XScene
		{	
			return new XScene(id);
		}
		
		/**进入场景*/
		public static function enterScene(id:String):void
		{
			if(currentId == id)
			{
				return;
			}
			// 保存当前场景ID
			currentId = id;
			// 保存当前场景数据
			if(currentTileScence != null)
			{
				currentTileScence.dispose();
			}
			currentTileScence = createTileScene(id);
		}
		
		/**获取当前场景ID*/
		public static function get currentSceneId():String
		{
			return currentId;
		}
		
		/**销毁*/		
		public static function dispose():void
		{
			currentId = null;
		}
	}
}