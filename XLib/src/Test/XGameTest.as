package Test
{
	import com.Game.Common.Constants;
	import com.core.Utils.UtilImage;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class XGameTest extends Sprite
	{	

		
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
			randerTex256To2048();
		}
		
		/**
		 *测试结果 DEBUG 版本 单张256纹理 加载时间 转换纹理时间 和 渲染时间
		 * PC一般配置上 分别为171，485
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
		
	}
}