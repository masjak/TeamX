package com.core.Net
{
	import flash.utils.ByteArray;

	/**
	 * 网络数据的解码类 //  add by 卢成浩 2012-7-10
	 */
	
	
	public class Encoder
	{
		
		public static var FORMATION:String = "formation";
		public static var BACKFORMATION:String = "backformation";
		
		private static var strOrderMode:String = Encoder.BACKFORMATION;
		
		public function Encoder()
		{
			
		}
		
		/**
		 * 设置字节读取顺序 大端还是小端
		 */
		public function setOrderMode(strMode:String):void
		{
			strOrderMode = strMode;
		}
		
		/**
		 * 获取服务器IP
		 */
		public static function readServerIP(offset:int, packetBody:ByteArray):String 
		{
			
			var length:int = packetBody[offset++];
			if(length < 0)	length = 256 + length;
			
			var Ba:ByteArray = new ByteArray();
			Ba.writeBytes(packetBody,offset,length);
			Ba.position = 0;
			return Ba.toString();
		}

		/**
		 * 将二进制数组转化成完整的网络包
		 */
		public static function Bytes2packet( Ba:ByteArray,p:Packet):void
		{
			// 跳过指定的字节序
			p.byteAppType 		= Ba.readByte();							
			p.byteProType 		= Ba.readByte();
			p.byteEncryption 	=Ba.readByte();
			p.intReserve 			= Ba.readInt();								// 预留字段4字节
			p.shortProtocolNo = Ba.readShort(); // 协议号
			
			// 把剩下的字节都作为包体
			p.body  = new ByteArray;
			if(p.intLength > 0)
			{
				Ba.readBytes(p.body,17,p.intLength);
			}	
			
		}
		
		/**
		 * 将网络包转化为二进制数组
		 */
		public static function packet2Bytes( op:Packet):ByteArray
		{
			 var b:ByteArray = new ByteArray(); 
			 b.writeInt(op.intHead);	// 4
			 b.writeInt(op.intLength + Packet.PacketLengthOffer);//4
			 b.writeByte(op.byteAppType);//1
			 b.writeByte(op.byteProType);//1
			 b.writeByte(op.byteEncryption);//1
			 b.writeInt(op.intReserve);			//4
			 b.writeShort(op.shortProtocolNo);//2
			 if(op.body != null)
			 {
				 b.writeBytes(op.body);
			 }
				return b;
		}
		
	}
}