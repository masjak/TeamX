package com.core.Utils.Serial
{
	import flash.net.registerClassAlias;

	/**
	 * 序列化基类
	 * 主要用将对象中的属性输出为key=value的形式
	 * @author haog
	 * 2013-5-23
	 */	
	public class Serializer implements Serializable
	{
		private var serializationVars:Array; //存储对象的属性         
		private var serializationObj:Serializable; //指向可序列化的对象引用         
		private var recordSeparator:String = ","; //指定属性之间的分隔符 
		protected var name:String = "Serializer";
		
		public function Serializer()
		{
			setSerializationObj(this);
			registerClassAlias(name,Serializer);
		}
		
		/**设置序列化对象名称组合*/
		public function setSerializationVars(vars:Array):void
		{            
			serializationVars = vars;         
		}   
		
		/**指定需要序列话的对象*/
		public function setSerializationObj(obj:Serializable):void
		{             
			serializationObj = obj;         
		}
		
		/**设置分隔符*/
		public function setRecordSeparator(rs:String):void
		{             
			recordSeparator = rs;   
		}
		
		/**把属性序列化为KEY=VALUE的形式输出*/		
		public function serialize():String
		{
			var s:String = "";
			var len:int = serializationVars.length;
			for (var i:int = len; --i >= 0;)
			{                 
				s += serializationVars[i] + "=" + String(serializationObj[serializationVars[i]]);
				if(i>0)
				{                    
					s += recordSeparator;                 
				}             
			}             
			return s;
		}
	}
}