package com.core.Common.DataStruct
{
	public class DecoratesVO implements IDataVO
	{
		public var sceneName:String; // 在场景中的名字
		public var name:String; // 名字
//		public var path:String;// 路径
//		public var canMove:Boolean;// 是否可以移动
//		public var clickEffect:int;			// 建筑的点击效果
		
		public function DecoratesVO(){}
		
		public function clone():IDataVO
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}