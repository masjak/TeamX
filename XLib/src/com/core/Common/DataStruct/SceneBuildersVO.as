package com.core.Common.DataStruct
{
	public class SceneBuildersVO implements IDataVO
	{
		public var sceneId:String;// 在场景中的名字
		public var tableId:String;// 实际的用来查找建筑配置的名字
		public var PosX:Number;			// 初始化场景中的坐标
		public var PosY:Number;			// 初始化场景中的坐标
		public var State:int;					// 建筑的状态
		public var bclick:Boolean;			// 建筑是否可以点击
		public var blindLight:String;		// 绑定灯光
		public var blindOfferX:Number;	// 绑定灯光偏移X
		public var blindOfferY:Number;	// 绑定灯光偏移Y
		
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