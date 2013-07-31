package com.core.Common.DataStruct
{
	public class buildersDataStruct implements IDataStruct
	{
		public var name:String;
		public var path:String;
		public var PosX:Number;
		public var PosY:Number;
		public var State:int;
		
		public function buildersDataStruct(){}
		
		public function clone():IDataStruct
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}