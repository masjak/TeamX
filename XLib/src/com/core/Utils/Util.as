package com.core.Utils
{
	import com.byxb.utils.angleModulus;
	import com.byxb.utils.ease;
	import com.byxb.utils.nearEquals;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Bitmap;
	import flash.filesystem.File;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Util
	{
		public function Util(){}
		
		public static function LoadAtlasTexture(pngName:String,XmlPath:String,fun):void
		{
			 var compl:Function =  function(name:String,bit:Bitmap):void
			{
				var xml:XML = new XML(OpenFile.open(new File(XmlPath)));
				var atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(bit),xml);
				if(fun != null)
				{
					fun.call(null,atlas);
					fun = null;
				}
			}
			UtilImage.loadImage(pngName,compl);
		}
	}
}