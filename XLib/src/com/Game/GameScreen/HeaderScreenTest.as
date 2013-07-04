package com.Game.GameScreen
{
	import com.Game.Common.Constants;
	import com.core.Utils.UtilImage;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import feathers.controls.Header;
	import feathers.controls.Screen;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class HeaderScreenTest extends Screen
	{
		public function HeaderScreenTest()
		{
			super();
			var header:Header = new Header();
			header.width = 500;
			header.title = "Settings";
			this.addChild( header );
			
			init();
		}
		
		public function init():void
		{
			var filePath:String = Constants.resRoot + "/1.png";
			UtilImage.loadImage(filePath,compl);
		}
		
		/** 从系统中读取照片信息*/
		private function compl(fileName:String,bit:Bitmap):void 
		{
			addChild(new Image(Texture.fromBitmap(bit)));
		}
	}
}