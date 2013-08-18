package com.core.Common
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XScene;
	import com.core.Basic.XWorld;
	import com.core.Common.DataStruct.SceneDataVO;
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
				sd.sceneId = xml.scene[0].@sceneId;
				sd.mapWidth = xml.scene[0].@mapWidth;
				sd.mapHeight = xml.scene[0].@mapHeight;
				sd.tileWidth = xml.scene[0].@tileWidth;
				sd.tileHeight = xml.scene[0].@tileHeight;
				sd.widthNum = xml.scene[0].@widthNum;
				sd.heightNum = xml.scene[0].@heightNum;
				var rectx:int = xml.scene[0].@initAreoX;
				var recty:int = xml.scene[0].@initAreoY;
				var rectw:int = xml.scene[0].@initAreoWidth;
				var recth:int = xml.scene[0].@initAreoHeight;
				sd.initRect = new Rectangle(rectx,recty,rectw,recth);
				
				sd.roadmap = xml.scene[0].@roadmap;
				sd.atfFormat = xml.scene[0].@atfFormat;
				sd.initState = xml.scene[0].@initState;
				// 读取建筑数据
				var len:int = xml.scene[0].buliders.length();
				for(var j:int = 0; j < len; j++)
				{
					var bds:buildersVO = new buildersVO;
					bds.name =  xml.scene[0].buliders[j].@name;
					bds.path =  xml.scene[0].buliders[j].@path;
					bds.PosX =  xml.scene[0].buliders[j].@PosX;
					bds.PosY =  xml.scene[0].buliders[j].@PosY;
					bds.State =  xml.scene[0].buliders[j].@State;
					sd.builders[bds.name] = bds;
				}			
				// 读取光影数据
				len = xml.scene[0].lights.length();
				for( j = 0; j < len; j++)
				{
					var lds:lightsVO = new lightsVO;
					lds.name =  xml.scene[0].lights[j].@name;
					lds.path =  xml.scene[0].lights[j].@path;
					lds.PosX =  xml.scene[0].lights[j].@PosX;
					lds.PosY =  xml.scene[0].lights[j].@PosY;
					lds.State =  xml.scene[0].lights[j].@State;
					sd.lights[bds.name] = lds;
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