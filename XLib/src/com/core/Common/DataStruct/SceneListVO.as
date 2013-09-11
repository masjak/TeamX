package com.core.Common.DataStruct
{

	public class SceneListVO implements IDataVO
	{
		/** 场景Id*/
		public var sceneId:String;
		/** 场景配置路径*/
		public var scenePath:String;
		/** 场景类型*/
		public var sceneType:int;
		
		public function clone():IDataVO
		{

			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}