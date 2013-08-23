package com.core.Effect
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XBuilder;
	import com.core.Basic.XLight;
	import com.core.Basic.XWorld;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import starling.display.DisplayObject;

	public class ClickEffect
	{
		public function ClickEffect()
		{
		}
		
		/**执行点击效果 */		
		public static function playEffect(o:DisplayObject,effect:int):void
		{
			if(o == null)
			{
				return;	
			}
			
			if(effect == Constants.CLICK_EFFECT_SHAKE)
			{
				playEffectShake(o);
			}
		}
		
		/**晃动效果 */	
		public static function playEffectShake(o:DisplayObject):void
		{
			var timeline:TimelineLite = new TimelineLite({paused:true});
			timeline.append(new TweenLite(o,0.1,{scaleX:1.1,scaleY:1.1}));
			timeline.append(new TweenLite(o,0.1,{scaleX:1,scaleY:1/*,onComplete:fun*/}));
			timeline.play();
			// 如果是建筑 要判定绑定灯光
			if(o is XBuilder)
			{
				var l:XLight = XWorld.instance.scene.getLightByBuilderSceneName((o as XBuilder).vo.sceneName);
				playEffectShake(l);
			}
			
		}
		
	}
}