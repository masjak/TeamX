package com.core.Net
{
	

	/**
	 * 网络包类 主要管理包头 //  add by 卢成浩 2012-7-10
	 */
	public class Packet extends StreamIO
	{
		public static const PacketHeadLength:int = 17; // 包头17个字节
		public static const PacketLengthOffer:int = 9; // length的偏移字节数(1+1+1+4+2)
		
		protected var _intHead:int = 0xabcd; // 固定的包头 4字节
//		length 在父类中定义	4字节		 				// 
		protected var _byteAppType:int = 0x0001; // 应用表示 用于区分是服务器和客户端通信还是和别的服务器通信 1字节
		protected var _byteProType:int = 0x0001; // 协议类型 1字节
		protected var _byteEncryption:int = 1; // 是否加密     1字节
		protected var _intReserve:int = 1; // 保留字节     4字节
		protected var _shortProtocolNo:int = 0; // 是否加密     2字节
// 		byte[] 协议内容体
		
		/** * 构造函数 默认一个网络包类型参数*/
		public function Packet(ProtocolNo:int):void
		{
			_shortProtocolNo = ProtocolNo;	
			super();
		}

		
		public function get intHead():int
		{
			return _intHead;
		}
		
		public function set intHead(value:int):void
		{
			_intHead = value;
		}
		
		public function get byteAppType():int
		{
			return _byteAppType;
		}

		public function set byteAppType(value:int):void
		{
			_byteAppType = value;
		}

		public function get byteProType():int
		{
			return _byteProType;
		}

		public function set byteProType(value:int):void
		{
			_byteProType = value;
		}

		public function get byteEncryption():int
		{
			return _byteEncryption;
		}

		public function set byteEncryption(value:int):void
		{
			_byteEncryption = value;
		}

		public function get intReserve():int
		{
			return _intReserve;
		}

		public function set intReserve(value:int):void
		{
			_intReserve = value;
		}

		public function get shortProtocolNo():int
		{
			return _shortProtocolNo;
		}

		public function set shortProtocolNo(value:int):void
		{
			_shortProtocolNo = value;
		}

	}
}