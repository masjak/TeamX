package com.core.Utils
{
	import com.Game.Globel.Constants;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class UtilImage
	{
		public function UtilImage()
		{
		}
		
		/**
		 * 加载图片
		 * @param fileName
		 * @param fun
		 * 
		 */		
		public static function loadImage(fileName:String,fun:Function):void
		{
			var loaderInfo:LoaderInfo;
			var f:File = new File(fileName);
			var ba:ByteArray = OpenFile.open(f);
			
			var load:Loader = new Loader();    
			load.loadBytes(ba);//读取ByteArray    
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, compl)
			
			/** 完成图像加载*/
			function compl(e:Event):void 
			{
				var loaderInfo:LoaderInfo = e.target as LoaderInfo;
				if(fun != null)
				{
					fun.call(null,fileName,loaderInfo.content);
					fun = null;
				}
				
			}	
		}
		
	}
}