package com.core.Common
{
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;

	public class SignalManager implements IDispose
	{
		
		/***信号槽**/
		protected var _signal:Object = {};
		
		public function SignalManager()
		{
		}
		
		
		
		/**
		 * 添加一个新的信号事件
		 */
		public function addSignal(id:String, o:Object):void
		{
			if(this._signal.hasOwnProperty(id))
			{
				trace("signal with id '" + id + "' already defined. Cannot add two signal with the same id.");
				return;
			}
			
			var signal:DeluxeSignal = new DeluxeSignal(o);
			this._signal[id] = signal;
		}
		
		/**
		 * 注册一个信号回调
		 */
		public function registerSignalListener(id:String, f:Function):void
		{
			if(!this._signal.hasOwnProperty(id))
			{
				trace("signal with id '" + id + "' not found. Cannot register callback function.");
				return;
			}
			(this._signal[id] as DeluxeSignal).add(f) ;
		}
		
		/**
		 * 注册一个信号回调
		 */
		public function removeSignalListener(id:String, f:Function):void
		{
			if(!this._signal.hasOwnProperty(id))
			{
				trace("signal with id '" + id + "' not found. Cannot register callback function.");
				return;
			}
			(this._signal[id] as DeluxeSignal).remove(f) ;
		}
		
		/**
		 * 移除一个信号事件
		 */
		public function removeSignal(id:String):void
		{
			if(!this._signal.hasOwnProperty(id))
			{
				trace("signal '" + id + "' cannot be removed because it has not been added.");
				return;
			}
			
			// 移除全部监听
			var signal:DeluxeSignal = this._signal[id];
			signal.removeAll()
			
			_signal[id] = null;
			delete this._signal[id];
		}
		
		/**
		 * 分发一个信号事件
		 */
		public function dispatchSignal(id:String,o:Object):Boolean
		{
			var signal:DeluxeSignal = this._signal[id];
			if(signal != null)
			{
				signal.dispatch(new GenericEvent(),o);
				return true;
			}
			
			return false;
		}
		
		/**
		 * 根据ID获取信号
		 */
		public function getSignal(id:String):DeluxeSignal
		{	
			return this._signal[id];
		}
		
		public function dispose():void
		{
			for (var id:String in this._signal)
			{
				// 移除事件
				removeSignal(id);
			}
		}
	}
}