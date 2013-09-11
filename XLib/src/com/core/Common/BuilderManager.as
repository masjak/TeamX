package com.core.Common
{
	import com.Game.Globel.Constants;
	import com.core.Common.DataStruct.BuildersVO;

	public class BuilderManager 
	{
		protected static var _data:Object = {};
		
		function BuilderManager(){}
		
		/**场景配置数据*/
		protected function get builderData():Object {return _data;}

		public function readXml(xml:XML):void
		{
			var len:int = xml.StringText.length();
			for(var i:int = 0; i < len; i++)
			{
				var bvo:BuildersVO = new BuildersVO;
				
				//  表格中的固定数据数据
				bvo.tableId =  xml.StringText[i].@templetId;
				bvo.name =  xml.StringText[i].@name;
				bvo.level =  xml.StringText[i].@level;
				bvo.eventsType =  xml.StringText[i].@eventsType;
				bvo.avatarType =  xml.StringText[i].@avatarType;
				bvo.functionType =  xml.StringText[i].@functionType;
				bvo.bindNpc =  xml.StringText[i].@bindNpc;
				bvo.hp =  xml.StringText[i].@hp;
				bvo.armor =  xml.StringText[i].@armor;
				bvo.resourceType =  xml.StringText[i].@resourceType;
				bvo.outputSpeed =  xml.StringText[i].@outputSpeed;
				bvo.resourceLimit =  xml.StringText[i].@resourceLimit;
				bvo.buildingFormula =  xml.StringText[i].@buildingFormula;
				bvo.upgradeFormula =  xml.StringText[i].@upgradeFormula;
				bvo.costTime =  xml.StringText[i].@costTime;
				bvo.des =  xml.StringText[i].@des;
				
				// 扩展的逻辑数据
				bvo.path =   BuildersVO.buildPath + bvo.avatarType + "." + Constants.GAME_RES_TYPE;
				bvo.canMove =    (bvo.eventsType >> Constants.BUILDER_EVENT_TYPE_FREE);
				bvo.clickEffect =   Constants.CLICK_EFFECT_SHAKE;
				
				// 保存数据
				_data[bvo.tableId] = bvo;
			}
			
			trace("builder data loader complete!!!");
		}
		
		public function getBuilderVO(name:String):BuildersVO
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