package com.Game.Common
{
	import com.Game.Common.DataStruct.SceneStruct;
	import com.core.TileMap.TileScene;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;

	public class SceneManager
	{
		/**场景数据*/		
		protected static var vScenes:Vector.<SceneStruct> = new Vector.<SceneStruct>;
		/**保存当前场景ID*/	
		protected static var currentId:String;
		/**保存当前场景*/	
		protected static var currentTileScence:TileScene;
		
		function SceneManager(){}
		
		public static function init():void
		{
			var f:File = new File(Constants.resRoot + "/Scene/SceneList.xml");
			var xml:XML = new XML(OpenFile.open(f));
			var len:int = xml.scene.length();
			for(var i:int = 0; i < len; i++)
			{
				var ss:SceneStruct = new SceneStruct;
				ss.sceneId = xml.scene[i].@Id;
				ss.sceneName = xml.scene[i].@name;
				ss.scenePath = xml.scene[i].@path;
				ss.scenePngName = xml.scene[i].@PngName;
				ss.sceneXmlName = xml.scene[i].@XmlName;
				ss.sceneTmxName = xml.scene[i].@TmxName;
				vScenes.push(ss);
			}
		}
		
		/**
		 * 生成一个场景
		 * @param id
		 * 
		 */		
		public static function createTileScene(id:String):TileScene
		{	
			return new TileScene(getSceneData(id));
		}
		
		/**进入场景*/
		public static function enterScene(id:String,enterBefor:Function = null,enterAfter:Function = null):void
		{
			if(currentId == id)
			{
				return;
			}
			
			// 生成新场景前调用函数 返回旧的场景数据
			if(enterBefor != null)
			{
				enterBefor.call(null,currentId,currentTileScence);
				enterBefor = null;
			}
			
			// 保存当前场景ID
			currentId = id;
			// 保存当前场景数据
			if(currentTileScence != null)
			{
				currentTileScence.dispose();
			}
			currentTileScence = createTileScene(id);
			
			// 生成新场景前调用函数 返回新的场景数据
			if(enterAfter != null)
			{
				enterAfter.call(null,currentId,currentTileScence);
				enterAfter = null;
			}
		}
		
		/**获取当前场景ID*/
		public static function get currentSceneId():String
		{
			return currentId;
		}
		
		/**获取当前场景基本信息*/
		public static function get currentSceneData():SceneStruct
		{
			return getSceneData(currentSceneId);
		}
		
		/**获取场景基本信息*/
		public static function getSceneData(id:String):SceneStruct
		{
			for each(var ss:SceneStruct in vScenes)
			{
				if(ss.sceneId == id)
				{
					return ss;
				}
			}
			return null;
		}
		
		/**销毁*/		
		public static function dispose():void
		{
			currentId = null;
		}
	}
}