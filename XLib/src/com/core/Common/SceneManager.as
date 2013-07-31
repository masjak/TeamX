package com.core.Common
{
	import com.core.Basic.XScene;
	import com.core.Common.DataStruct.SceneDataStruct;
	import com.core.Common.DataStruct.buildersDataStruct;
	import com.core.Common.DataStruct.lightsDataStruct;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.system.System;

	public class SceneManager
	{
		/**保存当前场景ID*/	
		protected static var currentId:String;
		/**保存当前场景*/	
		protected static var currentTileScence:XScene;
		protected static var _data:Object;
		
		function SceneManager(){}
		
		/**场景配置数据*/
		protected static function get sceneData():Object {return _data;}

		public static function init():void
		{
			var f:File = new File(Constants.resRoot + "/Config/sceneConfig.xml");
			var xml:XML = new XML(OpenFile.open(f));
			var len:int = xml.scene.length();
			_data = new Array;
			for(var i:int = 0; i < len; i++)
			{
				var sd:SceneDataStruct = new SceneDataStruct;
				sd.sceneId = xml.scene[i].@sceneId;
				sd.mapWidth = xml.scene[i].@mapWidth;
				sd.mapHeight = xml.scene[i].@mapHeight;
				sd.tileWidth = xml.scene[i].@tileWidth;
				sd.tileHeight = xml.scene[i].@tileHeight;
				sd.roadmap = xml.scene[i].@roadmap;
				sd.atfFormat = xml.scene[i].@atfFormat;
				sd.initState = xml.scene[i].@initState;
				// 读取建筑数据
				len = xml.scene[i].buliders.length();
				for(var j:int = 0; j < len; j++)
				{
					var bds:buildersDataStruct = new buildersDataStruct;
					bds.name =  xml.scene[i].buliders[j].@name;
					bds.path =  xml.scene[i].buliders[j].@path;
					bds.PosX =  xml.scene[i].buliders[j].@PosX;
					bds.PosY =  xml.scene[i].buliders[j].@PosY;
					bds.State =  xml.scene[i].buliders[j].@State;
					sd.builders[bds.name] = bds;
				}			
				// 读取光影数据
				len = xml.scene[i].lights.length();
				for( j = 0; j < len; j++)
				{
					var lds:lightsDataStruct = new lightsDataStruct;
					lds.name =  xml.scene[i].lights[j].@name;
					lds.path =  xml.scene[i].lights[j].@path;
					lds.PosX =  xml.scene[i].lights[j].@PosX;
					lds.PosY =  xml.scene[i].lights[j].@PosY;
					lds.State =  xml.scene[i].lights[j].@State;
					sd.lights[bds.name] = lds;
				}
				
				// 保存数据
				_data[sd.sceneId] = sd;
			}
			
			// 释放XML资源
			System.disposeXML(xml);
		}
		
		
		
		/**
		 * 生成一个场景
		 * @param id
		 * 
		 */		
		public static function createTileScene(id:String):XScene
		{	
			// 寻找场景数据
			if(_data[id] == null)
			{
				throw new Error("找不到场景数据");
				return null;
			}
			
			return new XScene(_data[id]);
		}
		
		/**进入场景*/
		public static function enterScene(id:String):XScene
		{
			if(currentId == id)
			{
				return null;
			}
			// 保存当前场景ID
			currentId = id;
			// 保存当前场景数据
			if(currentTileScence != null)
			{
				currentTileScence.dispose();
			}
			currentTileScence = createTileScene(id);
			return currentTileScence;
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