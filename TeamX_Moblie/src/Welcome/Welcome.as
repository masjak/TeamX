package Welcome
{
	import com.Game.Common.Constants;
	import com.Game.Common.Singleton;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Welcome extends Sprite
	{
		/**游戏logo动画*/
		[Embed(source="/Assets/updatelogo.png")]
		static public var UpdateLogo:Class;
		
		/**公司logo图片*/
		[Embed(source="/Assets/logo.png")]
		static public var Logo:Class;
		
		
		private var bit:Bitmap;
		public function Welcome()
		{
			bit = new Logo();
			addChild(bit);
			this.x = (Constants.STAGE_WIDTH - bit.width)>>1;
			this.y = (Constants.STAGE_HEIGHT - bit.height)>>1;
			
		}
		
		
		public function dispose():void
		{
			if(bit != null)
			{
				this.removeChild(bit);
				bit.bitmapData.dispose();
				bit = null;
			}
		}
		
	}
}