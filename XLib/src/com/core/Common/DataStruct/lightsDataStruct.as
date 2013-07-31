package com.core.Common.DataStruct
{
	public class lightsDataStruct implements IDataStruct
	{
		public var name:String;
		public var path:String;
		public var PosX:Number;
		public var PosY:Number;
		public var State:int;
		
		public function lightsDataStruct(){}
		
		public function clone():IDataStruct
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}