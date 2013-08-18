package com.core.Common.DataStruct
{
	public class buildersVO implements IDataVO
	{
		public var name:String;
		public var path:String;
		public var PosX:Number;
		public var PosY:Number;
		public var State:int;
		
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