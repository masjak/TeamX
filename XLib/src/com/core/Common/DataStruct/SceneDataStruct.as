package com.core.Common.DataStruct
{
	import flash.geom.Rectangle;

	public class SceneDataStruct implements IDataStruct
	{
		/** 场景Id*/
		public var sceneId:String;
		/**tile Map横向的宽度*/
		public var mapWidth:Number;
		/**tile Map纵向的高度*/
		public var mapHeight:Number;
		/**tile 的宽*/
		public var tileWidth:Number;
		/**tile 的高*/
		public var tileHeight:Number;	
		/**横向格子数*/
		public var widthNum:Number;
		/**纵向格子数*/
		public var heightNum:Number;	
		/**寻路点源 */
		public var roadmap:String;	
		/**atf的format格式*/
		public var atfFormat:String;		
		/**初始化场景状态*/
		public var initState:int;		
		/**初始化显示场景的rect*/
		public var initRect:Rectangle;	
		
		/**builders配置*/
		public var builders:Object = new Object;	
		/**lights配置*/
		public var lights:Object = new Object;	
		
		public function SceneDataStruct(){}
		
		public function clone():IDataStruct
		{
//			var sd:SceneDataStruct = new SceneDataStruct;
//			sd.sceneId = this.sceneId;
//			sd.mapWidth = this.mapWidth;
//			sd.mapHeight = this.mapHeight;
//			sd.tileWidth = this.tileWidth;
//			sd.tileHeight = this.tileHeight;
//			sd.roadmap = this.roadmap;
//			sd.atfFormat = this.atfFormat;
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}