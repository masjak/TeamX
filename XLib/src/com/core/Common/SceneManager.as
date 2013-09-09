package com.core.Common
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XScene;
	import com.core.Basic.XWorld;
	import com.core.Common.DataStruct.SceneBuildersVO;
	import com.core.Common.DataStruct.SceneDataVO;
	import com.core.Common.DataStruct.SceneLightsVO;
	import com.core.Common.DataStruct.SceneListVO;
	import com.core.Common.DataStruct.BuildersVO;
	import com.core.Common.DataStruct.LightsVO;
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
					bds.sceneId =  xml.buliders[j].@sceneId;
					bds.tableId =  xml.buliders[j].@tableId;
					bds.PosX =  xml.buliders[j].@PosX;
					bds.PosY =  xml.buliders[j].@PosY;
					bds.State =  xml.buliders[j].@State;
					bds.bclick =  (xml.buliders[j].@bclick == "true"); 
					bds.blindLight =  xml.buliders[j].@blindLight;
					bds.blindOfferX =  xml.buliders[j].@blindOfferX;
					bds.blindOfferY =  xml.buliders[j].@blindOfferY;
					
					sd.builders[bds.sceneId] = bds;
				}			
				// 读取光影数据
				len = xml.lights.length();
				for( j = 0; j < len; j++)
				{
					var lds:SceneLightsVO = new SceneLightsVO;
					lds.sceneId =  xml.lights[j].@sceneId;
					lds.tableId =  xml.lights[j].@tableId;
					lds.PosX =  xml.lights[j].@PosX;
					lds.PosY =  xml.lights[j].@PosY;
					lds.State =  xml.lights[j].@State;
					sd.lights[bds.sceneId] = lds;
				}
				
				// 读取可放置建筑区域
				sd.terrainTileWidth = xml.terrain.@grid_w;
				sd.terrainTileHeight = xml.terrain.@grid_h;
				
				sd.terrainWidth = (sd.mapWidth/sd.terrainTileWidth);
				sd.terrainHeight = (sd.mapHeight/sd.terrainTileHeight);
				
				// 初始化二维地形数组(默认都为0 不能建造)
				sd.terrainData = new Array(sd.terrainWidth);
				for(var i:int = 0; i<sd.terrainWidth;i++)
				{
					var ay:Array = new Array(sd.terrainHeight);
					sd.terrainData[i] = ay;
				}
				
				//				var myPattern:RegExp = /\r\n/g;
				//				var terrainData:Array = (String(xml.terrain.@terrain).replace(myPattern,"").split("),"));
				// 		19,92＃10,93＃10,94(地形格式)
				var terrainData:Array = (String(xml.terrain.@terrain).split("#"));
				len = terrainData.length;
				for( j = 0; j < len; j++)
				{
					var a:Array = String(terrainData[j]).split(",");
					sd.terrainData[a[1]][a[0]] = 1; // x,y的位置反了 是世海二货修改
				}
				
				
				
				
				
				
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