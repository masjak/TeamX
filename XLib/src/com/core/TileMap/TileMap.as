package com.core.TileMap
{
	import flash.system.System;

	public class TileMap
	{
		
		/**tile Map的生成版本*/
		public var tileVersion:String;
		/**tile Map的类型*/
		public var orientation:String;
		/**tile Map横向的格子数*/
		public var mapWidth:int;
		/**tile Map纵向的格子数*/
		public var mapHeight:int;
		/**tile 的宽*/
		public var tileWidth:int;
		/**tile 的高*/
		public var tileHeight:int;
		/**tile 的设置信息*/
		public var tileset:TileSet;
		/***layer的层*/
		public var layers:Vector.<TileLayer>;
		
		public function TileMap()
		{
		}
		
		public static function praseDataFormXml(xml:XML):TileMap
		{
			var map:TileMap = new TileMap;
			// 读取MAP的基本信息
			map.tileVersion = xml.@version;
			map.orientation = xml.@orientation;
			map.mapWidth = xml.@width;
			map.mapHeight = xml.@height;
			map.tileWidth = xml.@tilewidth;
			map.tileHeight = xml.@tileheight;
			map.tileset = TileSet.praseDataFormXml(xml.tileset[0]);
			map.layers = TileLayer.praseDataFormXml(xml.layer);
			
			// 释放XML资源
			System.disposeXML(xml);
			return map;
		}
		
	}
}