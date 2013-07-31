package Test.Scene
{
	import com.core.Common.Constants;
	import com.core.Common.PlatformManager;
	import com.core.Common.Singleton;
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class ResManager
	{
		
	 	public static var vBlock:Vector.<Block> = new Vector.<Block>();
//		public static var image:Image;
		public static var resRoot:String;
		
		
		public static function initBlock():void
		{
			if(Singleton.platform.Platform == Constants.PLATFORM_MAC)
			{
				resRoot = "/Users/mf02/workplace/XLib/TeamX/Resouce";
			}
			else if(Singleton.platform.Platform == Constants.PLATFORM_WINDOW)
			{
				resRoot = "F:/工作路径/work/XLib/Resouce";
			}
			
			var filePath:String = resRoot + "/Test.xml";
			
			var xmlFile:File = new File(filePath);
			var ba:ByteArray = OpenFile.open(xmlFile);
			var xml:XML = new XML(ba);
			
			var len:int = xml.Block.length();
			
			for(var i:int = 0; i < len; i++)
			{
				var b:Block = new Block;
				b.imageName = xml.Block[i].@ImageName;
				b.ImageWidth = xml.Block[i].@ImageWidth;
				b.ImageHeight = xml.Block[i].@ImageHeight;
				
				b.bName = xml.Block[i].@Name;
				b.bPosX = xml.Block[i].@PosX;
				b.bPosY = xml.Block[i].@PosY;
				b.bWidth = xml.Block[i].@Width;
				b.bHeight = xml.Block[i].@Height;
				vBlock.push(b);
			}
		}
		
		
		public static function getBlockByName(name:String):Block
		{
			if(name == null || name.length <= 0)
			{
				return null;
			}
			
			for each(var block:Block in vBlock)
			{
				if(block.bName == name)
				{
					return block;
				}
			}
			
			return null;
		}
		
		public static function getImageByName(name:String):Image
		{
			var block:Block = getBlockByName(name);
			
			if(block == null)
			{
				trace("[error]: Can't find Block By name " + name);
				return null;
			}
			
			var tex:Texture = Singleton.assets.getTexture(block.imageName);
			if(tex == null)
			{
				var filePath:String = resRoot + "/" + block.imageName;
				var f:File = new File(filePath);
				tex = Texture.fromAtfData(OpenFile.open(f));
				
				trace("[tips]: add one texture to game name is :" + block.imageName);
				Singleton.assets.addTexture(block.imageName,tex);
			}
			
			
			var img:Image = new Image(tex);
			
			img.setTexCoords(0,new Point(block.bPosX/block.ImageWidth,block.bPosY/block.ImageHeight));
			img.setTexCoords(1,new Point((block.bPosX + block.bWidth)/block.ImageWidth,block.bPosY/block.ImageHeight));
			img.setTexCoords(2,new Point(block.bPosX/block.ImageWidth,(block.bPosY + block.bHeight)/block.ImageHeight));
			img.setTexCoords(3,new Point((block.bPosX + block.bWidth)/block.ImageWidth,(block.bPosY + block.bHeight)/block.ImageHeight));
			
			img.scaleX = block.bWidth/block.ImageWidth;
			img.scaleY = block.bHeight/block.ImageHeight;
			
			return img;
		}
		
		
	}

}
