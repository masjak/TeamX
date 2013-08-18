package com.core.Common.DataStruct
{
	public class buildersVO implements IDataVO
	{
		public var name:String; // 名字
		public var path:String;// 路径
		public var canMove:Boolean;// 是否接受点击
		
		public function buildersVO(){}
		
		public function clone():IDataVO
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}