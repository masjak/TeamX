package com.core.Effect
{
	import com.Game.Globel.Constants;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import starling.display.DisplayObject;

	public class ClickEffect
	{
		public function ClickEffect()
		{
		}
		
		/**执行点击效果 */		
		public static function playEffect(s:DisplayObject,effect:int):void
		{
			if(effect == Constants.CLICK_EFFECT_SHAKE)
			{
				playEffectShake(s);
			}
		}
		
		/**晃动效果 */	
		public static function playEffectShake(s:DisplayObject):void
		{
			var timeline:TimelineLite = new TimelineLite({paused:true});
			timeline.append(new TweenLite(s,0.1,{scaleX:1.1,scaleY:1.1}));
			timeline.append(new TweenLite(s,0.1,{scaleX:1,scaleY:1/*,onComplete:fun*/}));
			timeline.play();
		}
		
	}
}