package  com.core.Net
{
	

	/**
	 * 链接池 网络相关模块的handle类 //  add by 卢成浩 2012-7-10
	 */
	
	public class ClientConnPool
	{
		
		/**ResHandler实例*/
		//private static var	resHandler:ResHandler;	
		//private static var	loginHandler:LoginHandler;
		//private static var	roleHandler:RoleHandler;
		//private static var	taskHandler:TaskHandler;
		//private static var	skillHandler:SkillHandler;
		//private static var	roomHandler:RoomHandler;
		//private static var	battleHandler:BattleHandler;
		//private static var	itemHandler:ItemHandler;
		//private static var	attachHandler:AttachHandler;
		//private static var sociatyHandler:SociatyHandler;
		//private static var pveHandler:PveHandler;
		//private static var mailHandler:MailHandler;
		//private static var fameHallHandler:FameHallHandler;
		//private static var auctionHandler:AuctionHandler;
		//private static var elementHandler:ElementHandler;
		//private static var podiumHandler:PodiumHandler;
		
		public function ClientConnPool()
		{
		}
		
		/**
		 * 关闭网络
		 */
		public static function close():void
		{
//			ClientConnPool.getGameConn().close();
		}
		
//		/**
//		 * 获取网络连接的单例
//		 */
//		public static function getGameConn():SocketConn
//		{
//			if(gameConn == null)
//			{
//				gameConn	= new SocketConn();
//			}
//			return gameConn;
//		}
		
//		/**
//		 * 检查是否超时
//		 */
//		public static function isNetTimeout():Boolean
//		{
//			if(getGameConn().isNetTimeout())
//			{
//				return true;
//			}
//			return false;
//		}
		
		/**
		 * 设置超时时间
		 */
		public static function setNetTimeout( timeout:Boolean):void
		{
//			gameConn.setNetTimeout(timeout);
		}
		
//		public static function getResHandler():ResHandler 
//		{
//			if(resHandler == null)
//			{
//				resHandler = new ResHandler(0x0f);
//			}
//			return resHandler;
//		}
//		
//		public static function  getLoginHandler():LoginHandler
//		{
//			if(loginHandler == null)
//			{
//				loginHandler = new LoginHandler(0x0);
//			}
//			return loginHandler;
//		}
//		
//		public static function  getRoleHandler():RoleHandler
//		{
//			if(roleHandler == null)
//			{
//				roleHandler = new RoleHandler(0x1);
//			}
//			return roleHandler;
//		}
//		
//		public static function  getTaskHandler():TaskHandler
//		{
//			if(taskHandler == null)
//			{
//				taskHandler = new TaskHandler(0x2);
//			}
//			return taskHandler;
//		}
		
//		public static function  getSkillHandler():SkillHandler
//		{
//			if(skillHandler == null)
//			{
//				skillHandler = new SkillHandler(0x7);
//			}
//			return skillHandler;
//		}
//		
//		public static function  getRoomHandler():RoomHandler
//		{
//			if(roomHandler == null)
//			{
//				roomHandler = new RoomHandler(0x3);
//			}
//			return roomHandler;
//		}
//		
//		public static function  getBattleHandler():BattleHandler
//		{
//			if(battleHandler == null)
//			{
//				battleHandler = new BattleHandler(0x5);
//			}
//			return battleHandler;
//		}
//		
//		public static function  getPveHandler():PveHandler
//		{
//			if(pveHandler == null)
//			{
//				pveHandler = new PveHandler(0x6);
//			}
//			return pveHandler;
//		}
//		
//		public static function  getItemHandler():ItemHandler
//		{
//			if(itemHandler == null)
//			{
//				itemHandler = new ItemHandler(0x08);
//			}
//			return itemHandler;
//		}
//		
//		public static function  getAttachHandler():AttachHandler
//		{
//			if(attachHandler == null)
//			{
//				attachHandler = new AttachHandler(0xa);
//			}
//			return attachHandler;
//		}
//		
//		public static function  getSociatyHandler():SociatyHandler
//		{
//			if (sociatyHandler == null) {
//				sociatyHandler = new SociatyHandler(0xb);
//			}
//			return sociatyHandler;
//		}
//		
//		public static function  getMailHandler() :MailHandler
//		{
//			if (mailHandler == null) {
//				mailHandler = new MailHandler(0x4);
//			}
//			return mailHandler;
//		}
//		
//		public static function  getFameHallHandler():FameHallHandler
//		{
//			if (fameHallHandler == null) {
//				fameHallHandler = new FameHallHandler(0x10);
//			}
//			return fameHallHandler;
//		}
//		
//		public static function  getAuctionHandler():AuctionHandler
//		{
//			if (auctionHandler == null) 
//			{
//				auctionHandler = new AuctionHandler(0x9);
//			}
//			return auctionHandler;
//		}
		
//		public static function getElementHandler():ElementHandler
//		{
//			if (elementHandler == null)
//			{
//				elementHandler = new ElementHandler(0xe);
//			}
//			return elementHandler;
//		}
//		
//		public static function getPodiumHandler():PodiumHandler
//		{
//			if (podiumHandler == null)
//			{
//				podiumHandler = new PodiumHandler(0x12);
//			}
//			return podiumHandler;
//		}
		
		/**
		 * 发送网络包
		 */
		public static function send( out:Packet):void
		{
//			out.setId(WriteThread.getHeroID());
//			ClientConnPool.getGameConn().handleClientRequest(out);
		}
		
		/**
		 * 
		 */
		public static function isIdle():Boolean
		{
			var size:int = getSize();
			if(size < 2)
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 获取网络包的现有数量
		 */
		public static function getSize():int
		{
//			var write:WriteThread = gameConn.writeThread;
//			if(write != null)
//			{
//				var size:int = write.getQueueSize();
//				return size;
//			}
			return 999;
		}
		
		/**
		 * 解析单个网络包
		 */
		public static function parsePacket( p:Packet):void
		{
			var t:int = p.shortProtocolNo;
			var bt:int = t>>8;
			switch(bt)
			{
				case 0x0f:
		//			ConnPool.getResHandler().parse(p);
					break;
				case 0x00:
//					ConnPool.getLoginHandler().parse(p);
					break;
				case 0x01:
			//		ConnPool.getRoleHandler().parse(p);
					break;
				case 0x02:
//					ConnPool.getTaskHandler().parse(p);
					break;
				case 0x03:
				//	ConnPool.getRoomHandler().parse(p);
					break;
				case 0x04:
//					ConnPool.getMailHandler().parse(p);
					break;
				case 0x05:
				//	ConnPool.getBattleHandler().parse(p);
					break;
				case 0x06:
				//	ConnPool.getPveHandler().parse(p);
					break;
				case 0x07:
				//	ConnPool.getSkillHandler().parse(p);
					break;
				case 0x08:
				//	ConnPool.getItemHandler().parse(p);
					break;
				case 0x9:
				//	ConnPool.getAuctionHandler().parse(p);
					break;
				case 0x10:
			//		ConnPool.getFameHallHandler().parse(p);
					break;
				case 0x0a:
//					ConnPool.getAttachHandler().parse(p);
					break;
				case 0x0b:
//					ConnPool.getSociatyHandler().parse(p);
					break;
				case 0xe:
//					ConnPool.getElementHandler().parse(p);
					break;
				case 0x12:
//					ConnPool.getPodiumHandler().parse(p);
					break;
				default:
					break;
			}
		}
		
		public static function destroyBattleHandler():void
		{
			//battleHandler = null;
		}
			
		
	}
}