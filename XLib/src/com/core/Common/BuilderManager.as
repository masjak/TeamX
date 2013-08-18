package com.core.Common
{
	import com.core.Common.DataStruct.buildersVO;

	public class BuilderManager
	{
		protected static var _data:Object = {};
		
		function BuilderManager(){}
		
		/**场景配置数据*/
		protected static function get sceneData():Object {return _data;}

		public static function readXml(xml:XML):void
		{
			var len:int = xml.builder.length();
			for(var i:int = 0; i < len; i++)
			{
				var bvo:buildersVO = new buildersVO;
				bvo.name =  xml.builder[i].@name;
				bvo.path =    xml.builder[i].@path;
				bvo.canMove =    (xml.builder[i].@canMove == "true" );
				// 保存数据
				_data[bvo.name] = bvo;
			}
		}
		
		public static function getBuilderVO(name:String):buildersVO
		{
			return _data[name];
		}
		
		/**销毁*/		
		public static function dispose():void
		{
			_data = null;
		}
	}
}