package com.core.Common.DataStruct
{
	public class BuildersVO implements IDataVO
	{
		public static const buildPath:String = "/builder/";
		
		// 扩展的字段
		public var sceneId:String; // 在场景中的名字
		public var path:String;// 路径
		public var canMove:Boolean;// 是否可以移动
		public var clickEffect:int;			// 建筑的点击效果
		
		// 从表中读取的字段
		public var tableId:String; // 名字
		public var name:String;// 建筑名字
		public var level:int;// 建筑等级
		public var eventsType:int;// 建筑事件类型 是否可破坏
		public var avatarType:String;// 建筑模型名称
		public var functionType:String;// 建筑功用 // shop magicCenter trainHp trainAttack prayCenter house
		public var bindNpc:String;	   // 绑定的NPC 有可能不止一个 用string 存储
		public var hp:int;	   				// 当前生命值
		public var armor:String;	   	// 护甲类型
		public var resourceType:String;	   	// 资源类型  gold magicEnergy
		public var outputSpeed:int;	   	// 资源产出速度
		public var resourceLimit:int;	   	// 资源产出上限
		public var buildingFormula:String;	   	// 建造配方
		public var upgradeFormula:String;	   	// 升级配方
		public var costTime:String;	   			  // 升级消耗时间
		public var des:String;	   			  		// 描述
		
		public function BuildersVO(){}
		
		public function clone():IDataVO
		{
			
			
			return null;
		}
		
		public function dispose():void
		{
		}
	}
}