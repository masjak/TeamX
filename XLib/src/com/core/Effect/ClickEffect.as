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
		protected static var _list:Vector.<ClickEffectVO>;
		public function ClickEffect()
		{
		}
		
		/**执行点击效果 */		
		public static function playEffect(o:DisplayObject,effect:int,fun:Function):void
		{
			if(o == null)
			{
				return;	
			}
			
			if(effect == Constants.CLICK_EFFECT_SHAKE)
			{
				playEffectShake(o,fun);
			}
		}
		
		/**晃动效果 */	
		public static function playEffectShake(o:DisplayObject,fun:Function):void
		{
			var timeline:TimelineLite = new TimelineLite({paused:true});
			var vo:ClickEffectVO = new ClickEffectVO;
			vo.o = o;
			vo.line = timeline;
			list.push(vo);
			
			var scaleBakX:Number = o.scaleX;
			var scaleBakY:Number = o.scaleY;
			timeline.append(new TweenLite(o,0.1,{scaleX:scaleBakX*1.1,scaleY:scaleBakY*1.1}));
			timeline.append(new TweenLite(o,0.1,{scaleX:scaleBakX,scaleY:scaleBakY,onComplete:complete}));
			timeline.play();
			// 如果是建筑 要判定绑定灯光
			if(o is XBuilder)
			{
				var l:XLight = XWorld.instance.scene.getLightByBuilderSceneName((o as XBuilder).vo.sceneName);
				playEffectShake(l,null);
			}	
			
			function complete():void
			{
				if(fun != null)
				{
					stopPlayEffect(o);
					fun();
				}
				
			}
			
		}
		
		/**中断执行效果 */	
		public static function stopPlayEffect(o:DisplayObject):void
		{
			// 全部查找  停止播放物件的所有效果
			for(var i:int = 0; i<list.length; i++)
			{
				if(list[i].o == o)
				{
					if(o is XBuilder)
					{
						var l:XLight = XWorld.instance.scene.getLightByBuilderSceneName((o as XBuilder).vo.sceneName);
						stopPlayEffect(l);
					}	
					list[i].line.stop();
					list.splice(i,1);
				}
				
			}
		}
		
		/**中断执行效果 */	
		public static function get list():Vector.<ClickEffectVO>
		{
			if(_list == null)
			{
				_list = new Vector.<ClickEffectVO>;
			}
			
			return _list;
		}
		
		
	}
}


import com.greensock.TimelineLite;

import starling.display.DisplayObject;

 class ClickEffectVO
{
	 public var o:DisplayObject;
	 public var line:TimelineLite;
}
