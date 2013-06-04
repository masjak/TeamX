package com.knr.utils.Serial
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * 序列化二进制对象
	 * @author haog
	 * 2013-5-23
	 */
	public class SerialBinary
	{	
		/**
		 * 把任意数据对象写为二进制 注意：1不能序列化可显示对象 2不能序列化带构造参数的对象
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function SerialBin(obj:*):ByteArray
		{
			// 先将别名注册进二进制 后面可以才能还原
			var className:String = getQualifiedClassName(obj);
			registerClassAlias(className,getDefinitionByName(className) as Class);
			var ba:ByteArray = new ByteArray();             
			ba.writeObject(obj);  
			ba.position = 0;
			return ba;
		}
		
		/**
		 * 把2进制序列化为对象
		 * @param ba
		 * @return 
		 * 
		 */		
		public static function readBin(ba:ByteArray):*
		{	
			if(ba == null)
			{
				trace("SerialBinary Serial error!! ba is null");
				return null;	
			}
			ba.position = 0; 
			var obj:* = ba.readObject();  
			return obj;

		}
	}
}