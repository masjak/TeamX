package com.core.Effect.BuilderState
{
	import com.Game.Globel.Constants;
	import com.core.Basic.XBuilder;

	public class StateManager
	{
		public function StateManager(){}
		
		public static function SetBuilderState(b:XBuilder,state:int):void
		{
			if(b == null)
			{
				return;
			}
			
			// 如果所需要的状态没有处理结果 就隐藏建筑
			var bhave:Boolean = false;
			if(state & Constants.SCENE_STATE_DAY)
			{
				b.filter = null;
			}
			if(state & Constants.SCENE_STATE_NIGHT)
			{
//				var 
				
				
			}
			
			
		}
		
		
		
	}
}