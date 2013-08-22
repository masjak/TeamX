package Test
{
	import com.Game.Globel.Constants;
	import com.core.Utils.UtilImage;
	import com.core.Utils.File.OpenFile;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleSystem;
	import starling.textures.Texture;
	
	public class XGameTest extends Sprite
	{	
		private var effect:EffectTest;
		private var particle:ParticleTest;
		
		public function XGameTest()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			init();
		}
		
		private function init():void 
		{
			// 测试2048*2048 单纹理 渲染速度
//			randerSingleTex2048();
			
			// 测试单张256图拼成的2048*2048规格
//			randerTex256To2048();
			
			// 测试单张256图 quadBatch拼成的2048*2048规格
//			randerTex256quadBatch();
			
			// 测试单张256图 bitmapdata拼成的2048*2048规格
//			randerTex256bitmapData();
			
			// 测试2048*2048 单ATF纹理 渲染速度
//			randerSingleATF2048();	
			
			effect = new EffectTest();
			addChild(effect);
			
			
			
//			particle = new ParticleTest;
//			addChild(particle);
		}
		
		/**
		 *测试结果 DEBUG 版本 单张256纹理 bitmapData 加载时间 转换纹理时间 和 渲染时间
		 * PC一般配置上 分别为
		 * 4S上分别为1913,3539,5   帧率60
		 * 
		 */			
		private function randerTex256bitmapData():void 
		{
			var lastTime:uint = getTimer();
			var path:String = Constants.resRoot + "/testRes/cen256.png";
			UtilImage.loadImage(path,Compl);
			
			function Compl(name:String,bit:Bitmap):void 
			{
				var nowTime:uint = getTimer();
				trace("加载用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var bitData:BitmapData = new BitmapData(2048,2048,true,0);


				var max:int = 8;
				for(var i:int = 0; i < max; i++)
				{
					for(var j:int = 0; j < max; j++)
					{
						bitData.copyPixels(bit.bitmapData,bit.bitmapData.rect,new Point(256*i,256*j));
					}
				}	
				var tex:Texture = Texture.fromBitmapData(bitData);
				nowTime = getTimer() ;
				trace("转换用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var img:Image = new Image(tex);
				addChild(img);
				nowTime = getTimer() ;
				trace("渲染用时：" + (nowTime- lastTime));
			}
		}
		
		/**
		 *测试结果 DEBUG 版本 单张256纹理 quadBatch 加载时间 转换纹理时间 和 渲染时间
		 * PC一般配置上 分别为
		 * 4S上分别为2016，81，32 帧率60
		 * 
		 */			
		private function randerTex256quadBatch():void 
		{
			var lastTime:uint = getTimer();
			var path:String = Constants.resRoot + "/testRes/cen256.png";
			UtilImage.loadImage(path,Compl);
			
			function Compl(name:String,bit:Bitmap):void 
			{
				var nowTime:uint = getTimer();
				trace("加载用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var tex:Texture = Texture.fromBitmap(bit);
				var img:Image = new Image(tex);
				var quadBatch:QuadBatch = new QuadBatch();
				addChild(quadBatch);
				
				nowTime = getTimer() ;
				trace("转换用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var max:int = 8;
				for(var i:int = 0; i < max; i++)
				{
					for(var j:int = 0; j < max; j++)
					{
						
						img.x = 256*i;
						img.y = 256*j;
						quadBatch.addImage(img);
					}
				}	
				nowTime = getTimer() ;
				trace("渲染用时：" + (nowTime- lastTime));
			}
		}
		
		/**
		 *测试结果 DEBUG 版本 单张256纹理 加载时间 转换纹理时间 和 渲染时间
	 	 * PC一般配置上 分别为
		 * 4S上分别为1905，71，87 帧率25
		 * 
		 */			
		private function randerTex256To2048():void 
		{
			var lastTime:uint = getTimer();
			var path:String = Constants.resRoot + "/testRes/cen256.png";
			UtilImage.loadImage(path,Compl);
			
			function Compl(name:String,bit:Bitmap):void 
			{
				var nowTime:uint = getTimer();
				trace("加载用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				var tex:Texture = Texture.fromBitmap(bit);
				nowTime = getTimer() ;
				trace("转换用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var max:int = 8;
				for(var i:int = 0; i < max; i++)
				{
					for(var j:int = 0; j < max; j++)
					{
						var img:Image = new Image(tex);
						img.x = 256*i;
						img.y = 256*j;
						addChild(img);
					}
				}	
				nowTime = getTimer() ;
				trace("渲染用时：" + (nowTime- lastTime));
			}
			
		}

		/**
		 *测试结果 DEBUG 版本 单张2048*2048纹理 加载时间 转换纹理时间 和 渲染时间
		 * PC一般配置上 分别为171，485
		 * 4S上分别为2146，5312,5 帧率60
		 * 
		 */	
		private function randerSingleTex2048():void 
		{
			var lastTime:uint = getTimer();
			var path:String = Constants.resRoot + "/testRes/xue.png";
			UtilImage.loadImage(path,Compl);
			
			function Compl(name:String,bit:Bitmap):void 
			{
				var nowTime:uint = getTimer();
				trace("加载用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var tex:Texture = Texture.fromBitmap(bit);
				nowTime = getTimer() ;
				trace("转换用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var img:Image = new Image(tex);
				addChild(img);
				
				nowTime = getTimer() ;
				trace("渲染用时：" + (nowTime- lastTime));
				lastTime = nowTime;
			}
			
		}
		
		/**
		 *测试结果 DEBUG 版本 单张2048*2048atf纹理 加载时间 转换纹理时间 和 渲染时间
		 * PC一般配置上 分别为
		 * 4S上分别为189，63,6 帧率60
		 * 
		 */	
		private function randerSingleATF2048():void 
		{
			var lastTime:uint = getTimer();
			var path:String = Constants.resRoot + "/testRes/0_0.atf";
			
			var atfData:ByteArray = OpenFile.open(new File(path));
			var nowTime:uint = getTimer();
			trace("加载用时：" + (nowTime- lastTime));
			lastTime = nowTime;
				
			var tex:Texture = Texture.fromAtfData(atfData);
				nowTime = getTimer() ;
				trace("转换用时：" + (nowTime- lastTime));
				lastTime = nowTime;
				
				var img:Image = new Image(tex);
				img.scaleX = img.scaleY = 1.5;
				addChild(img);
				
				nowTime = getTimer() ;
				trace("渲染用时：" + (nowTime- lastTime));
				lastTime = nowTime;
			
		}
		
	}
}