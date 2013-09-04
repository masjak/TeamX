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
		
		// 因为移植的原因 服务器默认是是倒序模式组合数据 这里也默认倒序 add by 卢成浩 2012-7-3
		
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
		 * 读一个short字节
		 */
		public static  function readShort(offset:int, packetBody:ByteArray):int
		{
			return getShortFrom2Byte(packetBody[offset++], packetBody[offset]);
		}
		
		/**
		 * 把2个byte拼合成一个short
		 */
		public static function getShortFrom2Byte( high8bit:int, low8bit:int):int 
		{
			if( strOrderMode == Encoder.FORMATION)
			{
				return ((high8bit << 8) | low8bit & 0xFF);
			}
			else
			{
				return ((low8bit << 8) | high8bit & 0xFF);
			}
		}
		
		/**
		 *  把一个字符串转变为一个二进制数组
		 */
		public static function getBytes(input:String):ByteArray
		{
			return string2Bytes(input);
		}
		
		/**
		 * 把字符串转码为GBK格式
		 */
		public static function getBytes_GBK(str:String):ByteArray
		{
			return Encoder.UnicodeToOtherCoding(str,"gbk");
		}
		
		/**
		 * 从二进制数组读一个string
		 */
		public static function readString(offset:int, packetBody:ByteArray):String 
		{
			var length:int = readShort(offset, packetBody);
			offset += 2;
			if(length > packetBody.length - offset)
			{
				length = packetBody.length - offset;
			}
			var Ba:ByteArray = new ByteArray();
			Ba.writeBytes(packetBody,offset,length);
			Ba.position = 0;
			return Ba.toString();
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
		 * short转为二进制数组
		 */
		public static function short2Bytes( input:int):ByteArray
		{
			var result:ByteArray = new ByteArray();
			result.writeByte(input & 0xFF)
			result.writeByte((input >> 8) & 0xFF);
			return result;
		}
		
		/**
		 * 将二进制数组转化成完整的网络包
		 */
		public static function Bytes2packet( Ba:ByteArray):Packet
		{
			var length:int = Ba.length;
			if(length < 13)
			{
				return null;
			}
			else 
			{
				var p:Packet = new Packet(0x10);
				p.setType(Encoder.readShort(0,Ba));
				p.setId(Encoder.readInt(6,Ba));
				p.setOption(Ba[11]);
				p.setCallbackID(Ba[12]);
				
				if(length > 13)
				{
					var b:ByteArray = new ByteArray();
					b.writeBytes(Ba,13);
					p.setBody(b);
				}
			}
			
			return p;
		}
		
		/**
		 * 将网络包转化为二进制数组
		 */
		public static function packet2Bytes( out:Packet):ByteArray
		{
			
			 var b:ByteArray = new ByteArray(); /*new byte[13+out.getLength()]*/
				b.writeBytes(Encoder.short2Bytes(out.getType()));
				b.writeBytes(Encoder.int2Bytes(out.getLength()));
				b.writeBytes(Encoder.int2Bytes(out.getId()));
				b.writeByte(out.getVersion());
				b.writeByte(out.getOption());
				b.writeByte(out.getCallbackID());
				if(out.getBody() != null)
				{
					b.writeBytes(out.getBody());
				}
				return b;
		}
		
		/**
		 * 把Int转化为二进制数组
		 */
		public static function int2Bytes(number:int):ByteArray 
		{
			var b:ByteArray = new ByteArray();
			var result:int = 0;
			var t1:int = number & 0xff;
			var t2:int = (number << 8) & 0xff00;
			var t3:int = (number << 16) & 0xff0000;
			var t4:int = (number << 24) & 0xff000000;
			if( strOrderMode == Encoder.FORMATION)
			{
				b.writeByte(t4);
				b.writeByte(t3);
				b.writeByte(t2);
				b.writeByte(t1);
			}
			else
			{
				b.writeByte(t1);
				b.writeByte(t2);
				b.writeByte(t3);
				b.writeByte(t4);
			}
			return b;
		}
		
		/**
		 * 读取一个int类型
		 */
		public static function readInt(offset:int,packetBody:ByteArray):int
		{
			var result:int = 0;
			var t1:int = packetBody[offset++] & 0xff;
			var t2:int = (packetBody[offset++] << 8) & 0xff00;
			var t3:int = (packetBody[offset++] << 16) & 0xff0000;
			var t4:int = (packetBody[offset++] << 24) & 0xff000000;
			
			if( strOrderMode == Encoder.FORMATION)
			{
				result = t4 | t3 | t2 | t1;
			}
			else
			{
				result = t1 | t2 | t3 | t4;
			}
			return result;
		}
		
		/**
		 * 把string转化为二进制数组 默认为UTF8
		 */
		public static function  string2Bytes(str:String):ByteArray
		{
			try {
					var Ba:ByteArray = new ByteArray();
					Ba = Encoder.UnicodeToOtherCoding(str,"UTF-8");
					var length:int = Ba.length;
					var returnBa:ByteArray = new ByteArray();
					returnBa.writeByte(length & 0xFF);
					returnBa.writeByte((length >> 8) & 0xFF);
					returnBa.writeBytes(Ba);
					return returnBa;
				} 
			catch (error:Error) 
			{
				trace("Unable to Load File: " + error);
			}
			return null;
		}
		
		/**
		 * 字符转码接口
		 */
	public static function UnicodeToOtherCoding(str:String,codeType:String):ByteArray
		{
				// codeType 可以有gb2312，big5（繁体字），gbk，UTF-8
				var byte:ByteArray =new ByteArray();
				byte.writeMultiByte(str,codeType);
				return byte;
		}
		
	}
}