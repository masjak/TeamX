package  com.core.Net
{
	import flash.utils.ByteArray;
	
	/**
	 * 网络包类 主要管理包体 和解码 //  add by 卢成浩 2012-7-10
	 */
	public class StreamIO
	{
		private var length:int = 0;
		private var pointer:int;
		private var body:ByteArray;
		
		public function StreamIO()
		{
			length = 0;
			pointer = 0;
			body = null;
		}
		
		/**
		 * 获取包体
		 */
		public function getBody():ByteArray 
		{
			return body;
		}
		
		/**
		 * 设置包体
		 */
		public function setBody( body:ByteArray):void
		{
			this.body = body;
			if(body != null)
			{
				setLength(body.length);
			}
		}
		
		/**
		 * 获取长度
		 */
		public function getLength():int
		{
			return length;
		}
		
		/**
		 * 设置长度
		 */
		protected function setLength(length:int):void
		{
			this.length = length;
		}
		
		/**
		 * 获取读取指针
		 */
		public function getPointer():int 
		{
			return pointer;
		}
		
		/**
		 * 让指针跳过指定长度
		 */
		public function skip(skipLength:int):void
		{
			this.pointer += skipLength;
		}
		
		/**
		 * 解码byte
		 */
		public function decodeByte():int 
		{
			var result:int = body[getPointer()];
			skip(1);
			return result;
		}
		
		/**
		 * 解码bool
		 */
		public function decodeBoolean():Boolean 
		{
			var result:int = body[getPointer()];
			skip(1);
			return result==1;
		}
		
		/**
		 * 解码short
		 */
		public function decodeShort():int
		{
			var result:int = Encoder.readShort(getPointer(), body);
			skip(2);
			return result;
		}
		
		/**
		 * 解码short
		 */
		public function decodeShort2Int():int 
		{
			return decodeShort() & 0xFFFF;
		}
		
		/**
		 * 解码int
		 */
		public function decodeInt():int
		{
			var result:int = Encoder.readInt(getPointer(), body);
			skip(4);
			return result;
		}
		
		/**
		 * 解码string
		 */
		public function decodeString():String 
		{
			var length:int = decodeShort();
			var result:String = Encoder.readString(getPointer()-2, body);
			skip(length);
			return result;
		}

		/**
		 * 解码指定长度的string 
		 */
		public function decodeStringByLength(strlength:int):String 
		{
			try {
					if(body[getPointer()] == -17
						&&body[getPointer()+1] == -69
						&&body[getPointer()+2] == -65)
					{
						skip(3);
						strlength-=3;
					}
					var Ba:ByteArray = new ByteArray();
					Ba.readBytes(body,getPointer(),strlength);
				} 
			catch (error:Error) 
			{
				trace("Unable to Load File: " + error);
			}
			skip(strlength);
			return Ba.toString();
		}
		
		/**
		 * 向包体写入一个二进制数组
		 */
		public function enterByteArray(bytes:ByteArray):void
		{
			var Ba:ByteArray = new ByteArray();
			if(body == null)
			{
				body = bytes;
			}
			else 
			{
				if(body.length < pointer+bytes.length)
				{
					Ba.writeBytes(body,0,pointer);
					Ba.writeBytes(bytes,0,bytes.length);
				}
				else
				{
					body.writeBytes(bytes,0,pointer + bytes.length);
				}
				body = Ba;
			}
			pointer += bytes.length;
			setLength(pointer);
		}
		
		/**
		 * 向包体写入string
		 */
		public function enterStr(str:String):void
		{
			var bytes:ByteArray = Encoder.getBytes(str);
			enterByteArray(bytes);
		}
		
		/**
		 * 向包体写入byte
		 */
		public function enterByte(onebyte:int):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeByte(onebyte);
			enterByteArray(bytes);
		}
		
		/**
		 * 向包体写入一个bool
		 */
		public function enterBool( bln:Boolean):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeBoolean(bln);
				enterByteArray(bytes);
		}
		
		/**
		 * 向包体写入一个int
		 */
		public function enterInt(i:int):void
		{
			enterByteArray(Encoder.int2Bytes(i));
		}
		
		/**
		 * 向包体写入short
		 */
		public function enterShort(s:int):void
		{
			enterByteArray(Encoder.short2Bytes(s));
		}
		
		/**
		 * 解码二进制数组
		 */
		public function decodeBytes( count:int):ByteArray
		{
			var Ba:ByteArray = new ByteArray();
			for(var i:int = 0; i < count; i++)
			{
				Ba.writeByte(this.decodeByte());
			}
			return Ba;
		}
		
		/**
		 * 解码short
		 */
		public function decodeShorts( count:int):Array
		{
			var shortAy:Array = new Array[count];
			for(var i:int = 0; i < count; i++)
			{
				shortAy[i] = this.decodeShort();
			}
			return shortAy;
		}
		
		/**
		 * 解码int
		 */
		public function decodeInts(count:int):Array
		{
			var intAy:Array = new Array[count];
			for(var i:int = 0; i < count; i++)
			{
				intAy[i] = this.decodeInt();
			}
			return intAy;
		}
		
		/**
		 * 解码string
		 */
		public function decodeStrings(count:int):Array
		{
			var strAy:Array = new Array[count];
			for(var i:int = 0; i < count; i++)
			{
				strAy[i] = this.decodeString();
			}
			return strAy;
		}
		
	}
}