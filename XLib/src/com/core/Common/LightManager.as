package com.core.Common
{
	import com.core.Common.DataStruct.LightsVO;

	public class LightManager 
	{
		protected static var _data:Object = {};
		
		function LightManager(){}
		
		/**场景配置数据*/
		protected function get lightData():Object {return _data;}

		public function readXml(xml:XML):void
		{
			var len:int = xml.light.length();
			for(var i:int = 0; i < len; i++)
			{
				var lvo:LightsVO = new LightsVO;
				lvo.tableId =  xml.light[i].@name;
				lvo.path =    xml.light[i].@path;
				lvo.State =   xml.light[i].@State;
				
				// 保存数据
				_data[lvo.tableId] = lvo;
			}
		}
		
		public function getLightVO(name:String):LightsVO
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