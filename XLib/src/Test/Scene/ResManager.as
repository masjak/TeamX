package Test.Scene
{
	import com.core.Utils.File.OpenFile;
	
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class ResManager
	{
		
	 	public static var vBlock:Vector.<imageBlock> = new Vector.<imageBlock>();
		public static var image:Image;
		
		public static function initBlock():void
		{
			
			var filePath:String = "F:/工作路径/work/XLib/Resouce/Test.xml";
			
			var xmlFile:File = new File(filePath);
			var ba:ByteArray = OpenFile.open(xmlFile);
			var xml:XML = new XML(ba);
			
			var len:int = xml.Block.length();
			
			for(var i:int = 0; i < len; i++)
			{
				var b:imageBlock = new imageBlock;
				b.bName = xml.Block[i].@Name;
				b.bPosX = xml.Block[i].@PosX;
				b.bPosY = xml.Block[i].@PosY;
				b.bWidth = xml.Block[i].@Width;
				b.bHeight = xml.Block[i].@Height;
				vBlock.push(b);
			}
			
			trace(vBlock);
			
			
			// 加载image
			filePath = "F:/工作路径/work/XLib/Resouce/test1.atf";
			
			xmlFile = new File(filePath);
			ba = OpenFile.open(xmlFile)
			image = new Image(Texture.fromAtfData(ba));		
			
			
		}
		
		
		public static function getBlockByName(name:String):Image
		{
			
			for each(var block:imageBlock in vBlock)
			{
				if(block.bName == name)
				{
					var img:Image = new Image(image.texture);
					
					img.setTexCoords(0,new Point(block.bPosX/1024,block.bPosY/1024));
					img.setTexCoords(1,new Point((block.bPosX + block.bWidth)/1024,block.bPosY/1024));
					img.setTexCoords(2,new Point(block.bPosX/1024,(block.bPosY + block.bHeight)/1024));
					img.setTexCoords(3,new Point((block.bPosX + block.bWidth)/1024,(block.bPosY + block.bHeight)/1024));
					
					img.scaleX = block.bWidth/1024;
					img.scaleY = block.bHeight/1024;
					return img;
				}
			}
			
			return null;
		}
		
	}

}
