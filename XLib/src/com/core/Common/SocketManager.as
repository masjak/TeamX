package  com.core.Common
{
	//import com.ding.client.ui.FormLoginGUI;
	import com.Game.Globel.Constants;
	import com.core.Net.Encoder;
	import com.core.Net.Packet;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;

	/**
	 * 网络连接处理类 //  add by 卢成浩 2012-7-10
	 */
	public class SocketManager implements IDispose
	{
		private 		var socket:Socket;   // 网络通信主socket
		private 		var netTimeout:Boolean;// 超时
		protected 	var connID:Number;		// 连接id
		private 		var checkPing:Boolean;
		protected 	var lastPingTime:Number;		// 最后Ping的时间
		protected 	var outQueue:Vector.<Packet> = new Vector.<Packet>();
		protected 	var  inQueue:Vector.<Packet> = new Vector.<Packet>();
		
		private static var	PING_TIME_MAX:int	= 15*1000;// 最大的ping 响应时间
		private		var timer:Timer = new Timer(1000);		// 用来发送ping包
		
		private var connectIP:String;
		private var sendHead:Boolean;
		
		public function SocketManager(){};
		
		/** * 关闭socket*/
		public function close():void
		{
			closeById(false, this.connID);
		}
		
		/** * 关闭指定ID的socket*/
		public function closeById( timeout:Boolean,connID:Number):void
		{
				if(this.connID == connID && this.connID != 0)
				{
					this.connID = 0;
					try {
						if(socket != null)
						{
							if(timeout)
							{
								this.setNetTimeout(true);
							}
							checkPing = false;
							socket.close();
						}
					}
					catch (e:Error)
					{
						
					}
					socket = null;
					outQueue.length = 0;
				}
		}

		/*** 连接网络*/
		public function openDirect(connectIP:String,sendHead:Boolean = true):void
		{
			this.connectIP = connectIP;
			this.sendHead = sendHead;
			this.run();
		}
		
		public function run():void
		{
			this.connID = new Date().time;
			try {
				var colonDex:int = connectIP.indexOf(":");
				var host:String = connectIP.substring(0, colonDex);
				var portInt:int = int(connectIP.substring(colonDex+1, connectIP.length));
				
				if(socket.connected)
				{
					socket.close();
				}
				socket = new Socket();
				socket.timeout = 8*1000;
				socket.addEventListener(Event.CONNECT,onConnect);
				socket.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
				
				socket.connect(host, portInt);
				
			}
			catch (e:Error)
			{
				trace("socket Error! can't find socket!" + connectIP);
				this.closeById(true, this.connID);
			}
		}
		
		/**
		 * 检查超时
		 */
		public function checkTimeout():void
		{
			if(checkPing)
			{
				if(new Date().time - lastPingTime > 60*1000)
				{
					this.closeById(true, this.connID);
				}
			}
		}
		
		/**
		 * 设置超时
		 */
		public function setNetTimeout( netTimeout:Boolean):void
		{
			this.netTimeout = netTimeout;
		}
		
		/**
		 * 是否超时
		 */
		public function isNetTimeout():Boolean
		{
			return netTimeout;
		}
		
		public function setlastPongTime( lPongTime:int):void
		{
			this.lastPingTime = lPongTime;
		}
		
		/**
		 * 连接成功回调
		 */
		public function onConnect(e:Event):void
		{
			// 初始化发送相关
			timer.addEventListener(TimerEvent.TIMER,onRunWrite);
			timer.start();
			
			// 初始化接收相关
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			
			trace("Connect Success!!");
			
			this.lastPingTime = new Date().time;
			this.checkPing = true;
			
		}
			
		public function onIoError(e:IOErrorEvent):void
		{
			trace("无法连接到服务器！"+ e.text);
		}
		
		/**
		 * 向服务器发送
		 */
		private function  send(outPacket:Packet):void 
		{
			if(outPacket == null)
			{
				return;
			}
			socket.writeBytes(Encoder.packet2Bytes(outPacket));
			socket.flush();
			sendSuccessNotify();
		}
		
		/** * 发送ping包 */
		private function sendPing():void
		{
			send(new Packet(0xf2));
		}
		
		/** * 发送成功回调 */
		protected function sendSuccessNotify():void
		{
			lastPingTime =  new Date().time;
		}
		
		/** * 定时器发送ping包*/		
		private function onRunWrite(te:TimerEvent):void
		{
			try {
				if(outQueue.length > 0) 
				{
					var p:Packet = (outQueue.length > 0)?outQueue.shift():null;
					send(p);
					timer.delay = 1;
				}
				else
				{	
					sendPing();
					timer.delay = Constants.GAME_PING_DELAY;
				}
			} 
			catch (e:Error)
			{
				timer.stop();
				close();
			}
		}

		/**
		 *  解析数据包
		 */
		public function parsePacket():void
		{
			if(inQueue.length > 0)
			{
				var ip:Packet = inQueue.shift();
			}
		}
		
		/**
		 * 收到网络数据的回调
		 */
		public function onSocketData(e:ProgressEvent):void
		{
			trace( "Socket received " + socket.bytesAvailable + " byte(s) of data:" );
			try {
				// 字节至少要大于一个包头
				if(socket.bytesAvailable < Packet.PacketHeadLength)
				{
					return;
				}
				var ip:Packet = new Packet(0);
				ip.intHead = socket.readInt();
				
				// 包头没对上
				if(ip.intHead != 0xabcd)
				{
					return;
				}
				ip.intLength = socket.readInt();
				var ba:ByteArray = new ByteArray;
				socket.readBytes(ba,0,ip.intLength)
				Encoder.Bytes2packet(ba,ip);
				inQueue.push(ip);
			}
			catch(e:Error)
			{
				trace("socket error!!!!!!!====================>" + e.message);
//				close();
			}
			
		}
		
		/*** 销毁 *  */		
		public function dispose():void
		{
			close();
			outQueue.length = 0;
			inQueue.length = 0;
		}
		
		
	}
}