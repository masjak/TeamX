package com.Game.GameScreen
{
	import com.Game.Globel.Constants;
	import com.core.Utils.UtilImage;
	
	import flash.display.Bitmap;
	
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