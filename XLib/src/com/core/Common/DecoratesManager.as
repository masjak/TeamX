package com.core.Common
{
	import com.core.Common.DataStruct.DecoratesVO;
	

	public class DecoratesManager 
	{
		protected static var _data:Object = {};
		
		function DecoratesManager(){}
		
		/**场景配置数据*/
		protected function get decoratesData():Object {return _data;}

		public function readXml(xml:XML):void
		{
			var len:int = xml.decorates.length();
			for(var i:int = 0; i < len; i++)
			{
				var bvo:DecoratesVO = new DecoratesVO;
				bvo.name =  xml.decorate[i].@name;
//				bvo.path =    xml.builder[i].@path;
//				bvo.canMove =    (xml.builder[i].@canMove == "true" );
//				bvo.clickEffect =   xml.builder[i].@clickEffect;
				
				// 保存数据
				_data[bvo.name] = bvo;
			}
		}
		
		public function getDecoratesVO(name:String):DecoratesVO
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