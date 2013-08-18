package com.core.Common.DataStruct
{
	public class SceneBuildersVO implements IDataVO
	{
		public var name:String;// 在场景中的名字
		public var builderName:String;// 实际的用来查找建筑配置的名字
		public var PosX:Number;			// 初始化场景中的坐标
		public var PosY:Number;			// 初始化场景中的坐标
		public var State:int;					// 建筑的状态
		public var bclick:Boolean;			// 建筑是否可以点击
		
		public function SceneBuildersVO(){}
		
		public function clone():IDataVO
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}