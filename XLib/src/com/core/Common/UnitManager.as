package com.core.Common
{
	import com.core.Common.DataStruct.UnitsVO;
	import com.core.Common.DataStruct.buildersVO;

	public class UnitManager 
	{
		protected static var _data:Object = {};
		
		function UnitManager(){}
		
		/**场景配置数据*/
		protected function get UnitData():Object {return _data;}

		public function readXml(xml:XML):void
		{
			var len:int = xml.unit.length();
			for(var i:int = 0; i < len; i++)
			{
				var bvo:UnitsVO = new UnitsVO;
				bvo.name =  xml.builder[i].@name;
//				bvo.path =    xml.builder[i].@path;
//				bvo.canMove =    (xml.builder[i].@canMove == "true" );
//				bvo.clickEffect =   xml.builder[i].@clickEffect;
				
				// 保存数据
				_data[bvo.name] = bvo;
			}
		}
		
		public function getUnitVO(name:String):buildersVO
		{
			return _data[name];
		}
		
		/**销毁*/		
		public function dispose():void
		{
			_data = null;
		}
	}
}