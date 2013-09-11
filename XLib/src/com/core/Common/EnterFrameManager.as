package com.core.Common
{
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class EnterFrameManager extends EventDispatcher implements IDispose
	{
		private var _funs:Object = {};
		
		public function EnterFrameManager()
		{
		}
		
		public function start():void
		{
			this.addEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		public function stop():void
		{
			this.removeEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		/**
		 *添加enterFrame处理事件
		 * @param name
		 * @param fun
		 * @param o
		 */		
		public function addFun(name:String,fun:Function,o:Object):void
		{
			if(_funs[name] != null)
			{
				throw new Error("the event name already exist! name = " + name);
			}
			if(fun != null)
			{
				var funM:funMap = new funMap;
				funM.fun = fun;
				funM.value = 0;
				_funs[name] = 	funMap;
			}
		}
		
		/***移除一个指定事件 */	
		public function removeFun(name:String):void
		{
			var funM:funMap = _funs[name];
			if(funM == null)
			{
				throw new Error("the event name no exist! name = " + name);
			}
			funM.dispose();
			_funs[name] = null;
		}
		
		/***enterFrame 事件 */	
		private function onEnter(e:Event):void
		{
			for each (var funM:funMap in _funs)
			{
				if(funM.fun != null)
				{
					funM.fun.call(e,funM.value);
				}
			}
		}
		
		/***销毁 */		
		public function dispose():void
		{
			for (var s:String in _funs)
			{
				removeFun(s);
			}
			
		}
		
	}
}



class funMap
{
	public var fun:Function;
	public var value:Object;
	public function dispose():void {fun = null};
	
}
