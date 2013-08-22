package Test
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XSprite;
	import com.core.Utils.UtilImage;
	
	import flash.display.Bitmap;
	import flash.utils.setInterval;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;

	public class EffectTest extends XSprite implements ITest
	{
		protected var tex:Texture;
		protected var img:Image;
		protected var nowTime:uint;
		protected var tween:Tween;
		
		protected var scaleZoom:Boolean = true;
		
		public function EffectTest()
		{
			init();
		}
		
		
		public function init():void
		{
			
			var path:String = Constants.resRoot + "/testRes/testEF.png";
			UtilImage.loadImage(path,Compl);
			this.addEventListener(TouchEvent.TOUCH,ontouch);
		}
		
		public function ontouch(te:TouchEvent):void
		{
			if(te.getTouch(this,TouchPhase.BEGAN) != null)
			{
				this.test();
			}
			
		}
		
		
		public function Compl(name:String,bit:Bitmap):void 
		{
			tex = Texture.fromBitmap(bit);
			img = new Image(tex);
			img.x =300;
			img.y = 300;
			img.pivotX = img.width>>1;
			img.pivotY = img.height>>1;
			
			var colorfilter:ColorMatrixFilter = new ColorMatrixFilter();
			colorfilter.adjustSaturation(-1);
//			colorfilter.matrix = Vector.<Number>([
//				1,0,0,0,0,
//				0,1,0,0,0,
//				0,0,1,0,0,
//				0,0,0,1,0
//			]);
			img.filter = colorfilter;
			
			addChild(img);
		}
		

		
		public function test():void
		{
			tween = new Tween(img, 0.5, Transitions.EASE_IN);
			tween.animate("y", 20);
			tween.animate("scaleX", 2);
			tween.animate("scaleY", 2);
			tween.animate("rotation", 2);
//			tween.animate("alpha", 0);
//			tween.delay = 2;
			tween.onComplete = function():void { trace("tween complete!"); };
			Starling.juggler.add(tween);
			
		}
		
	}
}