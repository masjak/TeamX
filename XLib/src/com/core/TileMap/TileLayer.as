package com.core.TileMap
{
	public class TileLayer
	{
		/***layer的名字*/		
		public var name:String;
		/***layer的横向格子数*/	
		public var width:int;
		/***layer的纵向向格子数*/
		public var height:int;
		/***layer的格子数据*/
		public var gids:Vector.<TileGid>;
		
		
		public function TileLayer()
		{
		}
		
		public static function praseDataFormXml(xmlList:XMLList):Vector.<TileLayer>
		{
			var v:Vector.<TileLayer> = new Vector.<TileLayer>;
			var lLen:int = xmlList.length();
			for(var i:int = 0; i < lLen; i++)
			{
				var layer:TileLayer = new TileLayer;
				layer.name = xmlList[i].@name;
				layer.width = xmlList[i].@width;
				layer.height = xmlList[i].@height;
				
				// 读取gid
				var tiles:XMLList = xmlList[i].data[0].tile;
				var tilesLen:int = tiles.length();
				layer.gids = new Vector.<TileGid>;
				for(var j:int = 0; j < tilesLen; j++)
				{
					var g:TileGid = new TileGid;
					g.gid = tiles[j].@gid;
					layer.gids.push(g);
				}
				
				v.push(layer);
			}
			return v;
		}
		
	}
}