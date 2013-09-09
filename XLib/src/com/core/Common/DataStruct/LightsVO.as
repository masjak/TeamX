package com.core.Common.DataStruct
{
	public class LightsVO implements IDataVO
	{
		public var name:String;
		public var path:String;
		public var State:int;
		
		public function LightsVO(){}
		
		public function clone():IDataVO
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}