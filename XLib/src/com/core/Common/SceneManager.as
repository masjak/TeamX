package com.core.Common
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XScene;
	import com.core.Basic.XWorld;
	import com.core.Common.DataStruct.SceneBuildersVO;
	import com.core.Common.DataStruct.SceneDataVO;
	import com.core.Common.DataStruct.SceneLightsVO;
	import com.core.Common.DataStruct.SceneListVO;
	import com.core.Common.DataStruct.buildersVO;
	import com.core.Common.DataStruct.lightsVO;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.ByteArray;

	public class SceneManager
	{
		/**保存当前场景ID*/	
		protected static var currentId:String;
		/**保存当前场景*/	
		protected static var currentTileScence:XScene;
		protected static var _data:Object = {};
		
		function SceneManager(){}
		
		/**场景配置数据*/
		protected static function get sceneData():Object {return _data;}

		public static function readXml(xml:XML):void
		{
			var len:int = xml.scene.length();
			for(var i:int = 0; i < len; i++)
			{
				var sd:SceneListVO = new SceneListVO;
				sd.sceneId = xml.scene[i].@sceneId;
				sd.scenePath = xml.scene[i].@scenePath;
				sd.sceneType = xml.scene[i].@sceneType;
				// 保存数据
				_data[sd.sceneId] = sd;
			}
			
			XWorld.instance.enterScene("1");
		}
		
		public static function readScene(xml:XML):SceneDataVO
		{
				var sd:SceneDataVO = new SceneDataVO;
				sd.sceneId = xml.@sceneId;
				sd.mapWidth = xml.@mapWidth;
				sd.mapHeight = xml.@mapHeight;
				sd.tileWidth = xml.@tileWidth;
				sd.tileHeight = xml.@tileHeight;
				sd.widthNum = xml.@widthNum;
				sd.heightNum = xml.@heightNum;
				var rectx:int = xml.@initAreoX;
				var recty:int = xml.@initAreoY;
				var rectw:int = xml.@initAreoWidth;
				var recth:int = xml.@initAreoHeight;
				sd.initRect = new Rectangle(rectx,recty,rectw,recth);
				
				sd.roadmap = xml.@roadmap;
				sd.atfFormat = xml.@atfFormat;
				sd.initState = xml.@initState;
				// 读取建筑数据
				var len:int = xml.buliders.length();
				for(var j:int = 0; j < len; j++)
				{
					var bds:SceneBuildersVO = new SceneBuildersVO;
					bds.name =  xml.buliders[j].@name;
					bds.builderName =  xml.buliders[j].@builderName;
					bds.PosX =  xml.buliders[j].@PosX;
					bds.PosY =  xml.buliders[j].@PosY;
					bds.State =  xml.buliders[j].@State;
					bds.bclick =  (xml.buliders[j].@bclick == "true"); 
					sd.builders[bds.name] = bds;
				}			
				// 读取光影数据
				len = xml.lights.length();
				for( j = 0; j < len; j++)
				{
					var lds:SceneLightsVO = new SceneLightsVO;
					lds.name =  xml.lights[j].@name;
					lds.lightsName =  xml.lights[j].@lightName;
					lds.PosX =  xml.lights[j].@PosX;
					lds.PosY =  xml.lights[j].@PosY;
					lds.State =  xml.lights[j].@State;
					sd.lights[bds.name] = lds;
				}
				
				// 读取可放置建筑区域
				sd.terrainTileWidth = xml.terrain.@grid_w;
				sd.terrainTileHeight = xml.terrain.@grid_h;
				
				sd.terrainWidth = (sd.mapWidth/sd.terrainTileWidth);
				sd.terrainHeight = (sd.mapHeight/sd.terrainTileHeight);
				sd.terrainData = (String(xml.terrain.@terrain).split(","));
				
				
			// 释放XML资源
			System.disposeXML(xml);
			return sd;
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
			
			var sl:SceneListVO = _data[id];
			var ba:ByteArray = OpenFile.open(new File(Constants.resRoot + "/" + sl.scenePath));
			var sd:SceneDataVO = readScene(new XML(ba));
			return new XScene(sd);
		}
		
		/**进入场景*/
		public static function enterScene(id:String):void
		{
			if(currentId == id)
			{
				return ;
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