package com.core.TileMap
{
	public class TileSet
	{
		/**gid的起始标号*/		
		public var firstgid:int;
		/**名字*/
		public var name:String;
		/**tile 的宽*/
		public var tileWidth:int;
		/**tile 的高*/
		public var tileHeight:int;
		/**tile 图源的名字*/
		public var imageName:String;
		/**tile 图源的宽*/
		public var imageWidth:int;
		/**tile 图源的高*/
		public var imageHeight:int;
		
		public function TileSet()
		{
		}
		
		public static function praseDataFormXml(xml:XML):TileSet
		{
			var tset:TileSet = new TileSet;
			tset.firstgid = xml.@firstgid;
			tset.name = xml.@name;
			tset.tileWidth = xml.@tilewidth;
			tset.tileHeight = xml.@tileheight;
			tset.imageName = xml.image[0].@source;
			tset.imageWidth = xml.image[0].@width;
			tset.imageHeight = xml.image[0].@height;
			
			return tset;
		}
	}
}