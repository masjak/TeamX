package com.Game.Common
{
	import starling.errors.AbstractClassError;

	public class Constants
	{
		//抽象类 不用具化
		public function Constants(){ throw new AbstractClassError(); }
		
		/**舞台宽*/		
		public static const STAGE_WIDTH:int  = 800;
		/**舞台高*/
		public static const STAGE_HEIGHT:int = 600;
	}
}