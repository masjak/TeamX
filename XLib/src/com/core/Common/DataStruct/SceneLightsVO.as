package com.core.Common.DataStruct
{
	public class SceneLightsVO implements IDataVO
	{
		public var name:String;// 在场景中的名字
		public var lightsName:String;// 实际的用来查找灯光配置的名字
		public var PosX:Number;			// 初始化场景中的坐标
		public var PosY:Number;			// 初始化场景中的坐标
		public var State:int;					// 建筑的状态

		public function SceneLightsVO(){}
		
		public function clone():IDataVO
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}