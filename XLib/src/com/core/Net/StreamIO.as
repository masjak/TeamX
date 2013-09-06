package  com.core.Net
{
	import flash.utils.ByteArray;
	
	/**
	 * 网络包类 主要管理包体 和解码 //  add by 卢成浩 2012-7-10
	 */
	public class StreamIO
	{
		protected var _length:int = 0; // 数据长度
		private var pointer:int;	// 写入时候的指针位置
		private var _body:ByteArray; // 协议包体
		
		public function StreamIO()
		{
			intLength = 0;
			pointer = 0;
			body = null;
		}
		
		public function get intLength():int
		{
			return _length;
		}
		
		public function set intLength(value:int):void
		{
			_length = value;
		}

		public function get body():ByteArray
		{
			return _body;
		}

		public function set body(value:ByteArray):void
		{
			_body = value;
			if(body != null)
			{
				_length = body.length;
			}
		}

		
	}
}