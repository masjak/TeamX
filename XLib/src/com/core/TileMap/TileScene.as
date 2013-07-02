package com.core.TileMap
{
	import com.Game.Common.Constants;
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
		[Embed(source="/../assets/images/1.png")]
		protected static const ATLAS_IMAGE:Class;
		
		[Embed(source="/../assets/images/1.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;
		
		protected var atlas:TextureAtlas;
		protected var tileMap:TileMap;
//		protected var tileImage:Bitmap;
		protected var atlasBitmapData:BitmapData;
		
		public function TileScene()
		{
			const atlasBitmapData:BitmapData = (new ATLAS_IMAGE()).bitmapData;
			this.atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(new ATLAS_XML()));
			if(Starling.handleLostContext)
			{
				this.atlasBitmapData = atlasBitmapData;
			}
			else
			{
				atlasBitmapData.dispose();
			}
			init();
		}
		
		
		public function init():void
		{
			var f:File = new File(Constants.resRoot + "/2.tmx");
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