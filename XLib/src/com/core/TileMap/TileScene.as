package com.core.TileMap
{
	import com.Game.Common.Constants;
	import com.core.Utils.UtilImage;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class TileScene extends Sprite
	{		
		protected var sceneName:String;
		protected var atlas:TextureAtlas;
		protected var tileMap:TileMap;
//		protected var tileImage:Bitmap;
		protected var atlasBitmapData:BitmapData;
		
		public function TileScene(sceneName:String)
		{
			this.sceneName = sceneName;
			init();
		}
		
		public function init():void
		{
			var path:String = Constants.resRoot + "/" + sceneName + ".png";
			UtilImage.loadImage(path,compl);
		}
		
		
		protected function compl(name:String,bit:Bitmap):void
		{
			// 先加载PNG 
			const atlasBitmapData:BitmapData = bit.bitmapData;
			
			// 加载XML
			var path:String = Constants.resRoot + "/" + sceneName + ".xml";
			var f:File = new File(path);
			this.atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(OpenFile.open(f)));
			if(Starling.handleLostContext)
			{
				this.atlasBitmapData = atlasBitmapData;
			}
			else
			{
				atlasBitmapData.dispose();
			}
			// 加载地图格式
			path = Constants.resRoot + "/" + sceneName + ".tmx";
			f = new File(path);
			
			tileMap = TileMap.praseDataFormXml(new XML(OpenFile.open(f)));
			var gidlen:int = tileMap.layers[0].gids.length;
			for(var i:int = 0; i < gidlen; i++)
			{
				var row:int = i/tileMap.layers[0].width;
				var lis:int = i%tileMap.layers[0].height;
				var tex:Texture = atlas.getTexture(tileMap.layers[0].gids[i].gid.toString());
				
				if(tex != null)
				{
					var img:Image = new Image(tex);
					img.x = lis*tileMap.tileWidth;
					img.y = row*tileMap.tileHeight;
					addChild(img);
				}
			}
			
		}
		
	}
}