package com.core.Net
{
	

	/**
	 * 网络包类 主要管理包头 //  add by 卢成浩 2012-7-10
	 */
	public class Packet extends StreamIO
	{
		protected var shortType:int = -1;
		protected var intId:int = 0;	
		protected var byteVersion:int = 0x01;
		protected var byteOption:int;	
		protected var byteCallbackID:int;
		
		/**
		 * 构造函数 默认一个网络包类型参数
		 */
		public function Packet(type:int):void
		{
			byteVersion = 0x01;
			byteOption = 0;
			byteCallbackID = 0;
			setType(type);	
			super();
		}
		
		/**
		 *  获取子协议
		 */
		public function getOption():int
		{
			return byteOption;
		}
		
		/**
		 * 设置子协议
		 */
		public function setOption(option:int):void 
		{
			this.byteOption = option;
		}
		
		/**
		 *  获取类型
		 */
		public function getType():int
		{
			return shortType;
		}
		
		/**
		 * 设置协议类型
		 */
		public function setType(type:int):void
		{
			this.shortType = type;
		}
		
		/**
		 *  获取版本号
		 */
		public function getVersion():int 
		{
			return byteVersion;
		}
		
		/**
		 *  设置版本号
		 */
		public function setVersion(version:int):void 
		{
			this.byteVersion = version;
		}
		
		/**
		 *  获取ID
		 */
		public function getId():int
		{
			return intId;
		}
		
		/**
		 *  设置
		 */
		public function setId(id:int) :void
		{
			this.intId = id;
		}
		
		/**
		 *  获取回调ID
		 */
		public function getCallbackID():int
		{
			return byteCallbackID;
		}
		
		/**
		 *  设置回调ID
		 */
		public function setCallbackID(callbackID:int) :void
		{
			this.byteCallbackID = callbackID;
		}
		
	}
}