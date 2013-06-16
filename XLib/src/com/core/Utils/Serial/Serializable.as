package com.core.Utils.Serial
{
	/**可序列化接口
	 * 
	 * @author haog
	 * 2013-5-23
	 */	
	public interface Serializable
	{
		/**
		 *把对象序列化输出为string存储
		 */		
		function serialize():String;
	}
}